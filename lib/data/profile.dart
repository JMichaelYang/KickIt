/// A user profile, describing a single user of the app.
class Profile {
  /// The generated uid of this user.
  final String uid;
  static final String _uidKey = "uid";

  /// The name of this user.
  final String name;
  static final String _nameKey = "name";

  /// A short intro for this user.
  final String intro;
  static final String _introKey = "intro";

  /// Creates a new [Profile] with the given data.
  Profile(this.uid, this.name, this.intro);

  /// Creates a new [Profile] with the information parsed from the given [json].
  Profile.fromJson(Map<String, dynamic> json)
      : this.uid = json[_uidKey],
        this.name = json[_nameKey],
        this.intro = json[_introKey];

  /// Converts this [Profile] into a json [Map] for database storage.
  Map<String, dynamic> toJson() {
    return {
      _uidKey: this.uid,
      _nameKey: this.name,
      _introKey: this.intro,
    };
  }
}
