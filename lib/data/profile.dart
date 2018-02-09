import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// An object that stores data about a user. A [Profile] has the following
/// attributes:
/// - a unique ID as given by Firebase
/// - a display name as given by Google
/// - an image url for a profile image as given by Google
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
  /// with values from the sign in [g]. The [uid] field must be taken from
  /// a [FirebaseUser].
  Profile.fromGoogleSignIn(GoogleSignIn g, FirebaseUser f)
      : uid = f.uid,
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

  /// Getter for _description.
  String get description => _description;
}
