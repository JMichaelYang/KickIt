import 'package:kickit/apis/database_mock.dart';
import 'package:kickit/apis/firestore/firestore_relationship.dart';
import 'package:kickit/data/relationship.dart';

/// Base class for an api that retrieves [Relationship] information.
abstract class ApiRelationshipBase {
  /// Gets all of the friends of the user with the given [uid].
  Stream<List<String>> getAllFriends(String uid);

  /// Gets the relationship between the [user] and [other].
  Future<Relationship> getRelationship(String user, String other);
}

/// An api that retrieves [Relationship] information.
class ApiRelationship extends ApiRelationshipBase {
  /// Gets all of the friends of the user with the given [uid].
  @override
  Stream<List<String>> getAllFriends(String uid) {
    return FirestoreRelationship.getAllFriends(uid);
  }

  /// Gets the relationship between the [user] and [other].
  @override
  Future<Relationship> getRelationship(String user, String other) {
    return FirestoreRelationship.getRelationship(user, other);
  }
}

/// A mock relationship api.
class ApiRelationshipMock extends ApiRelationshipBase {
  /// Gets a list of friends of the given uid.
  @override
  Stream<List<String>> getAllFriends(String uid) {
    return Stream.fromFuture(
      Future<List<String>>.delayed(
        new Duration(seconds: 2),
        () => DatabaseMock.relationships
                .where((Relationship rel) =>
                    rel.requesterId == uid || rel.requesteeId == uid)
                .map<String>(
              (Relationship rel) {
                if (rel.requesterId == uid) {
                  return rel.requesteeId;
                } else {
                  return rel.requesterId;
                }
              },
            ).toList(),
      ),
    );
  }

  /// Gets the specific relationship in the mock database.
  @override
  Future<Relationship> getRelationship(String user, String other) {
    // TODO: implement getRelationship
    return null;
  }
}
