import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/utils/values/asset_paths.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:meta/meta.dart';

/// Creates a landing screen where the user is signed in, the proceeds to the
/// main app. Also serves as a landing screen after the user is logged out.
class SplashScreen extends StatelessWidget {
  final Function onSignIn;
  final SignInState state;

  SplashScreen({Key key, @required this.onSignIn, @required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: Keys.splashScaffoldKey,
      body: new Container(
        key: Keys.splashImageKey,
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
    return new Center(child: _displayElement());
  }

  /// Gets the correct element to display based on the current [state].
  Widget _displayElement() {
    switch (state) {
      case SignInState.NOT_SIGNED_IN:
        return _loginButton();
      case SignInState.SIGNING_IN:
        return _waitIndicator();
      case SignInState.FAILED:
        return _loginButton();
      case SignInState.SIGNED_IN:
        return _waitIndicator();
      default:
        throw new StateError("Could not find a login state.");
    }
  }

  /// Gets the login button for this screen.
  Widget _loginButton() {
    return new FlatButton(
      key: Keys.splashButtonKey,
      onPressed: onSignIn,
      padding: const EdgeInsets.all(0.0),
      child: new Image.asset(AssetPaths.splashSignin),
    );
  }

  /// Gets the waiting indicator for this screen.
  Widget _waitIndicator() {
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
