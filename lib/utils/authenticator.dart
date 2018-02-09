import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kickit/data/profile.dart';

/// Manages the logging in and authentication of the app's main user using
/// [FirebaseAuth] and [GoogleSignIn].
class Authenticator {
  // Objects with which to sign the user in.
  static final GoogleSignIn _signIn = new GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Profile _profile;

  static FirebaseAuth get auth => _auth;

  static Profile get profile => _profile;

  /// Private constructor so that an [Authenticator] cannot be instantiated
  /// from the outside.
  Authenticator._internal();

  /// Signs the user in with Google and then authenticates with Firebase.
  /// Returns a [FirebaseUser] object correlating to the user that was just
  /// signed in.
  static Future<FirebaseUser> signInWithGoogle() async {
    // See if there is a user signed in.
    GoogleSignInAccount current = _signIn.currentUser;

    if (current == null) {
      // Try to sign in without asking the user.
      current = await _signIn.signInSilently();
    }

    // If the current user is still null, prompt the user to sign in.
    while (current == null) {
      current = await _signIn.signIn();
    }

    final GoogleSignInAuthentication auth = await current.authentication;

    // Authenticate user with firebase
    final FirebaseUser user = await _auth.signInWithGoogle(
        idToken: auth.idToken, accessToken: auth.accessToken);

    // Ensure that the user exists and is not anonymous
    assert(user != null);
    assert(!user.isAnonymous);

    // TODO: Check if user already exists
    _profile = new Profile.fromGoogleSignIn(_signIn, user);

    return user;
  }

  /// Signs out the current user from both Firebase and Google.
  static Future signOutWithGoogle() async {
    // Sign out of Firebase
    await _auth.signOut();
    // Sign out of Google
    await _signIn.signOut();
  }
}
