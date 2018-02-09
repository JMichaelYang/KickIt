import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/utils/authenticator.dart';
import 'package:kickit/utils/values/asset_paths.dart';
import 'package:kickit/utils/values/internal_strings.dart';

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
  // Keeps track of whether we are currently signing in.
  bool _signingIn = false;

  /// Signs the user in using [GoogleSignIn] and [Authenticator].
  void _signIn() {
    // Create a listener for the auth event and continue when done.
    Authenticator.auth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) => Navigator.of(context).pushReplacementNamed("/main"));

    Authenticator.signInWithGoogle();
    setState(() => _signingIn = true);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: new ValueKey(InternalStrings.splashScaffoldKey),
      body: new Container(
        decoration: _background(),
        child: _loginStatus(),
      ),
    );
  }

  /// Gets the background image displayed on this splash screen.
  BoxDecoration _background() {
    return new BoxDecoration(
      image: new DecorationImage(
          image: new AssetImage(AssetPaths.splashBackground),
          fit: BoxFit.cover),
    );
  }

  /// Gets the widget that should currently be displayed depending on whether
  /// the user is currently logging in based on [_signingIn].
  Widget _loginStatus() {
    if (_signingIn) {
      return _waitIndicator();
    } else {
      return _loginButton();
    }
  }

  /// Gets the login button for this screen.
  Center _loginButton() {
    return new Center(
      child: new FlatButton(
        key: new ValueKey(InternalStrings.splashButtonKey),
        onPressed: _signIn,
        padding: const EdgeInsets.all(0.0),
        child: new Image.asset(AssetPaths.splashSignin),
      ),
    );
  }

  /// Gets the "Please wait..." indicator for this screen.
  Column _waitIndicator() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(),
          ],
        ),
      ],
    );
  }
}
