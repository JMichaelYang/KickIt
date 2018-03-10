import 'package:kickit/database/plan_package.dart';

/// Provides test [PlanPackage]s with which to test classes that need them.
final PlanPackage test1 = new PlanPackage(
  "_",
  "_",
  "Steast",
  "dinner",
  "Steast",
  null,
  null,
);
final PlanPackage test2 = new PlanPackage(
  "_",
  "_",
  "Whole Foods",
  "groceries",
  "Whole Foods",
  new DateTime.utc(2018, 4, 20).millisecondsSinceEpoch,
  null,
);
final PlanPackage test3 = new PlanPackage(
  "_",
  "_",
  "Breakfast",
  "getting breakfast",
  "Amelia's",
  new DateTime.utc(2018, 7, 4, 11).millisecondsSinceEpoch,
  new DateTime.utc(2018, 7, 4, 13).millisecondsSinceEpoch,
);

final List<PlanPackage> testPlans = <PlanPackage>[
  test1,
  test2,
  test3,
];
