import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickit/data/profile.dart';

/// Handles the loading of data from the Firestore database.
class Remote {
  // Constants for database collection names.
  static const String usersKey = "users";

  // Reference to the Firestore database.
  static final Firestore database = Firestore.instance;

  /// Private constructor so that a [Remote] cannot be instantiated
  /// from the outside.
  Remote.internal();

  /// Gets a [Profile] with the given ID. Returns null if no matching [Profile]
  /// was found.
  static Future<Profile> getProfile(String id) async {
    DocumentSnapshot data =
        await database.collection(usersKey).document(id).get();

    // Return null if no Profile was found.
    if(data.data == null) {
      return null;
    }

    return Profile.empty.fromMap(data.data);
  }

  /// Saves a [Profile] to the Firebase database.
  static Future saveProfile(Profile profile) async {
    database.collection(usersKey).document(profile.uid).setData(profile.toMap());
  }
}
