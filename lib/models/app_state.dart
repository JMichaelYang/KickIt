import 'package:kickit/models/profile.dart';
import 'package:meta/meta.dart';

/// Keeps track of the current sign in state.
enum SignInState {
  NOT_SIGNED_IN,
  SIGNING_IN,
  FAILED,
  SIGNED_IN,
}

/// Represents the current state of the app. This is an immutable state that
/// can only be modified by recreating the object with new values.
@immutable
class AppState {
  // The currently logged in profile and its state.
  final Profile profile;
  final SignInState signInState;

  /// Creates a new [AppState] with the correct initial state.
  AppState.initial()
      : this.profile = null,
        this.signInState = SignInState.NOT_SIGNED_IN;

  /// An internal constructor that creates a new instance of [AppState] for
  /// use in the copy method.
  AppState._with(this.profile, this.signInState);

  /// Creates a new [AppState] with values identical to this one, except
  /// where new ones are specified.
  AppState copyWith({
    Profile profile,
    SignInState signInState,
  }) {
    return new AppState._with(
      profile ?? this.profile,
      signInState ?? this.signInState,
    );
  }

  @override
  bool operator ==(other) {
    return other is AppState &&
        other.runtimeType == this.runtimeType &&
        other.profile == this.profile &&
        other.signInState == this.signInState;
  }

  @override
  int get hashCode => profile.hashCode ^ signInState.hashCode;
}
