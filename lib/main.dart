import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kickit/blocs/bloc_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/internal/keys.dart';
import 'package:kickit/screens/login_screen.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/injectors/injector_profile.dart';
import 'package:kickit/util/injectors/injector_relationship.dart';
import 'package:kickit/util/strings.dart';

void main() async {
  // Firestore configuration.
  final FirebaseApp app = await FirebaseApp.configure(
    name: "KickIt",
    options: new FirebaseOptions(
      googleAppID: Platform.isAndroid ? googleAppID : iosAppID,
      gcmSenderID: gcmSenderID,
      apiKey: apiKey,
      projectID: projectID,
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
      child: new MaterialApp(
        title: APP_TITLE,
        theme: ThemeData.dark(),
        home: new LoginScreen(),
      ),
    );
  }
}
