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
class AppState {
  // The currently logged in profile and its state.
  final Profile profile;
  final SignInState signInState;

  /// Creates a new [AppState] with the given values.
  AppState({this.profile, this.signInState = SignInState.NOT_SIGNED_IN});

  /// Creates a new [AppState] with the correct initial state.
  AppState.initial()
      : profile = null,
        signInState = SignInState.NOT_SIGNED_IN;

  /// Creates a copy of this [AppState] with the new given values. Any values
  /// not given default to the original values.
  AppState copyWith({Profile profile, SignInState state}) {
    return new AppState(
        profile: profile ?? this.profile,
        signInState: state ?? this.signInState);
  }
}
