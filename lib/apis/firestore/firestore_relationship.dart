import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickit/apis/firestore/firestore_utils.dart';
import 'package:kickit/data/relationship.dart';

/// A class that defines methods to be used to access [Relationship] information
/// stored in [Firestore]
abstract class FirestoreRelationship {
  /// Gets all of the friends of the user with the given [uid].
  static Stream<List<String>> getAllFriends(String uid) {
    // Set up queries.
    Query requester = Firestore.instance
        ?.collection(RELATIONSHIP_PATH)
        ?.where(Relationship.requesterIdKey, isEqualTo: uid)
        ?.where(Relationship.statusKey, isEqualTo: 0);
    Query requestee = Firestore.instance
        ?.collection(RELATIONSHIP_PATH)
        ?.where(Relationship.requesteeIdKey, isEqualTo: uid)
        ?.where(Relationship.statusKey, isEqualTo: 0);

    Stream<List<String>> requesterStream =
    requester.snapshots().map<List<String>>(
          (QuerySnapshot snap) {
        snap.documents.map(
                (DocumentSnapshot doc) =>
            doc.data[Relationship.requesteeIdKey]);
      },
    );

    Stream<List<String>> requesteeStream =
    requestee.snapshots().map<List<String>>(
          (QuerySnapshot snap) {
        snap.documents.map(
                (DocumentSnapshot doc) =>
            doc.data[Relationship.requesterIdKey]);
      },
    );

    return StreamGroup.merge<List<String>>([
      requesterStream,
      requesteeStream,
    ]).asBroadcastStream();
  }

  /// Gets the relationship between the [user] and [other].
  static Future<Relationship> getRelationship(String user, String other) async {
    String lower;
    String upper;
    if (user.compareTo(other) < 0) {
      lower = user;
      upper = other;
    } else {
      lower = other;
      upper = user;
    }

    // Find a relationship where the ids match the given ids.
    Query cases = Firestore.instance
        ?.collection(RELATIONSHIP_PATH)
        ?.where(Relationship.lowerIdKey, isEqualTo: lower)
        ?.where(Relationship.upperIdKey, isEqualTo: upper);

    // If the query is null, return.
    if (cases == null) {
      return null;
    }

    // Get a snapshot of the query.
    QuerySnapshot snap = await cases.getDocuments();

    // If the query returns an empty or null list, return.
    if (snap.documents == null || snap.documents.isEmpty) {
      return null;
    }

    // Return the relationship that was found.
    return Relationship.fromJson(snap.documents.first.data);
  }

  /// Saves the given relationship to the database.
  static void saveRelationship(Relationship relationship) {
    CollectionReference collection =
        Firestore.instance?.collection(RELATIONSHIP_PATH);

    // If the relationship collection couldn't be found, throw an error.
    if (collection == null) {
      throw new DatabaseError(message: "Could not find the Firestore instance");
    }

    collection
        .document(relationship.lowerId + relationship.upperId)
        .setData(relationship.toJson());
  }
}
