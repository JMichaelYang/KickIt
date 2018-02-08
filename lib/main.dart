import 'package:flutter/material.dart';
import 'package:kickit/data/injectors.dart';
import 'package:kickit/screens/main_screen.dart';
import 'package:kickit/screens/settings_screen.dart';
import 'package:kickit/screens/splash_screen.dart';
import 'package:kickit/utils/values/internal_strings.dart';
import 'package:kickit/utils/values/strings.dart';

void main() {
  // Set up the the correct loader source
  ProfileInjector.configure(Status.LOCAL);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.title,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SplashScreen(),
      routes: {
        InternalStrings.mainScreenRoute: (BuildContext context) =>
            new MainScreen(),
        InternalStrings.settingsScreenRoute: (BuildContext context) =>
            new SettingsScreen(),
      },
    );
  }
}
