/// A relationship between two users.
class Relationship {
  /// The uid of the user that requested this relationship.
  final String _requesterId;

  String get requesterId => _requesterId;
  static const String _requesterIdKey = "requester_id";

  /// The uid of the user that was requested in this relationship.
  final String _requesteeId;

  String get requesteeId => _requesteeId;
  static const String _requesteeIdKey = "requestee_id";

  /// The lower id of the users in this relationship.
  String get lowerId =>
      requesterId.compareTo(requesteeId) < 0 ? requesterId : requesteeId;
  static const String _lowerIdKey = "lower_id";

  /// The upper id of the users in this relationship.
  String get upperId =>
      requesterId.compareTo(requesteeId) < 0 ? requesteeId : requesterId;
  static const String _upperIdKey = "upper_id";

  /// The status of this relationship.
  /// 0 - friends
  /// 1 - requested
  /// 2 - denied
  /// 3 - blocked
  final int _status;

  int get status => _status;
  static const String _statusKey = "status";

  /// The date and time that this relationship was requested.
  final DateTime _requested;

  DateTime get requested => _requested;
  static const String _requestedKey = "requested";

  /// The date and time that this relationship was accepted.
  final DateTime _accepted;

  DateTime get accepted => _accepted;
  static const String _acceptedKey = "accepted";

  /// Creates a new relationship with the given fields.
  Relationship(this._requesterId, this._requesteeId, this._status,
      this._requested, this._accepted);

  /// Creates a new [Relationship] with the information in the given map.
  Relationship.fromJson(Map<String, dynamic> json)
      : this._requesterId = json[_requesterIdKey],
        this._requesteeId = json[_requesteeIdKey],
        this._status = json[_statusKey],
        this._requested = DateTime.tryParse(json[_requestedKey]),
        this._accepted = DateTime.tryParse(json[_acceptedKey]);

  /// Converts this [Relationship] into a json [Map] for database storage.
  Map<String, dynamic> toJson() {
    return {
      _requesterIdKey: this._requesterId,
      _requesteeIdKey: this._requesteeId,
      _lowerIdKey: this.lowerId,
      _upperIdKey: this.upperId,
      _statusKey: this._status,
      _requestedKey: this._requested,
      _acceptedKey: this._accepted,
    };
  }
}
