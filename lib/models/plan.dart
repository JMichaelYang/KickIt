import 'package:meta/meta.dart';

/// An object that stores data about a plan. A [Plan] has the following fields:
/// - [id] => a unique ID as given by Firebase
/// - [ownerId] => the ID of the user who created this plan
/// - [title] => the display title of the plan
/// - [description] => a description of the plan (optional)
/// - [location] => a user-given location (optional)
/// - [start] => the plan's start time (optional)
/// - [end] => the plan's end time (optional)
@immutable
class Plan {
  // Plan attributes.
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String location;
  final DateTime start;
  final DateTime end;

  /// Creates a [Plan] with the provided values. The optional parameters will
  /// all default to empty string or null. Also performs null checks on most
  /// arguments.
  Plan(this.id, this.ownerId, this.title,
      {String description, String location, this.start, this.end})
      : this.description = description ?? "",
        this.location = location ?? "" {
    // Argument checking.
    if (this.id == null) {
      throw new ArgumentError("A Plan's ID cannot be null.");
    }
    if (this.ownerId == null) {
      throw new ArgumentError("A Plan's owner ID cannot be null.");
    }
    if (this.title == null) {
      throw new ArgumentError("A Plan's title cannot be null.");
    } else if (this.title.length < 4) {
      throw new ArgumentError("A Plan's title must be more than 3 letters.");
    } else if (this.title.length > 50) {
      throw new ArgumentError("A Plan's title must be 50 characters or less.");
    }
    if (this.description.length > 200) {
      throw new ArgumentError(
          "A Plan's description must be 200 characters or less.");
    }
    if (this.location.length > 100) {
      throw new ArgumentError(
          "A Plans's location must be 100 characters or less.");
    }
    if (this.start != null &&
        this.end != null &&
        this.start.compareTo(end) >= 0) {
      throw new ArgumentError("A plan's start must be before its end.");
    }
  }

  /// Creates a copy of this [Plan] with the given attributes. Any fields that
  /// are not given will default to the current values.
  Plan copyWith(
      {String title,
      String description,
      String location,
      DateTime start,
      DateTime end}) {
    return new Plan(this.id, this.ownerId, title ?? this.title,
        description: description ?? this.description,
        location: location ?? this.location,
        start: start ?? this.start,
        end: end ?? this.end);
  }

  /// Gets a hash code for this [Plan].
  @override
  int get hashCode =>
      id.hashCode ^
      ownerId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      location.hashCode ^
      start.hashCode ^
      end.hashCode;

  /// Overrides the == operator to compare value as well.
  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      other is Plan &&
          other.runtimeType == runtimeType &&
          other.id == id &&
          other.ownerId == ownerId &&
          other.title == title &&
          other.description == description &&
          other.location == location &&
          other.start == start &&
          other.end == end;
}
