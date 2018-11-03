import 'dart:async';

import 'package:kickit/apis/firestore/firestore_profile.dart';
import 'package:kickit/data/profile.dart';

/// Base class for an api that retrieves [Profile] objects.
abstract class ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  Future<Profile> getProfileById(String uid);

  /// Gets a stream of all of the [Profile] objects available.
  Future<List<Profile>> getAllProfiles();

  /// Saves the given [Profile] object.
  void saveProfile(Profile profile);
}

/// An api to retrieve profile information from a database.
class ApiProfile extends ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  @override
  Future<Profile> getProfileById(String uid) {
    return FirestoreProfile.getProfileById(uid);
  }

  /// Gets a stream of all of the [Profile] objects available.
  @override
  Future<List<Profile>> getAllProfiles() {
    return FirestoreProfile.getAllProfiles();
  }

  /// Saves the given [Profile] object.
  @override
  saveProfile(Profile profile) {
    FirestoreProfile.saveProfile(profile);
  }
}

/// A mock profile api for testing.
class ApiProfileMock extends ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  @override
  Future<Profile> getProfileById(String uid) {
    try {
      return new Future.value(
        _profiles.firstWhere((Profile profile) => profile.uid == uid),
      );
    } catch (error) {
      throw new RangeError("Could not find a profile with the given uid");
    }
  }

  /// Gets a stream of all of the [Profile] objects available.
  @override
  Future<List<Profile>> getAllProfiles() {
    return new Future.delayed(
      new Duration(seconds: 2),
      () => Future.value(
            _profiles,
          ),
    );
  }

  @override
  void saveProfile(Profile profile) {
    Profile p = _profiles
        .singleWhere((Profile existing) => existing.uid == profile.uid);
    if (p != null) {
      int index = _profiles.indexOf(p);
      _profiles[index] = profile;
    } else {
      _profiles.add(profile);
    }
  }

  // A mock list of profiles for testing.
  static List<Profile> _profiles = [
    new Profile("00001", "Jaewon Yang", "Developer"),
    new Profile("00002", "Malcolm Canterbury", "Developer"),
  ];
}
