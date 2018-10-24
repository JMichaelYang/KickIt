/// An event in the user's schedule.
abstract class EventBase {
  /// Gets the name of this event.
  String get name;

  /// Gets a description of this event.
  String get description;
}

/// An event that occupies time in a user's schedule.
class SingleEvent implements EventBase {
  /// The name of this event.
  final String _name;

  String get name => _name;

  /// A description of this event.
  final String _description;

  String get description => _description;

  /// Creates a new [SingleEvent] with the given [_name] and [_description].
  SingleEvent(this._name, this._description);
}

/// An event that occupies time in a user's schedule, repeating at a set
/// interval.
class RecurringEvent implements EventBase {
  /// The name of this event.
  final String _name;

  String get name => _name;

  /// A description of this event.
  final String _description;

  String get description => _description;

  /// Creates a new [RecurringEvent] with the given [_name] and [_description].
  RecurringEvent(this._name, this._description);
}
