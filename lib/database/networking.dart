import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Networking {
  /// Objects to be used in database read/write operations.

  /// Database keys in order to access different parts of the database.
  static const String usersKey = "users";

  /// The delays to use for mock operations.
  static const Duration delayShort = const Duration(milliseconds: 100);
  static const Duration delayMedium = const Duration(milliseconds: 500);
  static const Duration delayLong = const Duration(milliseconds: 1000);
}
