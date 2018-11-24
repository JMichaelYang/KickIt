import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickit/apis/firestore/firestore_utils.dart';
import 'package:kickit/data/profile.dart';

/// A class that stores methods to interact with [Firestore].
abstract class FirestoreProfile {
  /// Gets a [Profile] from the [Firestore] database based on the given [uid].
  static Stream<Profile> getProfileById(String uid) {
    DocumentReference ref =
        Firestore.instance?.collection(USER_PATH)?.document(uid);

    if (ref != null) {
      return ref.snapshots().map<Profile>((DocumentSnapshot snap) {
        if (snap != null && snap.data != null) {
          return new Profile.fromJson(snap.data);
        } else {
          return null;
        }
      });
    } else {
      throw new DatabaseError(message: "Failed to find the user collection");
    }
  }

  /// Get all of the profiles stored in the database.
  static Future<List<Profile>> getAllProfiles() async {
    CollectionReference ref = Firestore.instance?.collection(USER_PATH);

    if (ref != null) {
      QuerySnapshot snap = await ref.getDocuments();
      return new List.of(
        snap.documents.map(
          (DocumentSnapshot doc) => Profile.fromJson(doc.data),
        ),
      );
    } else {
      throw new DatabaseError(message: "Failed to find the user collection");
    }
  }

  /// Saves the given [Profile] to the [Firestore] database.
  static Future<Null> saveProfile(Profile profile) async {
    DocumentReference ref =
        Firestore.instance?.collection(USER_PATH)?.document(profile.uid);

    if (ref != null) {
      await ref.setData(profile.toJson()).then(
            (data) => {},
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
}
