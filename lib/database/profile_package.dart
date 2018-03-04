import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Stores the data for a [Profile] that is to be sent to or from Firebase.
/// A [ProfilePackage] is a temporary object that is to be used in a networking
/// context.
class ProfilePackage {
  // Keys for mapping within the package.
  static const String _uidKey = "uid";
  static const String _nameKey = "name";
  static const String _imageUrlKey = "imageUrl";
  static const String _descriptionKey = "description";

  // Attributes of a Profile that should be reflected in this package.
  final String uid;
  final String name;
  final String imageUrl;
  final String description;

  /// Constructor for creating a package to be transmitted to the database.
  ProfilePackage(this.uid, this.name, this.imageUrl, this.description);

  /// Constructor to create a [ProfilePackage] from a [Map] from the database.
  ProfilePackage.fromMap(Map<String, Object> map)
      : uid = map[_uidKey],
        name = map[_nameKey],
        imageUrl = map[_imageUrlKey],
        description = map[_descriptionKey] {
    if (uid == null) {
      throw new ArgumentError("Given map's uid field was null.");
    }
    if (name == null) {
      throw new ArgumentError("Given map's name field was null.");
    }
    if (imageUrl == null) {
      throw new ArgumentError("Given map's imageUrl field was null.");
    }
    if (description == null) {
      throw new ArgumentError("Given map's description field was null.");
    }
  }

  /// Creates a new [ProfilePackage] from a [GoogleSignInAccount] and a
  /// [FirebaseUser].
  ProfilePackage.fromGoogleSignIn(GoogleSignInAccount g, FirebaseUser f)
      : uid = f.uid,
        name = g.displayName,
        imageUrl = g.photoUrl,
        description = "" {
    if (uid == null) {
      throw new ArgumentError("Given a null uid.");
    }
    if (name == null) {
      throw new ArgumentError("Given a null name.");
    }
    if (imageUrl == null) {
      throw new ArgumentError("Given a null image url.");
    }
  }

  /// Converts this object into JSON format for database storage.
  Map<String, Object> toMap() {
    return {
      _uidKey: uid,
      _nameKey: name,
      _imageUrlKey: imageUrl,
      _descriptionKey: description,
    };
  }

  @override
  int get hashCode =>
      uid.hashCode ^ name.hashCode ^ imageUrl.hashCode ^ description.hashCode;

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        other is ProfilePackage &&
            other.runtimeType == this.runtimeType &&
            other.uid == this.uid &&
            other.name == this.name &&
            other.imageUrl == this.imageUrl &&
            other.description == this.description;
  }
}
