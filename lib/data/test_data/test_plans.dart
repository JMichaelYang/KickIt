import 'dart:async';

import 'package:kickit/data/loader.dart';
import 'package:kickit/data/plan.dart';

/// Provides test [Plan]s with which to test classes that use an [ILoader] in
/// order to load their data.
class TestPlans implements ILoader<Plan> {
  /// Returns a [Stream] of test [Plan]s at a rate of 1 per second for testing
  /// purposes.
  @override
  Stream<Plan> getStream() {
    // StreamController to generate stream.
    StreamController<Plan> controller;
    // Counter to keep track of list index.
    int counter = 0;
    // Timer to make events come out in intervals.
    Timer timer;

    void tick(_) {
      controller.add(plans[counter]);
      counter++;
      if (counter >= plans.length) {
        timer.cancel();
        controller.close();
      }
    }

    void startTimer() {
      timer = new Timer.periodic(new Duration(seconds: 1), tick);
    }

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
    }

    // Set up controller for correct listen, pause, resume, and cancel events.
    controller = new StreamController<Plan>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer,
    );

    return controller.stream;
  }

  static List<Plan> plans = <Plan>[
    test1,
    test2,
    test3,
  ];

  static Plan test1 = new Plan(
    "_",
    "Steast",
    description: "dinner",
    location: "Steast",
  );
  static Plan test2 = new Plan(
    "_",
    "Whole Foods",
    description: "groceries",
    location: "Whole Foods",
    start: new DateTime.utc(2018, 4, 20),
  );
  static Plan test3 = new Plan(
    "_",
    "Breakfast",
    description: "getting breakfast",
    location: "Amelia's",
    start: new DateTime.utc(2018, 7, 4, 11),
    end: new DateTime.utc(2018, 7, 4, 13),
  );
}
