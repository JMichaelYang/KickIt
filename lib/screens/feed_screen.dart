import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/utils/values/internal_strings.dart';

/// Screen that display's the public plans that this user can view.
class FeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FeedScreenState();
  }
}

/// Handles the state for a [TalkScreen].
class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: new ValueKey(InternalStrings.feedScaffoldKey),
    );
  }
}
