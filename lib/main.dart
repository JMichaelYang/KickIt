import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kickit/blocs/bloc_login.dart';
import 'package:kickit/blocs/bloc_profile_list.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/screens/login_screen.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/injectors/injector_profile.dart';
import 'package:kickit/util/injectors/injector_relationship.dart';
import 'package:kickit/util/strings.dart';

void main() async {
  // Firestore configuration.
  final FirebaseApp app = await FirebaseApp.configure(
    name: "KickIt",
    options: const FirebaseOptions(
      googleAppID: "1:298546705448:android:75aba892aca49777",
      gcmSenderID: "298546705448",
      apiKey: "AIzaSyBtXdv8CM5klr-eXqJxzt6SZoxlL7jt41U",
      projectID: "kickit-7821f",
    ),
  );
  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  // Set up dependency injection.
  InjectorProfile.configure(ProfileFlavor.REMOTE);
  InjectorLogin.configure(LoginFlavor.REMOTE);
  InjectorRelationship.configure(RelationshipFlavor.REMOTE);

  runApp(
    new KickItApp(),
  );
}

class KickItApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new BlocProvider<BlocLogin>(
      bloc: new BlocLogin(),
      child: new BlocProvider<BlocProfileList>(
        bloc: new BlocProfileList(),
        child: new MaterialApp(
          title: APP_TITLE,
          theme: ThemeData.dark(),
          home: new LoginScreen(),
        ),
      ),
    );
  }
}
