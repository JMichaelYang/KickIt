import 'package:kickit/data/loaders/loader.dart';
import 'package:kickit/data/loaders/test_data/test_plans.dart';
import 'package:kickit/data/loaders/test_data/test_profiles.dart';
import 'package:kickit/models/plan.dart';
import 'package:kickit/models/profile.dart';

/// Represents the two sources where data could be loaded from.
/// - [LOCAL] represents local data (usually for tests).
/// - [REMOTE] represents remote data (usually from a database).
enum Status { LOCAL, REMOTE }

/// A dependency injector that provides a data source for [Profile] data for an
/// [ILoader] that handles [Profile]s.
class ProfileInjector {
  // The singleton instance that will load the correct source.
  static final ProfileInjector _singleton = new ProfileInjector._internal();
  static Status _status;

  /// Sets up the [ProfileInjector] to use the specified source of data,
  /// determined by [status].
  static void configure(Status status) {
    _status = status;
  }

  /// Factory method that returns the [_singleton] for the [ProfileInjector].
  factory ProfileInjector() {
    return _singleton;
  }

  /// Private constructor so that a [ProfileInjector] cannot be instantiated
  /// from the outside.
  ProfileInjector._internal();

  /// Gets the correct type of [ILoader] based on [_status].  Throws a
  /// [StateError] if [_status] has not been set.
  ILoader<Profile> get profileLoader {
    switch (_status) {
      case Status.LOCAL:
        return new TestProfiles();
      case Status.REMOTE:
        // TODO: Implement remote repository
        throw new StateError("Remote loader not implemented yet.");
      default:
        throw new StateError("Loader source not yet specified, be sure to " +
            "call configure before getting a profileLoader.");
    }
  }
}

/// A dependency injector that provides a data source for [Plan] data for an
/// [ILoader] that handles [Plan]s.
class PlanInjector {
  // The singleton instance that will load the correct source.
  static final PlanInjector _singleton = new PlanInjector._internal();
  static Status _status;

  /// Sets up the [PlanInjector] to use the specified source of data,
  /// determined by [status].
  static void configure(Status status) {
    _status = status;
  }

  /// Factory method that returns the [_singleton] for the [PlanInjector].
  factory PlanInjector() {
    return _singleton;
  }

  /// Private constructor so that a [PlanInjector] cannot be instantiated
  /// from the outside.
  PlanInjector._internal();

  /// Gets the correct type of [ILoader] based on [_status].  Throws a
  /// [StateError] if [_status] has not been set.
  ILoader<Plan> get planLoader {
    switch (_status) {
      case Status.LOCAL:
        return new TestPlans();
      case Status.REMOTE:
        // TODO: Implement remote repository
        throw new StateError("Remote loader not implemented yet.");
      default:
        throw new StateError("Loader source not yet specified, be sure to " +
            "call configure before getting a planLoader.");
    }
  }
}
