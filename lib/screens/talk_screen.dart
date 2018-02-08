import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/utils/values/internal_strings.dart';

/// Screen that display's the user's current conversations regarding [Plan]s.
class TalkScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TalkScreenState();
  }
}

/// Handles the state for a [TalkScreen].
class _TalkScreenState extends State<TalkScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: new ValueKey(InternalStrings.talkScaffoldKey),
    );
  }
}
