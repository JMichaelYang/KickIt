import 'dart:async';

import 'package:kickit/data/profile.dart';

/// Base class for an api that retrieves [Profile] objects.
abstract class ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  Stream<Profile> getProfileById(String uid);

  /// Gets a stream of all of the [Profile] objects available.
  Stream<List<Profile>> getAllProfiles();
}

/// An api to retrieve profile information from a database.
class ApiProfile extends ApiProfileBase {
  /// Gets a [Profile] by its [uid].
  @override
  Stream<Profile> getProfileById(String uid) {
    return null;
  }

  /// Gets a stream of all of the [Profile] objects available.
  @override
  Stream<List<Profile>> getAllProfiles() {
    return null;
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
          _profiles.firstWhere((Profile profile) => profile.uid == uid),
        ),
      );
    } catch (error) {
      throw new RangeError("Could not find a profile with the given uid.");
    }
  }

  /// Gets a stream of all of the [Profile] objects available.
  @override
  Stream<List<Profile>> getAllProfiles() {
    return new Stream.fromFuture(
      Future.delayed(
        new Duration(seconds: 2),
        () => Future.value(
              _profiles,
            ),
      ),
    );
  }

  // A mock list of profiles for testing.
  static final List<Profile> _profiles = [
    new Profile("00001", "Jaewon Yang", "Developer"),
    new Profile("00002", "Malcolm Canterbury", "Developer"),
  ];
}
