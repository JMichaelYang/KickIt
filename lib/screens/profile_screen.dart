import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/utils/values/keys.dart';

/// Screen that display's the user's [Profile] information as well as history.
class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProfileScreenState();
  }
}

/// Handles the state for a [ProfileScreen].
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: Keys.profileScaffoldKey,
    );
  }
}
