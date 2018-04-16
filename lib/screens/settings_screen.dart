import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/models/kickit.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:kickit/utils/values/strings.dart';

/// Screen that allows the user to modify settings as well as sign out.
class SettingsScreen extends StatelessWidget {
  SettingsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KickItState state = KickIt.of(context);

    return new Scaffold(
      key: Keys.settingsScaffoldKey,
      appBar: _appBar(context),
      body: _body(state, context),
    );
  }

  /// Gets the [AppBar] to use for this screen.
  AppBar _appBar(BuildContext context) {
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
  ListView _body(KickItState state, BuildContext context) {
    return new ListView(
      key: Keys.settingsBodyKey,
      children: <Widget>[
        _logout(state, context),
        _delete(state, context),
      ],
    );
  }

  /// Gets the logout button for this screen.
  Widget _logout(KickItState state, BuildContext context) {
    return new ListTile(
      key: Keys.settingsLogoutKey,
      title: new Text(
        Strings.settingsLogout,
        style: Theme.of(context).textTheme.button,
        textAlign: TextAlign.right,
      ),
      trailing: new Icon(Icons.exit_to_app),
      onTap: () => state.signOut(),
    );
  }

  /// Gets the delete account button for this screen.
  Widget _delete(KickItState state, BuildContext context) {
    return new ListTile(
      key: Keys.settingsDeleteKey,
      title: new Text(
        Strings.settingsDelete,
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.red),
        textAlign: TextAlign.right,
      ),
      trailing: new Icon(Icons.delete),
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) => _deleteConfirmDialog(context)).then(
          (value) async {
            if (value == true) {
              state.signOutAndDelete();
            }
          },
        );
      },
    );
  }

  /// Gets the confirmation dialog for the delete account button.
  AlertDialog _deleteConfirmDialog(BuildContext context) {
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
  }
}
