import 'package:flutter/material.dart';
import 'package:kickit/blocs/bloc_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/screens/login_screen.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/injectors/injector_profile.dart';
import 'package:kickit/widgets/themes.dart';

void main() {
  // Set up dependency injection.
  InjectorProfile.configure(ProfileFlavor.LOCAL);
  InjectorLogin.configure(LoginFlavor.LOCAL);

  runApp(
    new BlocProvider<BlocProfile>(
      bloc: new BlocProfile(),
      child: new KickItApp(),
    ),
  );
}

class KickItApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "KickIt",
      theme: dark,
      home: new LoginScreen(),
    );
  }
}
