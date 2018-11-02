import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          onPressed: null,
        ),
      ),
    );
  }
}
