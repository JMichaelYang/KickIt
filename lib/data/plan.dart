import 'package:kickit/data/storable.dart';

/// An object that stores data about a plan. A [Plan] has the following fields:
/// - [id] => a unique ID as given by Firebase
/// - [_title] => the display title of the plan
/// - [_description] => a description of the plan (optional)
/// - [_location] => a user-given location (optional)
/// - [_start] => the plan's start time (optional)
/// - [_end] => the plan's end time (optional)
class Plan extends IStorable {
  // Keys for storing data in a map.
  static const String idKey = "id";
  static const String ownerIdKey = "ownerId";
  static const String titleKey = "title";
  static const String descriptionKey = "description";
  static const String locationKey = "location";
  static const String startKey = "start";
  static const String endKey = "end";

  // Plan details.
  final String id;
  final String ownerId;
  String _title;
  String _description;
  String _location;
  DateTime _start;
  DateTime _end;

  // Empty plan.
  static final Plan empty = new Plan("", "", "Empty");

  /// Creates a [Plan] with the provided values. The optional parameters will
  /// all default to and empty string or null.
  Plan(this.id, this.ownerId, String title,
      {String description: "",
      String location: "",
      DateTime start,
      DateTime end}) {
    this.title = title;
    this.description = description;
    this.location = location;
    this.start = start;
    this.end = end;

    if (this.id == null) {
      throw new ArgumentError("A Plan's ID cannot be null.");
    }
    if (this.ownerId == null) {
      throw new ArgumentError("A Plan's owner ID cannot be null.");
    }
  }

  /// Creates a [Profile] from a [Map], taking all of the data that the map
  /// provides. The map must provide a value for every field.
  @override
  Plan fromMap(Map<String, dynamic> data) {
    return new Plan(data[idKey], data[ownerId], data[titleKey],
        description: data[descriptionKey],
        location: data[locationKey],
        start: new DateTime.fromMillisecondsSinceEpoch(data[startKey],
            isUtc: true),
        end:
            new DateTime.fromMillisecondsSinceEpoch(data[endKey], isUtc: true));
  }

  /// Converts this [Profile] into a [Map] that is storable in [Firestore].
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();

    map.putIfAbsent(idKey, () => id);
    map.putIfAbsent(ownerIdKey, () => ownerId);
    map.putIfAbsent(titleKey, () => _title);
    map.putIfAbsent(descriptionKey, () => _description);
    map.putIfAbsent(locationKey, () => _location);
    map.putIfAbsent(startKey, () => _start.millisecondsSinceEpoch);
    map.putIfAbsent(endKey, () => _end.millisecondsSinceEpoch);

    return map;
  }

  /// Sets this [Plan]'s [_title] to [title], ensuring that the length of the
  /// title is less than or equal to 50 characters.
  set title(String title) {
    if (title == null) {
      throw new ArgumentError("A Plan's title cannot be null");
    } else if (title.length > 50) {
      _title = title.substring(0, 50);
    } else if (title.length < 4) {
      throw new ArgumentError("A Plan's title must be at least 4 characters");
    } else {
      _title = title;
    }
  }

  /// Getter for [_title].
  String get title => _title;

  /// Sets this [Plan]'s [_description] to [description], ensuring that the
  /// length of the description is less than or equal to 200 characters.
  set description(String description) {
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
  set location(String location) {
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
  set start(DateTime start) {
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
  set end(DateTime end) {
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
