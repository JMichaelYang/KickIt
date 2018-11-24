import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_profile_list.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/screens/settings_screen.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/profile_details_widget.dart';
import 'package:kickit/widgets/profile_list_widget.dart';

/// The main screen of the app, holding three tabs that allow for navigation
/// between three distinct pages.
class MainScreen extends StatefulWidget {
  /// Get the state that represents this screen.
  @override
  State<StatefulWidget> createState() {
    return new _MainScreenState();
  }
}

/// Manages state for the [MainScreen].
class _MainScreenState extends State<MainScreen> {
  BlocProfileList _profilesBloc;

  /// Gets bloc references and performs some initial requests.
  @override
  void initState() {
    _profilesBloc = BlocProvider.of<BlocProfileList>(context);
    _profilesBloc.requestAllFriends(new InjectorLogin().login.uid);
    super.initState();
  }

  /// Builds the screen.
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: new Scaffold(
        appBar: _getAppBar(context),
        body: _getBody(context),
        bottomNavigationBar: _getNavigationBar(context),
      ),
    );
  }

  /// Gets the app bar for this screen.
  Widget _getAppBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: new Text(
        APP_TITLE,
        style: Theme.of(context).textTheme.title,
      ),
      actions: <Widget>[
        _getSettingsButton(context),
      ],
    );
  }

  Widget _getSettingsButton(BuildContext context) {
    return new IconButton(
      icon: new Icon(Icons.settings),
      onPressed: () => Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) => new SettingsScreen(),
            ),
          ),
    );
  }

  /// Gets the body content for this screen.
  Widget _getBody(BuildContext context) {
    return new TabBarView(
      children: <Widget>[
        new Icon(Icons.schedule),
        new ProfileListWidget(_profilesBloc.profilesOut),
        profileDetailsWrapper(new InjectorLogin().login.uid),
      ],
    );
  }

  /// Gets the bottom navigation bar for this screen.
  Widget _getNavigationBar(BuildContext context) {
    return new TabBar(
      tabs: [
        new Tab(icon: new Icon(Icons.schedule)),
        new Tab(icon: new Icon(Icons.list)),
        new Tab(icon: new Icon(Icons.person)),
      ],
    );
  }
}
