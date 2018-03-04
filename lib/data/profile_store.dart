import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickit/data/test_data/test_profiles.dart';
import 'package:kickit/database/networking.dart';
import 'package:kickit/database/profile_package.dart';

/// A collection of methods that handle the loading and saving of [Profile]s to
/// and from Firebase.
abstract class IProfileStore {
  /// Loads a [ProfilePackage] from the database with the given [uid], returning
  /// null if the given [ProfilePackage] cannot be found.
  Future<ProfilePackage> loadProfile(String uid);

  /// Saves the given [ProfilePackage] to the database.
  Future<Null> saveProfile(ProfilePackage profile);

  /// Deletes the user with the given [uid] from the database.
  Future<Null> deleteProfile(String uid);
}

/// Performs [Profile] loading operations with real network data.
class ProfileStore implements IProfileStore {
  Future<ProfilePackage> loadProfile(String uid) async {
    DocumentSnapshot snapshot =
        await firestore.collection(usersKey).document(uid).get();

    // If the data couldn't be loaded, the given uid doesn't exist.
    if (snapshot == null) {
      return null;
    }

    return new ProfilePackage.fromMap(snapshot.data);
  }

  Future<Null> saveProfile(ProfilePackage profile) async {
    await firestore
        .collection(usersKey)
        .document(profile.uid)
        .setData(profile.toMap());
  }

  Future<Null> deleteProfile(String uid) async {
    await firestore.collection(usersKey).document(uid).delete();
  }
}

/// Performs [Profile] loading operations with mock data.
class MockProfileStore implements IProfileStore {
  Future<ProfilePackage> loadProfile(String uid) async {
    for (ProfilePackage package in testProfiles) {
      if (package.uid == uid) {
        return package;
      }
    }

    return null;
  }

  Future<Null> saveProfile(ProfilePackage profile) async {
    testProfiles.add(profile);
    return null;
  }

  Future<Null> deleteProfile(String uid) async {
    for (int i = 0; i < testProfiles.length; i++) {
      if (testProfiles[i].uid == uid) {
        testProfiles.removeAt(i);
        return null;
      }
    }

    return null;
  }
}
