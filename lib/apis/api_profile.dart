import 'dart:async';

import 'package:kickit/apis/database_mock.dart';
import 'package:kickit/apis/firestore/firestore_profile.dart';
import 'package:kickit/data/profile.dart';

/// Base class for an api that retrieves [Profile] objects.
abstract class ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  Stream<Profile> getProfileById(String uid);

  /// Saves the given [Profile] object.
  void saveProfile(Profile profile);
}

/// An api to retrieve profile information from a database.
class ApiProfile extends ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  @override
  Stream<Profile> getProfileById(String uid) {
    return FirestoreProfile.getProfileById(uid);
  }

  /// Saves the given [Profile] object.
  @override
  void saveProfile(Profile profile) {
    FirestoreProfile.saveProfile(profile);
  }
}

/// A mock profile api for testing.
class ApiProfileMock extends ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  @override
  Stream<Profile> getProfileById(String uid) {
    try {
      return new Stream.fromFuture(
        Future.value(
          DatabaseMock.profiles
              .firstWhere((Profile profile) => profile.uid == uid),
        ),
      );
    } catch (error) {
      throw new RangeError("Could not find a profile with the given uid");
    }
  }

  @override
  void saveProfile(Profile profile) {
    Profile p = DatabaseMock.profiles
        .singleWhere((Profile existing) => existing.uid == profile.uid);
    if (p != null) {
      int index = DatabaseMock.profiles.indexOf(p);
      DatabaseMock.profiles[index] = profile;
    } else {
      DatabaseMock.profiles.add(profile);
    }
  }
}
