import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/apis/api_login.dart';
import 'package:kickit/screens/main_screen.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/strings.dart';

/// An enum describing the states that a [LoginScreen] could be in.
enum _LoginState {
  WAITING,
  LOGGING_IN,
}

/// A screen where the user can log in to their account.
class LoginScreen extends StatefulWidget {
  /// Gets the [LoginScreenState] that corresponds to this [LoginScreen].
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

/// A class that manages the state of the current [LoginScreen].
class _LoginScreenState extends State<LoginScreen> {
  /// The current state of this [LoginScreen].
  _LoginState _state = _LoginState.LOGGING_IN;

  /// The [LoginBase] object used to sign in the user.
  LoginBase _login;

  /// Initialize the variables that this screen will need.
  @override
  void initState() {
    this._state = _LoginState.LOGGING_IN;
    this._login = new InjectorLogin().login;
    this._login.loginSilently().then((bool success) {
      if (success) {
        _pushMain(this.context);
      } else {
        setState(() => this._state = _LoginState.WAITING);
      }
    });
    super.initState();
  }

  /// Builds the [LoginScreen] depending on the current state.
  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (this._state) {
      case _LoginState.WAITING:
        content = _getWaiting(context);
        break;
      default:
        content = _getLoggingIn(context);
        break;
    }

    return new Center(child: content);
  }

  /// Gets the widget to be displayed when waiting to log in.
  Widget _getWaiting(BuildContext context) {
    return new FlatButton(
      onPressed: _logIn,
      child: new Text(
        LOGIN_BUTTON,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  /// Gets the widget to be displayed when trying to log in.
  Widget _getLoggingIn(BuildContext context) {
    return new CircularProgressIndicator();
  }

  /// Attempt to log in with Google.
  Future<Null> _logIn() async {
    setState(() => this._state = _LoginState.LOGGING_IN);

    if (await _login.login()) {
      _pushMain(this.context);
    } else {
      showDialog<Null>(
        context: this.context,
        builder: _getDialog,
      );
    }
  }

  /// Gets the [AlertDialog] that should be shown when a login attempt fails.
  Widget _getDialog(BuildContext context) {
    return new AlertDialog(
      title: new Text(
        LOGIN_ERROR_TITLE,
        style: Theme.of(context).textTheme.title,
      ),
      content: new SingleChildScrollView(
        child: new Text(
          LOGIN_ERROR_MESSAGE,
          style: Theme.of(context).textTheme.body1,
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text(
            APP_OK,
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            setState(() => _state = _LoginState.WAITING);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  /// Push the [MainScreen] as a replacement to this screen.
  void _pushMain(BuildContext context) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => new MainScreen(),
      ),
    );
  }
}
