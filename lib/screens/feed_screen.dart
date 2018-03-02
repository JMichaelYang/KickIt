import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/data/injectors.dart';
import 'package:kickit/models/plan.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:kickit/utils/values/strings.dart';

/// Screen that display's the public plans that this user can view.
class FeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FeedScreenState();
  }
}

/// Handles the state for a [FeedScreen].
class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: Keys.feedScaffoldKey,
      body: _feed(),
    );
  }

  /// Gets a [StreamBuilder] that shows all the plans that are currently
  /// viewable. The [Stream] comes from a [Plan]s [Loader].
  /// TODO: Implement search and other filters.
  Widget _feed() {
    return new StreamBuilder(
      key: Keys.feedListKey,
      stream: new PlanInjector().planLoader.getStream(),
      builder: (BuildContext context, AsyncSnapshot<Plan> snapshot) {
        // If the Stream has an error, show a text widget that has the error.
        if (snapshot.hasError) {
          return new Text(
            "Error: ${snapshot.error}",
            style: Theme.of(context).textTheme.body1,
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text(
              Strings.feedNone,
              style: Theme.of(context).textTheme.body1,
            );
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          case ConnectionState.active:
            return _planCard(snapshot.data);
          case ConnectionState.done:
            return new Text(
              Strings.feedClosed,
              style: Theme.of(context).textTheme.body1,
            );
          default:
        }
      },
    );
  }

  /// Gets a [Card] that displays the details of the given [Plan].
  Card _planCard(Plan plan) {
    return new Card(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Text(
            plan.title,
            style: Theme.of(context).textTheme.title,
          ),
          new Text(
            plan.location,
            style: Theme.of(context).textTheme.subhead,
          ),
        ],
      ),
    );
  }
}
