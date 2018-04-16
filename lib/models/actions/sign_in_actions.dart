import 'dart:async';

import 'package:kickit/data/profile_package.dart';
import 'package:kickit/data/sign_in.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/models/profile.dart';

Future<AppState> signInAction(AppState old, ISignIn signIn) async {
  ProfilePackage package = await signIn.signIn();
  if (package == null) {
    return old.copyWith(signInState: SignInState.FAILED);
  } else {
    return old.copyWith(
      profile: new Profile.fromPackage(package),
      signInState: SignInState.SIGNED_IN,
    );
  }
}

Future<AppState> signOutAction(AppState old, ISignIn signIn) async {
  await signIn.signOut();
  return old.copyWith(profile: null, signInState: SignInState.NOT_SIGNED_IN);
}

Future<AppState> signOutAndDeleteAction(AppState old, ISignIn signIn) async {
  if (old.profile == null) {
    throw new ArgumentError(
        "Tried to delete from an AppState with a null profile");
  }
  await signIn.signOutAndDelete(old.profile.uid);
  return old.copyWith(profile: null, signInState: SignInState.NOT_SIGNED_IN);
}
