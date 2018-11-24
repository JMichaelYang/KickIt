import 'package:kickit/data/profile.dart';
import 'package:kickit/data/relationship.dart';

/// A mcck database storing testing data.
abstract class DatabaseMock {
  // A mock list of profiles for testing.
  static List<Profile> profiles = [
    new Profile("00001", "Jaewon Yang", "Developer"),
    new Profile("00002", "Malcolm Canterbury", "Developer"),
    new Profile("00003", "Anton Panis", "Loser"),
    new Profile("00004", "Riley Nichol", "Friend"),
    new Profile("00005", "Kio Murayama", "BU loser"),
    new Profile("00006", "Mathew Lee", "Roommate"),
    new Profile("00007", "Spencer Ong", "Roommate"),
    new Profile("00008", "Josho Tanaka", "Roommate"),
    new Profile("00009", "Mina Yang", "Mother"),
    new Profile("00010", "Keith Yang", "Father"),
    new Profile("00011", "Kiwon Yang", "Younger brother"),
    new Profile("00012", "Seri Yang", "Younger sister"),
  ];

  // A mock list of relationships for testing.
  static List<Relationship> relationships = [
    new Relationship(
      "00001",
      "00002",
      0,
      new DateTime(2018, 11, 3),
      new DateTime(2018, 11, 3),
    ),
    new Relationship(
      "00003",
      "00001",
      0,
      new DateTime(2018, 10, 3),
      new DateTime(2018, 10, 3),
    ),
    new Relationship(
      "00001",
      "00004",
      0,
      new DateTime(2018, 8, 3),
      new DateTime(2018, 9, 3),
    ),
    new Relationship(
      "00007",
      "00008",
      0,
      new DateTime(2018, 9, 3),
      new DateTime(2018, 10, 3),
    ),
    new Relationship(
      "00006",
      "00001",
      1,
      new DateTime(2018, 8, 8),
      null,
    ),
    new Relationship(
      "00001",
      "00012",
      0,
      new DateTime(2018, 7, 24),
      null,
    ),
    new Relationship(
      "00001",
      "00005",
      3,
      new DateTime(2018, 3, 21),
      null,
    ),
  ];
}
