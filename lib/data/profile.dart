import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kickit/data/storable.dart';

/// An object that stores data about a user. A [Profile] has the following
/// attributes:
/// - a unique ID as given by Firebase
/// - a display name as given by Google
/// - an image url for a profile image as given by Google
/// - a status or description (200 character max)
class Profile extends IStorable {
  // Keys for storing in a map
  static const String uidKey = "uid";
  static const String nameKey = "name";
  static const String imageUrlKey = "imageUrl";
  static const String descriptionKey = "description";

  // Profile details
  final String uid;
  final String name;
  final String imageUrl;
  String _description;

  // Empty profile
  static final Profile empty = new Profile("", "Empty", "");

  /// Creates a [Profile] with the provided values. This constructor should
  /// only be used for testing purposes (ie: creating test profiles).
  Profile(this.uid, this.name, this.imageUrl, {String description = ""}) {
    this._description = description;

    // Checks for invalid final fields.

    if (this.uid == null) {
      throw new ArgumentError("Cannot have a Profile with a null UID.");
    }

    if (this.name == null) {
      throw new ArgumentError("Cannot have a Profile with a null name.");
    } else if (this.name.length < 4) {
      throw new ArgumentError(
          "Cannot have a Profile with a name less than 4 characters.");
    }

    if(this.imageUrl == null) {
      throw new ArgumentError("A Profile's image url cannot be null");
    }
  }

  /// Creates a [Profile] from a [GoogleSignIn], setting the appropriate fields
  /// with values from the sign in [g]. The [uid] field must be taken from
  /// a [FirebaseUser].
  Profile.fromGoogleSignIn(GoogleSignIn g, FirebaseUser f)
      : uid = f.uid,
        name = g.currentUser.displayName,
        imageUrl = g.currentUser.photoUrl {
    _description = "";
  }

  /// Creates a [Profile] from a [Map], taking all of the data that the map
  /// provides. The map must provide a value for every field.
  @override
  Profile fromMap(Map<String, dynamic> data) {
    return new Profile(data[uidKey], data[nameKey], data[imageUrlKey],
        description: data[descriptionKey]);
  }

  /// Converts this [Profile] into a [Map] that is storable in [Firestore].
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();

    map.putIfAbsent(uidKey, () => uid);
    map.putIfAbsent(nameKey, () => name);
    map.putIfAbsent(imageUrlKey, () => imageUrl);
    map.putIfAbsent(descriptionKey, () => _description);

    return map;
  }

  /// Sets this [Profile]'s [_description] to [description], ensuring that the
  /// length of the description is less than or equal to 200 characters.
  set description(String description) {
    if (description == null) {
      _description = "";
    } else if (description.length > 200) {
      _description = description.substring(0, 199);
    } else {
      _description = description;
    }
  }

  /// Getter for _description.
  String get description => _description;
}
