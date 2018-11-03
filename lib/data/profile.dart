/// A user profile, describing a single user of the app.
class Profile {
  /// The generated uid of this user.
  final String _uid;

  String get uid => _uid;
  static const String _uidKey = "uid";

  /// The name of this user.
  final String _name;

  String get name => _name;
  static const String _nameKey = "name";

  /// A short intro for this user.
  final String _intro;

  String get intro => _intro;
  static const String _introKey = "intro";

  /// Creates a new [Profile] with the given data.
  Profile(this._uid, this._name, this._intro);

  /// Creates a new [Profile] with the information parsed from the given map.
  Profile.fromJson(Map<String, dynamic> json)
      : this._uid = json[_uidKey],
        this._name = json[_nameKey],
        this._intro = json[_introKey];

  /// Converts this [Profile] into a json [Map] for database storage.
  Map<String, dynamic> toJson() {
    return {
      _uidKey: this._uid,
      _nameKey: this._name,
      _introKey: this._intro,
    };
  }
}
