import 'dart:async';

import 'package:kickit/data/injectors.dart';
import 'package:kickit/data/plan_store.dart';
import 'package:kickit/data/profile_package.dart';
import 'package:kickit/data/profile_store.dart';
import 'package:kickit/data/sign_in.dart';
import 'package:kickit/models/app_state_data.dart';
import 'package:kickit/models/profile.dart';

/// Provides a wrapper around the [AppStateData] class in order to make
/// operating on its data more readable and consistent.
class AppStateWrapper {
  // The actual data that this wrapper is wrapped around.
  AppStateData _data;

  // A getter for the data, it should not be manipulated directly.
  AppStateData get data => _data;

  // Objects that are used for network transactions.
  final IPlanStore _planStore;
  final IProfileStore _profileStore;
  final ISignIn _signIn;

  /// Creates a new [AppStateWrapper] that acts on the singleton [AppStateData]
  /// object, deriving its networking objects from their injectors.
  AppStateWrapper({AppStateData data})
      : _data = data ?? new AppStateData.initial(),
        _planStore = new PlanInjector().planLoader,
        _profileStore = new ProfileInjector().profileLoader,
        _signIn = new SignInInjector().signIn {
    assert(_data != null);
    assert(_planStore != null);
    assert(_profileStore != null);
    assert(_signIn != null);
  }

  @override
  bool operator ==(other) {
    return other is AppStateWrapper &&
        other.runtimeType == this.runtimeType &&
        other._data == this._data;
  }

  @override
  int get hashCode =>
      _data.hashCode ^
      _planStore.hashCode ^
      _profileStore.hashCode ^
      _signIn.hashCode;

  Future<Null> signIn() async {
    ProfilePackage package = await _signIn.signIn();

    if (package == null) {
      _data = _data.copyWith(signInState: SignInState.FAILED);
    } else {
      Profile profile = new Profile.fromPackage(package);
      _data = _data.copyWith(
        profile: profile,
        signInState: SignInState.SIGNED_IN,
      );
    }
  }

  Future<Null> signOut() async {
    await _signIn.signOut();
    _data = _data.copyWith(
      profile: null,
      signInState: SignInState.NOT_SIGNED_IN,
    );
  }

  Future<Null> signOutAndDelete() async {
    await _signIn.signOutAndDelete(_data.profile.uid);
    _data = _data.copyWith(
      profile: null,
      signInState: SignInState.NOT_SIGNED_IN,
    );
  }
}
