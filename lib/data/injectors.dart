import 'package:kickit/data/plan_store.dart';
import 'package:kickit/data/profile_store.dart';
import 'package:kickit/data/sign_in.dart';
import 'package:kickit/models/plan.dart';
import 'package:kickit/models/profile.dart';

/// Represents the two sources where data could be loaded from.
/// - [LOCAL] represents local data (usually for tests).
/// - [REMOTE] represents remote data (usually from a database).
enum Status { LOCAL, REMOTE }

/// A dependency injector that provides a data source for log in data.
class SignInInjector {
  // The singleton instance that will load the correct source.
  static final SignInInjector _singleton = new SignInInjector._internal();
  static Status _status;

  /// Sets up the [SignInInjector] to use the specified source of data,
  /// determined by [status].
  static void configure(Status status) {
    _status = status;
  }

  /// Factory method that returns the [_singleton] for the [SignInInjector].
  factory SignInInjector() {
    return _singleton;
  }

  /// Private constructor so that a [SignInInjector] cannot be instantiated
  /// from the outside.
  SignInInjector._internal();

  /// Gets the correct type of [ISignIn] based on [_status].  Throws a
  /// [StateError] if [_status] has not been set.
  ISignIn get signIn {
    switch (_status) {
      case Status.LOCAL:
        return new MockSignIn();
      case Status.REMOTE:
        return new SignIn();
      default:
        throw new StateError("Loader source not yet specified, be sure to " +
            "call configure before getting a signInLoader.");
    }
  }
}

/// A dependency injector that provides a data source for [Profile] data.
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

  /// Gets the correct type of [IProfileStore] based on [_status].  Throws a
  /// [StateError] if [_status] has not been set.
  IProfileStore get profileLoader {
    switch (_status) {
      case Status.LOCAL:
        return new MockProfileStore();
      case Status.REMOTE:
        return new ProfileStore();
      default:
        throw new StateError("Loader source not yet specified, be sure to " +
            "call configure before getting a profileLoader.");
    }
  }
}

/// A dependency injector that provides a data source for [Plan] data.
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

  /// Gets the correct type of [IPlanStore] based on [_status].  Throws a
  /// [StateError] if [_status] has not been set.
  IPlanStore get planLoader {
    switch (_status) {
      case Status.LOCAL:
        return new MockPlanStore();
      case Status.REMOTE:
        return new PlanStore();
      default:
        throw new StateError("Loader source not yet specified, be sure to " +
            "call configure before getting a planLoader.");
    }
  }
}
