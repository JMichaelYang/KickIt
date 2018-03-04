/// A collection of methods that handle the loading and saving of [Plan]s to
/// and from Firebase.
abstract class IPlanStore {}

/// Performs [IPlanStore] obligations with real remote data.
class PlanStore implements IPlanStore {
  PlanStore() {
    throw new UnimplementedError("Plan store not implemented.");
  }
}

/// Performs [IPlanStore] obligations with local test data.
class MockPlanStore implements IPlanStore {
  MockPlanStore() {
    throw new UnimplementedError("Mock plan store not implemented.");
  }
}
