import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/screens/main_screen.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/dialogs.dart';

/// A screen where the user can log in to their account.
class LoginScreen extends StatefulWidget {
  /// Gets the [LoginScreenState] that corresponds to this [LoginScreen].
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

/// A class that manages the state of the current [LoginScreen].
class _LoginScreenState extends State<LoginScreen> {
  /// The [BlocLogin] used to manage this screen's data.
  BlocLogin _bloc;

  /// Initialize the variables that this screen will need.
  @override
  void initState() {
    _bloc = BlocProvider.of<BlocLogin>(context);
    _bloc.loginSilently();
    _bloc.loggedInOut.listen(
      (bool data) {
        if (data) {
          _pushMain(context);
        }
      },
    );
    super.initState();
  }

  /// Builds the [LoginScreen] depending on the current state.
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new StreamBuilder(
        initialData: LoginState.LOGGING_IN,
        stream: this._bloc.loginOut,
        builder: _getBody,
      ),
    );
  }

  Widget _getBody(BuildContext context, AsyncSnapshot<LoginState> state) {
    if (state.data == null) {
      return _getLoggingIn(context);
    }

    switch (state.data) {
      case LoginState.WAITING:
        return _getWaiting(context);
        break;
      case LoginState.LOGGING_IN:
        return _getLoggingIn(context);
        break;
      default:
        showDialog<Null>(
          context: this.context,
          builder: (context) => new ErrorDialog(
                label: LOGIN_ERROR_TITLE,
                body: LOGIN_ERROR_MESSAGE,
                press: () {
                  _bloc.loginIn.add(LoginState.WAITING);
                  Navigator.of(context).pop();
                },
                context: context,
              ),
        );
        return _getLoggingIn(context);
        break;
    }
  }

  /// Gets the widget to be displayed when waiting to log in.
  Widget _getWaiting(BuildContext context) {
    return new FlatButton(
      onPressed: _bloc.login,
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

  /// Push the [MainScreen] as a replacement to this screen.
  void _pushMain(BuildContext context) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => new BlocProvider(
              bloc: new BlocLogin(),
              child: new MainScreen(),
            ),
      ),
    );
  }
}
