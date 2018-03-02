import 'package:kickit/models/plan.dart';
import 'package:test/test.dart';

/// Tests for the [Plan] class.
void main() {
  test("Plan Default Constructor Test", () {
    // Test Plan constructor with no optional parameters.
    Plan plan = new Plan("_", "_", "Title");
    expect(plan.id, "_");
    expect(plan.ownerId, "_");
    expect(plan.title, "Title");
    // Add values for optional parameters.
    plan.description = "Desc";
    plan.location = "Loc";
    plan.start = new DateTime(2018);
    plan.end = new DateTime(2019);
    expect(plan.description, "Desc");
    expect(plan.location, "Loc");
    expect(plan.start, new DateTime(2018));
    expect(plan.end, new DateTime(2019));
  });

  test("Plan Mapping Test", () {
    Plan plan = new Plan("_", "_", "Title",
        description: "Desc",
        location: "Loc",
        start: new DateTime.utc(2018),
        end: new DateTime.utc(2019));
    Map<String, dynamic> map = plan.toMap();
    expect(map[Plan.idKey], "_");
    expect(map[Plan.ownerIdKey], "_");
    expect(map[Plan.titleKey], "Title");
    expect(map[Plan.descriptionKey], "Desc");
    expect(map[Plan.locationKey], "Loc");
    expect(map[Plan.startKey], 1514764800000);
    expect(map[Plan.endKey], 1546300800000);

    Plan newPlan = Plan.empty.fromMap(map);
    expect(newPlan.id, "_");
    expect(newPlan.ownerId, "_");
    expect(newPlan.title, "Title");
    expect(newPlan.description, "Desc");
    expect(newPlan.location, "Loc");
    expect(newPlan.start, new DateTime.utc(2018));
    expect(newPlan.end, new DateTime.utc(2019));
  });

  test("Plan Invalid Args", () {
    expect(() => new Plan(null, "_", "Title"),
        throwsA(new isInstanceOf<ArgumentError>()));
    expect(() => new Plan("_____", null, "Title"),
        throwsA(new isInstanceOf<ArgumentError>()));
    expect(() => new Plan("_____", "_", null),
        throwsA(new isInstanceOf<ArgumentError>()));
    expect(() => new Plan("___", "_", "abc"),
        throwsA(new isInstanceOf<ArgumentError>()));
    expect(
        () => new Plan("_", "_", "Title",
            start: new DateTime.utc(2018), end: new DateTime.utc(2017)),
        throwsA(new isInstanceOf<ArgumentError>()));
  });
}
