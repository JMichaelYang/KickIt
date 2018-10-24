import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/screens/login_screen.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/profile_details_widget.dart';
import 'package:kickit/widgets/profile_list_widget.dart';

/// The main screen of the widget, holding three tabs that allow for navigation
/// between three distinct pages.
class MainScreen extends StatelessWidget {
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
    return new TabBarView(
      children: <Widget>[
        new Icon(Icons.schedule),
        new ProfileListWidget(),
        new ProfileDetailsWidget(),
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
