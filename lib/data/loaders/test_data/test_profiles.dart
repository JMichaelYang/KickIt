import 'dart:async';

import 'package:kickit/data/loaders/loader.dart';
import 'package:kickit/data/profile.dart';

/// Provides test [Profile]s with which to test classes that use an [ILoader] in
/// order to load their data.
class TestProfiles implements ILoader<Profile> {
  /// Returns a [Stream] of test [Profile]s at a rate of 1 per second for
  /// testing purposes.
  @override
  Stream<Profile> getStream() {
    // StreamController to generate stream.
    StreamController<Profile> controller;
    // Counter to keep track of list index.
    int counter = 0;
    // Timer to make events come out in intervals.
    Timer timer;

    void tick(_) {
      controller.add(profiles[counter]);
      counter++;
      if (counter >= profiles.length) {
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
    controller = new StreamController<Profile>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer,
    );

    return controller.stream;
  }

  static List<Profile> profiles = <Profile>[
    test1,
    test2,
    test3,
  ];

  static Profile test1 =
      new Profile("_", "Jaewon Yang", "_", description: "Test profile 1");
  static Profile test2 =
      new Profile("_", "Matt Urrea", "_", description: "Test profile 2");
  static Profile test3 =
      new Profile("_", "Woo Sek Chung", "_", description: "Test profile 3");
  static List<Profile> testProfiles = [test1, test2, test3];
}
