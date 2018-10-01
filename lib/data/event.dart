/// An event in the user's schedule.
abstract class IEvent {
  /// Gets the name of this event.
  String getName();

  /// Gets a description of this event.
  String getDescription();
}

/// An event that occupies time in a user's schedule.
class SingleEvent implements IEvent {
  /// The name of this event.
  final String _name;

  /// A description of this event.
  final String _description;

  /// Creates a new [SingleEvent] with the given [_name] and [_description].
  SingleEvent(this._name, this._description);

  /// Gets the [_name] of this event.
  String getName() {
    return _name;
  }

  /// Gets the [_description] of this event.
  String getDescription() {
    return _description;
  }
}

/// An event that occupies time in a user's schedule, repeating at a set
/// interval.
class RecurringEvent implements IEvent {
  /// The name of this event.
  final String _name;

  /// A description of this event.
  final String _description;

  /// Creates a new [RecurringEvent] with the given [_name] and [_description].
  RecurringEvent(this._name, this._description);

  /// Gets the [_name] of this event.
  String getName() {
    return _name;
  }

  /// Gets the [_description] of this event.
  String getDescription() {
    return _description;
  }
}