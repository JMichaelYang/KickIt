import 'package:google_sign_in/google_sign_in.dart';

/// An object that stores data about a user. A profile has the following
/// attributes:
/// - a unique ID as given by GoogleSignIn
/// - a display name
/// - an image url for a profile image
/// - a status or description (200 character max)
class Profile {
  // Profile details
  final String uid;
  final String name;
  final String imageUrl;
  String _description;

  /// Creates a [Profile] with the provided values. This constructor should
  /// only be used for testing purposes (ie: creating test profiles).
  Profile(this.uid, this.name, this.imageUrl, this._description);

  /// Creates a [Profile] from a [GoogleSignIn], setting the appropriate fields
  /// with values from the sign in [g]
  Profile.fromGoogleSignIn(GoogleSignIn g)
      : uid = g.currentUser.id,
        name = g.currentUser.displayName,
        imageUrl = g.currentUser.photoUrl {
    _description = "";
  }

  /// Sets this [Profile]'s [_description] to [description], ensuring that the
  /// length of the description is less than or equal to 200 characters.
  void setDescription(String description) {
    if(description.length > 200) {
      _description = description.substring(0, 199);
    } else {
      _description = description;
    }
  }

  /// Gets the [String] representation of this [Profile]'s [_description].
  String getDescription() {
    return _description;
  }
}
