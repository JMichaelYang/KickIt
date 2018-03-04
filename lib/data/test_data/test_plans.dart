import 'package:kickit/models/plan.dart';

/// Provides test [Plan]s with which to test classes that need them.
final List<Plan> plans = <Plan>[
  test1,
  test2,
  test3,
];

final Plan test1 = new Plan(
  "_",
  "_",
  "Steast",
  description: "dinner",
  location: "Steast",
);
final Plan test2 = new Plan(
  "_",
  "_",
  "Whole Foods",
  description: "groceries",
  location: "Whole Foods",
  start: new DateTime.utc(2018, 4, 20),
);
final Plan test3 = new Plan(
  "_",
  "_",
  "Breakfast",
  description: "getting breakfast",
  location: "Amelia's",
  start: new DateTime.utc(2018, 7, 4, 11),
  end: new DateTime.utc(2018, 7, 4, 13),
);
