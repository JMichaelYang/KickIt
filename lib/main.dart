import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kickit/blocs/bloc_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/screens/login_screen.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/injectors/injector_profile.dart';
import 'package:kickit/widgets/themes.dart';

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

  runApp(
      new KickItApp(),
  );
}

class KickItApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "KickIt",
      theme: dark,
      home: new BlocProvider<BlocLogin>(
        bloc: new BlocLogin(),
        child: new LoginScreen(),
      ),
    );
  }
}
