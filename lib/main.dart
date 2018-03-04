import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kickit/data/injectors.dart';
import 'package:kickit/middleware/app_state_middleware.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/reducers/app_state_reducer.dart';
import 'package:kickit/screens/main_screen.dart';
import 'package:kickit/screens/settings_screen.dart';
import 'package:kickit/screens/splash_screen.dart';
import 'package:kickit/utils/values/internal_strings.dart';
import 'package:kickit/utils/values/strings.dart';
import 'package:redux/redux.dart';

void main() {
  // Set up the the correct loader source
  ProfileInjector.configure(Status.LOCAL);
  PlanInjector.configure(Status.LOCAL);
  SignInInjector.configure(Status.LOCAL);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final Store store = new Store<AppState>(
    appReducer,
    initialState: new AppState.initial(),
    middleware: createAppStateMiddleware(),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: Strings.title,
        theme: new ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: new SplashScreen(),
        routes: {
          InternalStrings.mainScreenRoute: (BuildContext context) =>
              new MainScreen(),
          InternalStrings.settingsScreenRoute: (BuildContext context) =>
              new SettingsScreen(),
        },
      ),
    );
  }
}
