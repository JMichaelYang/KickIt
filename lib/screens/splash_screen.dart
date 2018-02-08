import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/utils/authenticator.dart';

/// Creates a landing screen where the user is signed in with [Authenticator],
/// should proceed after the user is signed in.
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SplashPageState();
  }
}

/// Manages the state of the [SplashScreen].
class _SplashPageState extends State<StatefulWidget> {
  /// Starts the login process and navigates to the next page when done.
  @override
  void initState() {
    super.initState();

    // Create a listener for the auth event and continue when done.
    Authenticator.auth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) => Navigator.of(context).pushReplacementNamed("/main"));

    // Let navigation animations finish before signing in.
    new Future.delayed(new Duration(milliseconds: 500))
        .then((_) => Authenticator.signInWithGoogle());
  }

  /// Determines the layout of this [SplashScreen].
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new SizedBox(width: 20.0),
              new Text("Please wait..."),
            ],
          ),
        ],
      ),
    );
  }
}
