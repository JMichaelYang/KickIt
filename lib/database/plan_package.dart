/// Stores the data for a [Plan] that is to be sent to or from Firebase.
/// A [PlanPackage] is a temporary object that is to be used in a networking
/// context.
class PlanPackage {
  // Keys for accessing the stored data.
  static const String _idKey = "id";
  static const String _ownerIdKey = "ownerId";
  static const String _titleKey = "title";
  static const String _descriptionKey = "description";
  static const String _locationKey = "location";
  static const String _startKey = "start";
  static const String _endKey = "end";

  // Attributes of a plan that should be stored in this package.
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String location;
  final int start;
  final int end;

  /// Constructor for creating a package to be transmitted to the database.
  PlanPackage(this.id, this.ownerId, this.title, this.description,
      this.location, this.start, this.end);

  /// Constructor to create a [PlanPackage] from a [Map] from the database.
  PlanPackage.fromMap(Map<String, Object> map)
      : id = map[_idKey],
        ownerId = map[_ownerIdKey],
        title = map[_titleKey],
        description = map[_descriptionKey],
        location = map[_locationKey],
        start = map[_startKey],
        end = map[_endKey] {
    if (id == null) {
      throw new ArgumentError("Given map's uid field was null.");
    }
    if (ownerId == null) {
      throw new ArgumentError("Given map's name field was null.");
    }
    if (title == null) {
      throw new ArgumentError("Given map's imageUrl field was null.");
    }
    if (description == null) {
      throw new ArgumentError("Given map's description field was null.");
    }
  }

  /// Converts this object into JSON format for database storage.
  Map<String, Object> toMap() {
    return {
      _idKey: id,
      _ownerIdKey: ownerId,
      _titleKey: title,
      _descriptionKey: description,
      _locationKey: location,
      _startKey: start,
      _endKey: end,
    };
  }

  @override
  int get hashCode =>
      id.hashCode ^
      ownerId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      location.hashCode ^
      start.hashCode ^
      end.hashCode;

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        other is PlanPackage &&
            other.runtimeType == this.runtimeType &&
            other.id == this.id &&
            other.ownerId == this.ownerId &&
            other.title == this.title &&
            other.description == this.description &&
            other.location == this.location &&
            other.start == this.start &&
            other.end == this.end;
  }
}
