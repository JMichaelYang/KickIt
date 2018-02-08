import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/utils/authenticator.dart';
import 'package:kickit/utils/values/internal_strings.dart';
import 'package:kickit/utils/values/strings.dart';

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
      key: new ValueKey(InternalStrings.settingsScaffoldKey),
      appBar: _appBar(),
      body: _body(),
    );
  }

  /// Gets the [AppBar] to use for this screen.
  AppBar _appBar() {
    return new AppBar(
      key: new ValueKey(InternalStrings.settingsAppBarKey),
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
      key: new ValueKey(InternalStrings.settingsBodyKey),
      children: <Widget>[
        _logout(),
      ],
    );
  }

  /// Gets the logout button for this screen.
  ListTile _logout() {
    return new ListTile(
      key: new ValueKey(InternalStrings.settingsLogoutKey),
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
}
