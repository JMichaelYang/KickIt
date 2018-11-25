import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kickit/apis/firestore/firestore_profile.dart';
import 'package:kickit/data/profile.dart';

/// Base class for a login handler.
abstract class LoginBase {
  /// Gets the uid of the currently logged in user.
  String get uid;

  /// Attempts to log the user in with a popup window.
  Future<bool> login({bool silently = false});

  /// Try to log out of the currently signed in account.
  Future<bool> logout();
}

/// Google login api handler.
class Login extends LoginBase {
  /// A single instance of the api handler.
  static final Login _instance = new Login._internal();

  /// The [FirebaseAuth] object for this app.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// The [FirebaseUser] object for this app.
  FirebaseUser _firebaseUser;

  /// Gets the uid of the currently logged in user.
  String get uid => _firebaseUser?.uid;

  /// Gets the display name of the currently logged in user.
  String get _name => _firebaseUser?.displayName;

  /// The [GoogleSignIn] object for this app.
  final GoogleSignIn _signIn = new GoogleSignIn();

  /// Internal constructor for the default value.
  Login._internal();

  /// Returns the current instance of [Login].
  factory Login() {
    return _instance;
  }

  /// Attempts to log the user in with a popup window.
  Future<bool> login({bool silently = false}) async {
    print("Signing in with Google.");

    // Log the user in with google.
    GoogleSignInAccount user =
        await (silently ? _signIn.signInSilently() : _signIn.signIn());

    if (user == null) {
      // If the user was not logged in, return false.
      return false;
    }

    final GoogleSignInAuthentication auth = await user.authentication;
    _firebaseUser = await _auth.signInWithGoogle(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );

    assert(_firebaseUser != null && !_firebaseUser.isAnonymous);

    _loadProfile();
    return true;
  }

  /// Try to log out of the currently signed in account.
  Future<bool> logout() async {
    if (!await _signIn.isSignedIn()) {
      return true;
    }

    bool signedOut = true;

    await _signIn.signOut().catchError(() => signedOut = false);
    await _auth.signOut().catchError(() => signedOut = false);

    return signedOut;
  }

  /// After loading a [Profile], either save it if it is a new one or update
  /// its information from the [GoogleSignIn].
  Future<Null> _loadProfile() async {
    Profile profile = await FirestoreProfile.getProfileById(uid).first;

    if (profile != null) {
      profile = this._profileFromGoogleSignInWithData(profile);
    } else {
      profile = this._profileFromGoogleSignIn();
    }

    FirestoreProfile.saveProfile(profile);
  }

  /// Generates a new [Profile] from [_signIn] with some data taken from the
  /// provided [Profile].
  Profile _profileFromGoogleSignInWithData(Profile profile) {
    return new Profile(
      profile.uid,
      profile.name,
      profile.intro,
    );
  }

  /// Generates a new [Profile] from [_signIn].
  Profile _profileFromGoogleSignIn() {
    return new Profile(
      uid,
      _name,
      "",
    );
  }
}

/// Mock login that logs in after two seconds and always returns the same uid.
class LoginMock extends LoginBase {
  /// A predetermined uid.
  static const String id = "00001";

  /// Gets the predetermined [id].
  @override
  String get uid => id;

  /// Logs the user in after two seconds.
  @override
  Future<bool> login({bool silently = false}) {
    return Future.delayed(new Duration(seconds: 2), () => Future.value(true));
  }

  /// Try to log out of the currently signed in account.
  @override
  Future<bool> logout() {
    return Future.delayed(new Duration(seconds: 2), () => Future.value(true));
  }
}
