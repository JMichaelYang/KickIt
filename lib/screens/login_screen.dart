import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/screens/main_screen.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/dialogs.dart';

/// A screen where the user can log in to their account.
class LoginScreen extends StatelessWidget {
  /// Builds the [LoginScreen] depending on the current state.
  @override
  Widget build(BuildContext context) {
    // The bloc used to manage this screen's data.
    final BlocLogin bloc = BlocProvider.of<BlocLogin>(context);
    bloc.loginOut.listen((LoginState state) {
      if (state == LoginState.LOGGED_IN) {
        _pushMain(context);
      }
    });

    return new Center(
      child: new StreamBuilder(
        stream: bloc.loginOut,
        builder: (BuildContext context, AsyncSnapshot<LoginState> state) =>
            _getBody(context, state, bloc),
      ),
    );
  }

  /// Gets the body content of the login screen.
  Widget _getBody(
    BuildContext context,
    AsyncSnapshot<LoginState> state,
    BlocLogin bloc,
  ) {
    if (state.data == null || !state.hasData) {
      return _getLoading(context);
    }

    switch (state.data) {
      case LoginState.LOGGING_OUT:
        return _getLoading(context);
      case LoginState.LOGGED_OUT:
        bloc.loginIn.add(LoginState.LOGGING_IN_SILENTLY);
        return _getLoading(context);
        break;
      case LoginState.LOGGING_IN_SILENTLY:
        return _getLoading(context);
        break;
      case LoginState.LOGGED_OUT_SILENT:
        return _getWaiting(context, bloc);
        break;
      case LoginState.LOGGING_IN:
        return _getLoading(context);
        break;
      case LoginState.LOGGED_IN:
        return _getLoading(context);
      default:
        showDialog<Null>(
          context: context,
          builder: (context) => new ErrorDialog(
                label: LOGIN_ERROR_TITLE,
                body: LOGIN_ERROR_MESSAGE,
                press: () {
                  bloc.loginIn.add(LoginState.LOGGED_OUT);
                  Navigator.of(context).pop();
                },
                context: context,
              ),
        );
        return _getLoading(context);
        break;
    }
  }

  /// Gets the widget to be displayed when waiting to log in.
  Widget _getWaiting(BuildContext context, BlocLogin bloc) {
    return new FlatButton(
      onPressed: () => bloc.loginIn.add(LoginState.LOGGING_IN),
      child: new Text(
        LOGIN_BUTTON,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  /// Gets the widget to be displayed when any process in in progress.
  Widget _getLoading(BuildContext context) {
    return new CircularProgressIndicator();
  }

  /// Push the [MainScreen] as a replacement to this screen.
  void _pushMain(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(
        builder: (BuildContext context) => new MainScreen(),
      ),
      (Route route) => false,
    );
  }
}
