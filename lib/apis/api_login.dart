import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:kickit/apis/firestore/firestore_profile.dart';
import 'package:kickit/data/profile.dart';

/// Base class for a login handler.
abstract class LoginBase {
  /// Gets the uid of the currently logged in user.
  String get uid;

  /// Attempts to log the user in silently.
  Future<bool> loginSilently();

  /// Attempts to log the user in with a popup window.
  Future<bool> login();

  /// Try to log out of the currently signed in account.
  Future<bool> logout();
}

/// Google login api handler.
class Login extends LoginBase {
  /// A single instance of the api handler.
  static final Login _instance = new Login._internal();

  /// The [GoogleSignIn] object for this app.
  GoogleSignIn _signIn;

  /// Internal constructor for the default value.
  Login._internal() {
    _signIn = new GoogleSignIn();
  }

  /// Returns the current instance of [Login].
  factory Login() {
    return _instance;
  }

  /// Gets the current user.
  GoogleSignInAccount get _user => this._signIn?.currentUser;

  /// Gets the uid of the currently logged in user.
  String get uid => this._signIn?.currentUser?.id;

  /// Attempts to log the user in silently.
  Future<bool> loginSilently() async {
    try {
      await this._signIn.signInSilently();
    } catch (error) {
      return false;
    }

    if (await this._signIn.isSignedIn()) {
      await this._loadProfile();
      return true;
    }

    return false;
  }

  /// Attempts to log the user in with a popup window.
  Future<bool> login() async {
    try {
      await this._signIn.signIn();
    } catch (error) {
      return false;
    }

    if (await this._signIn.isSignedIn()) {
      await this._loadProfile();
      return true;
    }

    return false;
  }

  /// Try to log out of the currently signed in account.
  Future<bool> logout() async {
    if (!await this._signIn.isSignedIn()) {
      return true;
    }

    bool signedOut = false;

    await this._signIn.signOut().then(
          (GoogleSignInAccount account) => signedOut = true,
          onError: () => signedOut = false,
        );

    return signedOut;
  }

  /// After loading a [Profile], either save it if it is a new one or update
  /// its information from the [GoogleSignIn].
  Future<Null> _loadProfile() async {
    Profile profile = await FirestoreProfile.getProfileById(this.uid).first;

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
      this._user.displayName,
      profile.intro,
    );
  }

  /// Generates a new [Profile] from [_signIn].
  Profile _profileFromGoogleSignIn() {
    return new Profile(
      this.uid,
      this._user.displayName,
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
  Future<bool> login() {
    return Future.delayed(new Duration(seconds: 2), () => Future.value(true));
  }

  /// Logs the user in after two seconds.
  @override
  Future<bool> loginSilently() {
    return Future.delayed(new Duration(seconds: 2), () => Future.value(true));
  }

  /// Try to log out of the currently signed in account.
  @override
  Future<bool> logout() {
    return Future.delayed(new Duration(seconds: 2), () => Future.value(true));
  }
}
