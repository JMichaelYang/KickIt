import 'dart:async';

import 'package:kickit/data/loader.dart';
import 'package:kickit/data/plan.dart';

/// Provides test [Plan]s with which to test classes that use an [ILoader] in
/// order to load their data.
class TestPlans implements ILoader<Plan> {
  /// Returns a [List] of test [Plan]s for testing purposes.
  @override
  Future<List<Plan>> fetch() {
    return new Future.value(testPlans);
  }

  static Plan test1 =
      new Plan("_", "Steast", description: "dinner", location: "Steast");
  static Plan test2 = new Plan("_", "Whole Foods",
      description: "groceries",
      location: "Whole Foods",
      start: new DateTime.utc(2018, 4, 20));
  static List<Plan> testPlans = [test1, test2];
}
