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
        child: new IconButton(
          icon: new Icon(Icons.exit_to_app),
          onPressed: () => _logout(context, loginBloc),
        ),
      ),
    );
  }

  void _logout(BuildContext context, BlocLogin login) async {
    if (await login.logout()) {
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (BuildContext context) => new BlocProvider<BlocLogin>(
                bloc: new BlocLogin(),
                child: new LoginScreen(),
              ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => new ErrorDialog(
              label: LOGOUT_ERROR_TITLE,
              body: LOGOUT_ERROR_MESSAGE,
              press: () => Navigator.of(context).pop(),
              context: context,
            ),
      );
    }
  }
}
