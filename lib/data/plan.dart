/// An object that stores data about a plan. A [Plan] has the following fields:
/// - [id] => a unique ID as given by Firebase
/// - [_title] => the display title of the plan
/// - [_description] => a description of the plan (optional)
/// - [_location] => a user-given location (optional)
/// - [_start] => the plan's start time (optional)
/// - [_end] => the plan's end time (optional)
class Plan {
  // Plan details
  final String id;
  String _title;
  String _description;
  String _location;
  DateTime _start;
  DateTime _end;

  /// Creates a [Plan] with the provided values. The optional parameters will
  /// all default to and empty string or null.
  Plan(this.id, this._title,
      {String description: "",
      String location: "",
      DateTime start,
      DateTime end}) {
    _description = description;
    _location = location;
    _start = start;
    _end = end;
  }

  /// Sets this [Plan]'s [_description] to [description], ensuring that the
  /// length of the description is less than or equal to 200 characters.
  void setDescription(String description) {
    if (description == null) {
      description = "";
    } else if (description.length > 200) {
      _description = description.substring(0, 200);
    } else {
      _description = description;
    }
  }

  /// Getter for [_description].
  String get description => _description;

  /// Sets this [Plan]'s [_location] to [location], ensuring that the length of
  /// the location is less than or equal to 50 characters.
  void setLocation(String location) {
    if (location == null) {
      location = "";
    } else if (location.length > 50) {
      _location = location.substring(0, 50);
    } else {
      _location = location;
    }
  }

  /// Getter for [_location].
  String get location => _location;

  /// Sets this [Plan]'s [_start] to [start], throwing an exception if the time
  /// given is after [_end].
  void setStart(DateTime start) {
    // If start was set with a null value, just set our current start to null.
    if (start == null) {
      _start = start;
      return;
    }

    // If there is no ending time, then let start be set to any time.
    if (_end == null) {
      _start = start;
      return;
    }

    // If end is not null, make sure that start is before end.
    if (start.compareTo(_end) > 0) {
      throw new ArgumentError("Start cannot be after end.");
    }

    _start = start;
  }

  /// Getter for [_start].
  DateTime get start => _start;

  /// Sets this [Plan]'s [_end] to [end], throwing an exception if the time
  /// given is before [_start].
  void setEnd(DateTime end) {
    // If end was set with a null value, just set our current end to null.
    if (end == null) {
      _end = end;
      return;
    }

    // If there is no starting time, then let end be set to any time.
    if (_start == null) {
      _end = end;
      return;
    }

    // If end is not null, make sure that start is before end.
    if (end.compareTo(_start) < 0) {
      throw new ArgumentError("End cannot be before start.");
    }

    _end = end;
  }

  /// Getter for [_end].
  DateTime get end => _end;
}
