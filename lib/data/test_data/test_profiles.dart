import 'dart:async';

import 'package:kickit/data/loader.dart';
import 'package:kickit/data/profile.dart';

/// Provides test [Profile]s with which to test classes that use an [ILoader] in
/// order to load their data.
class TestProfiles implements ILoader<Profile> {
  /// Returns a [List] of test [Profile]s for testing purposes.
  @override
  Future<List<Profile>> fetch() {
    return new Future.value(testProfiles);
  }

  static Profile test1 =
      new Profile("_", "Jaewon Yang", "_", description: "Test profile 1");
  static Profile test2 =
      new Profile("_", "Matt Urrea", "_", description: "Test profile 2");
  static Profile test3 =
      new Profile("_", "Woo Sek Chung", "_", description: "Test profile 3");
  static List<Profile> testProfiles = [test1, test2, test3];
}
