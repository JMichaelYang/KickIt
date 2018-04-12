import 'package:kickit/data/profile_package.dart';

/// Provides test [ProfilePackage]s with which to test classes that need them.
final ProfilePackage test1 = new ProfilePackage(
  "1",
  "Jaewon Yang",
  "_",
  "Test profile 1",
);
final ProfilePackage test2 = new ProfilePackage(
  "2",
  "Matt Urrea",
  "_",
  "Test profile 2",
);
final ProfilePackage test3 = new ProfilePackage(
  "_",
  "Woo Sek Chung",
  "_",
  "Test profile 3",
);
final ProfilePackage test4 = new ProfilePackage(
  "_",
  "Rohit Pathak",
  "_",
  "Test profile 4",
);

/// Consolidated list of all test profiles.
final List<ProfilePackage> testProfiles = [test1, test2, test3, test4];
