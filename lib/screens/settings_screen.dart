import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/screens/login_screen.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/dialogs.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocLogin loginBloc = BlocProvider.of<BlocLogin>(context);

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "Settings",
        ),
      ),
      body: new Center(
        child: _logout(context),
      ),
    );
  }

  /// A widget that allows the user to log out of the application.
  Widget _logout(BuildContext context) {
    final BlocLogin bloc = BlocProvider.of<BlocLogin>(context);
    bloc.loginOut.listen((LoginState state) {
      if (state == LoginState.LOGGED_OUT) {
        _pushLogin(context);
      }
    });

    return new StreamBuilder(
      stream: bloc.loginOut,
      builder: (BuildContext context, AsyncSnapshot<LoginState> state) {
        if (state == null || !state.hasData) {
          return new CircularProgressIndicator();
        }

        switch (state.data) {
          case LoginState.LOGGED_IN:
            return new IconButton(
              icon: new Icon(Icons.exit_to_app),
              onPressed: () => bloc.loginIn.add(LoginState.LOGGING_OUT),
            );
            break;
          case LoginState.ERROR:
            showDialog(
              context: context,
              builder: (BuildContext context) => new ErrorDialog(
                    label: LOGOUT_ERROR_TITLE,
                    body: LOGOUT_ERROR_MESSAGE,
                    press: () => Navigator.of(context).pop(),
                    context: context,
                  ),
            );
            return new CircularProgressIndicator();
            break;
          default:
            return new CircularProgressIndicator();
            break;
        }
      },
    );
  }

  /// Navigate to the login screen.
  void _pushLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(
        builder: (BuildContext context) => new LoginScreen(),
      ),
      (Route route) => false,
    );
  }
}
