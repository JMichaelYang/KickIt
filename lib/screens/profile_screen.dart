import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/models/kickit.dart';
import 'package:kickit/utils/values/keys.dart';

/// Handles the state for a [ProfileScreen].
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KickItState state = KickIt.of(context);

    return new Scaffold(
      key: Keys.profileScaffoldKey,
    );
  }
}
