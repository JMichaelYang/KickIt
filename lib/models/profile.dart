/// An object that stores data about a user. A [Profile] has the following
/// fields:
/// - [uid] => a unique ID as given by Firebase
/// - [name] => a display name as given by Google
/// - [imageUrl] => an image url for a profile image as given by Google
/// - [description] => a status or description (200 character max)

import 'package:kickit/database/profile_package.dart';

/// fields:
/// - [uid] => a unique ID as given by Firebase
/// - [name] => a display name as given by Google
/// - [imageUrl] => an image url for a profile image as given by Google
/// - [description] => a status or description (200 character max)

/// fields:
/// - [uid] => a unique ID as given by Firebase
/// - [name] => a display name as given by Google
/// - [imageUrl] => an image url for a profile image as given by Google
/// - [description] => a status or description (200 character max)

/// fields:
/// - [uid] => a unique ID as given by Firebase
/// - [name] => a display name as given by Google
/// - [imageUrl] => an image url for a profile image as given by Google
/// - [description] => a status or description (200 character max)

class Profile {
  // Profile details.
  final String uid;
  final String name;
  final String imageUrl;
  final String description;

  /// Creates a [Profile] with the provided values. The optional parameters will
  /// all default to empty string. Also performs null checks on most arguments.
  Profile(this.uid, this.name, {String imageUrl, String description})
      : this.imageUrl = imageUrl ?? "",
        this.description = description ?? "" {
    // Argument checking.
    if (this.uid == null) {
      throw new ArgumentError("A Profile's uid cannot be null.");
    }
    if (this.name == null) {
      throw new ArgumentError("A Profile's name cannot be null.");
    }
    if (this.description.length > 200) {
      throw new ArgumentError(
          "A Profile's description cannot be greater than 200 characters.");
    }
  }

  /// Creates a copy of this [Profile] with the given attributes. Any fields
  /// that are not given will default to the current values.
  Profile copyWith({String name, String imageUrl, String description}) {
    return new Profile(this.uid, name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description);
  }

  /// Creates a [Profile] from the given [ProfilePackage].
  Profile.fromPackage(ProfilePackage package)
      : uid = package.uid,
        name = package.name,
        imageUrl = package.imageUrl,
        description = package.description;

  /// Converts this [Profile] into a [ProfilePackage].
  ProfilePackage toPackage() {
    return new ProfilePackage(uid, name, imageUrl, description);
  }

  /// Gets a hash code for this [Profile].
  @override
  int get hashCode =>
      uid.hashCode ^ name.hashCode ^ imageUrl.hashCode ^ description.hashCode;

  /// Overrides the == operator to compare value as well.
  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      other is Profile &&
          other.runtimeType == runtimeType &&
          other.uid == uid &&
          other.name == name &&
          other.imageUrl == imageUrl &&
          other.description == description;
}
