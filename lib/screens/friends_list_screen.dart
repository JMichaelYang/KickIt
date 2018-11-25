import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/widgets/profile_list_widget.dart';

/// The screen that displays the friend information.
class FriendsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: profileListFriendsWrapper(new InjectorLogin().login.uid),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  /// Gets the floating action button that adds friends.
  Widget _getFloatingActionButton() {
    return new FloatingActionButton(
      onPressed: null,
      child: new Icon(Icons.add),
    );
  }
}
