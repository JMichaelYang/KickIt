import 'package:kickit/models/profile.dart';
import 'package:meta/meta.dart';

/// Keeps track of the current sign in state.
enum SignInState {
  NOT_SIGNED_IN,
  SIGNING_IN,
  FAILED,
  SIGNED_IN,
}

/// An immutable representation of the current state of the app. Stores all of
/// the data that should be used throughout the app. The only way to modify
/// this state is by dispatching [Action]s to it.
@immutable
class AppStateData {
  // The currently logged in profile and its state.
  final Profile profile;
  final SignInState signInState;

  /// Creates a new [AppStateData] with the given values.
  AppStateData({this.profile, this.signInState = SignInState.NOT_SIGNED_IN});

  /// Creates a new [AppStateData] with the correct initial state.
  const AppStateData.initial()
      : this.profile = null,
        this.signInState = SignInState.NOT_SIGNED_IN;

  /// Creates a copy of this [AppStateData] with the new given values. Any values
  /// not given default to the original values.
  AppStateData copyWith({Profile profile, SignInState state}) {
    return new AppStateData(
        profile: profile ?? this.profile,
        signInState: state ?? this.signInState);
  }
}
