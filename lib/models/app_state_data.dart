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
class AppStateData {
  // The currently logged in profile and its state.
  final Profile profile;
  final SignInState signInState;

  /// Creates a new [AppStateData] with the correct initial state.
  AppStateData.initial()
      : this.profile = null,
        this.signInState = SignInState.NOT_SIGNED_IN;

  /// An internal constructor that creates a new instance of [AppStateData] for
  /// use in the copy method.
  AppStateData._with(this.profile, this.signInState);

  /// Creates a new [AppStateData] with values identical to this one, except
  /// where new ones are specified.
  AppStateData copyWith({
    Profile profile,
    SignInState signInState,
  }) {
    return new AppStateData._with(
      profile ?? this.profile,
      signInState ?? this.signInState,
    );
  }
}
