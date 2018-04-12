import 'package:flutter/material.dart';
import 'package:kickit/data/injectors.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/screens/main_screen.dart';
import 'package:kickit/screens/settings_screen/settings_screen_container.dart';
import 'package:kickit/screens/splash_screen/splash_screen_container.dart';
import 'package:kickit/utils/values/internal_strings.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:kickit/utils/values/strings.dart';

void main() {
  // Set up the the correct loader source
  ProfileInjector.configure(Status.REMOTE);
  PlanInjector.configure(Status.LOCAL);
  SignInInjector.configure(Status.REMOTE);

  /// Run a new app with a default app state.
  runApp(
    new AppState(
      child: new KickIt(),
    ),
  );
}

/// A main app instance with the given data.
class KickIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      navigatorKey: Keys.navigatorKey,
      title: Strings.title,
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new SplashScreenContainer(),
      routes: {
        InternalStrings.mainScreenRoute: (BuildContext context) =>
            new MainScreen(),
        InternalStrings.settingsScreenRoute: (BuildContext context) =>
            new SettingsScreenContainer(),
      },
    );
  }
}
