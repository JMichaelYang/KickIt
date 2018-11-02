import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickit/apis/firestore/firestore_utils.dart';
import 'package:kickit/data/profile.dart';

/// A class that stores methods to interact with [Firestore].
abstract class FirestoreProfile {
  /// Saves the given [Profile] to the [Firestore] database.
  static Future<Null> saveProfile(Profile profile) async {
    DocumentReference ref =
        Firestore.instance?.collection(USER_PATH)?.document(profile.uid);

    if (ref != null) {
      await ref.setData(profile.toJson()).then(
            (T) => {},
            onError: () => throw new DatabaseError(
                  message: "Failed to write user data",
                ),
          );
    } else {
      throw new DatabaseError(
        message: "Failed to find the user collection",
      );
    }

    return null;
  }

  /// Gets a [Profile] from the [Firestore] database based on the given [uid].
  static Future<Profile> getProfileById(String uid) async {
    DocumentReference ref =
        Firestore.instance?.collection(USER_PATH)?.document(uid);

    if (ref != null) {
      DocumentSnapshot snap = await ref.get();
      if (snap != null && snap.data != null) {
        return new Profile.fromJson(snap.data);
      } else {
        return null;
      }
    } else {
      throw new DatabaseError(message: "Failed to find the user collection");
    }
  }
}
