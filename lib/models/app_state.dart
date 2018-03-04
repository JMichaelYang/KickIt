import 'package:kickit/models/profile.dart';
import 'package:meta/meta.dart';

/// An immutable representation of the current state of the app. Stores all of
/// the data that should be used throughout the app. The only way to modify
/// this state is by dispatching [Action]s to it.
@immutable
class AppState {
  // The currently logged in profile.
  final Profile profile;

  /// Creates a new [AppState] with the given values.
  AppState({this.profile});

  /// Creates a copy of this [AppState] with the new given values. Any values
  /// not given default to the original values.
  AppState copyWith({Profile profile}) {
    return new AppState(profile: profile ?? this.profile);
  }

  /// Gets a hash code for this [AppState] based on its fields.
  @override
  int get hashCode => profile.hashCode;

  /// Overrides equality to include profile state.
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is AppState &&
          other.runtimeType == runtimeType &&
          other.profile == profile;
}
