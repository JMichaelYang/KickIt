import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/utils/values/keys.dart';

/// Screen that display's the public plans that this user can view.
class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingsScreenState();
  }
}

/// Handles the state for a [TalkScreen].
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: Keys.settingsScaffoldKey,
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: Keys.settingsScaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  /// Gets the [AppBar] to use for this screen.
  AppBar _appBar() {
    return new AppBar(
      key: Keys.settingsAppBarKey,
      centerTitle: true,
      title: new Text(
        Strings.settingsTitle,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  /// Gets the [ListView] to use as this screen's body.
  ListView _body() {
    return new ListView(
      key: Keys.settingsBodyKey,
      children: <Widget>[
        _logout(),
        _delete(),
      ],
    );
  }

  /// Gets the logout button for this screen.
  ListTile _logout() {
    return new ListTile(
      key: Keys.settingsLogoutKey,
      title: new Text(
        Strings.settingsLogout,
        style: Theme.of(context).textTheme.button,
        textAlign: TextAlign.right,
      ),
      trailing: new Icon(Icons.exit_to_app),
      onTap: () async {
        await Authenticator.signOutWithGoogle();
        Navigator
            .of(context)
            .pushReplacementNamed(InternalStrings.splashScreenRoute);
      },
    );
  }

  /// Gets the delete account button for this screen.
  ListTile _delete() {
    return new ListTile(
      key: Keys.settingsDeleteKey,
      title: new Text(
        Strings.settingsDelete,
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.red),
        textAlign: TextAlign.right,
      ),
      trailing: new Icon(Icons.delete),
      onTap: () async {
        showDialog(context: context, child: _deleteConfirmDialog())
            .then((value) async {
          if (value == true) {
            await Authenticator.deleteAndSignOut();
            Navigator
                .of(context)
                .pushReplacementNamed(InternalStrings.splashScreenRoute);
          }
        });
      },
    );
  }

  /// Gets the confirmation dialog for the delete account button.
  AlertDialog _deleteConfirmDialog() {
    return new AlertDialog(
    key: Keys.settingsDeleteConfirmKey,
      content: new Text(Strings.settingsConfirmDelete),
      actions: <Widget>[
        new FlatButton(
          child: new Text(
            Strings.ok,
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        new FlatButton(
          child: new Text(
            Strings.cancel,
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }*/
}
