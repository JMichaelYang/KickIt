import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/apis/api_login.dart';
import 'package:kickit/blocs/bloc_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/profile_details_widget.dart';

/// The main screen of the widget, holding three tabs that allow for navigation
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
  @override
  void initState() {
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
      title: new Center(
        child: new Text(
          APP_TITLE,
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }

  /// Gets the body content for this screen.
  Widget _getBody(BuildContext context) {
    return new BlocProvider(
      bloc: new BlocProfile(),
      child: new TabBarView(
        children: <Widget>[
          new Icon(Icons.schedule),
          new Icon(Icons.list), // new ProfileListWidget(),
          new ProfileDetailsWidget(new Login().uid),
        ],
      ),
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
