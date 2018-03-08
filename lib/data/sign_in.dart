import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kickit/data/injectors.dart';
import 'package:kickit/data/profile_store.dart';
import 'package:kickit/database/networking.dart';
import 'package:kickit/database/profile_package.dart';

/// A collection of methods that handle the signing in and signing out of the
/// current user.
abstract class ISignIn {
  /// Signs in the current user, returning a [ProfilePackage] containing the
  /// current user's data.
  Future<ProfilePackage> signIn();

  /// Signs the current user out of Firebase and Google.
  Future<Null> signOut();

  /// Signs the current user out of Firebase and Google and deletes their profile
  /// from the database.
  Future<Null> signOutAndDelete(String uid);
}

/// Performs sign in operations with real network data.
class SignIn extends ISignIn {
  final IProfileStore store;

  SignIn() : store = new ProfileInjector().profileLoader;

  Future<ProfilePackage> signIn() async {
    // Check to see if there is currently a signed in user.
    final GoogleSignInAccount account = Networking.googleSignIn.currentUser;

    // Try to sign in without prompting the user.
    if (account == null) {
      try {
        account == await Networking.googleSignIn.signInSilently();
      } catch (error) {
        print(error);
      }
    }

    // If this doesn't work, prompt the user to sign in.
    if (account == null) {
      try {
        account == await Networking.googleSignIn.signIn();
      } catch (error) {
        print(error);
      }
    }

    // If this doesn't work, throw an error that should tell the user that
    // they must sign in.
    if (account == null) {
      throw new StateError("The user must log in.");
    }

    final GoogleSignInAuthentication auth = await account.authentication;

    // Authenticate the user with firebase.
    final FirebaseUser user = await Networking.firebaseAuth
        .signInWithGoogle(idToken: auth.idToken, accessToken: auth.accessToken);

    if (user == null || user.isAnonymous) {
      throw new StateError("Log in error.");
    }

    final ProfilePackage package = await store.loadProfile(user.uid);

    // No user was found, so create a new one and save it to the database.
    if (package == null) {
      ProfilePackage newPackage =
          new ProfilePackage.fromGoogleSignIn(account, user);
      await store.saveProfile(newPackage);
      return newPackage;
    } else {
      return package;
    }
  }

  Future<Null> signOut() async {
    await Networking.googleSignIn.signOut();
    await Networking.firebaseAuth.signOut();
  }

  Future<Null> signOutAndDelete(String uid) async {
    await store.deleteProfile(uid);
    await signOut();
  }
}

/// Performs sign in operations with mock data.
class MockSignIn implements ISignIn {
  @override
  Future<ProfilePackage> signIn() {
    return new Future.delayed(Networking.delayMedium,
        () => new ProfilePackage("_", "Jaewon Yang", "_", "Test profile."));
  }

  @override
  Future<Null> signOut() {
    return null;
  }

  @override
  Future<Null> signOutAndDelete(String uid) {
    return null;
  }
}
