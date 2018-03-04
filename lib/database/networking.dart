import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Objects to be used in database read/write operations.
final Firestore firestore = Firestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();

/// Database keys in order to access different parts of the database.
const String usersKey = "users";

/// The delays to use for mock operations.
const Duration delayShort = const Duration(milliseconds: 100);
const Duration delayMedium = const Duration(milliseconds: 500);
const Duration delayLong = const Duration(milliseconds: 1000);