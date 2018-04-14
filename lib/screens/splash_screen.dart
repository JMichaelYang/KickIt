import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/models/app_state_data.dart';
import 'package:kickit/models/app_state_wrapper.dart';
import 'package:kickit/utils/values/asset_paths.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:meta/meta.dart';

/// Creates a landing screen where the user is signed in, the proceeds to the
/// main app. Also serves as a landing screen after the user is logged out.
class SplashScreen extends StatelessWidget {
  SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: Keys.splashScaffoldKey,
      body: new Container(
        key: Keys.splashImageKey,
        decoration: _background(),
        child: _loginStatus(context),
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
  Widget _loginStatus(BuildContext context) {
    return new Center(child: _displayElement(context));
  }

  /// Gets the correct element to display based on the current [state].
  Widget _displayElement(BuildContext context) {
    AppStateWrapper wrapper = AppState.of(context);

    switch (wrapper.data.signInState) {
      case SignInState.NOT_SIGNED_IN:
        return _loginButton(wrapper);
      case SignInState.SIGNING_IN:
        return _waitIndicator();
      case SignInState.FAILED:
        return _loginButton(wrapper); // TODO: Change to _waitIndicator().
      case SignInState.SIGNED_IN:
        return _waitIndicator();
      default:
        throw new StateError("Could not find a login state.");
    }
  }

  /// Gets the login button for this screen.
  Widget _loginButton(AppStateWrapper wrapper) {
    return new FlatButton(
      key: Keys.splashButtonKey,
      onPressed: () => wrapper.signIn(),
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
