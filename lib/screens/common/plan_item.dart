import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/models/plan.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:meta/meta.dart';

/// Displays a plan as a card, normally used in a [ListView].
class PlanItem extends StatelessWidget {
  // The plan to display.
  final Plan plan;

  /// Creates a new [PlanItem] with the given [Plan].
  PlanItem({@required this.plan});

  @override
  Widget build(BuildContext context) {
    return new Card(
      key: Keys.feedPlanItemKey(plan.id),
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
