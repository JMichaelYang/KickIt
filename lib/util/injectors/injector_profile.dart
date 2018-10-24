import 'package:kickit/apis/api_profile.dart';

/// Two different sources for where to get profile data.
enum ProfileFlavor {
  REMOTE,
  LOCAL,
}

/// Profile dependency injector.
class InjectorProfile {
  /// A single instance of the injector.
  static final InjectorProfile _instance = new InjectorProfile._internal();

  /// The flavor to use when generating a new [ApiProfileBase].
  static ProfileFlavor _flavor;

  /// Internal constructor for the default value.
  InjectorProfile._internal() {
    _flavor = ProfileFlavor.LOCAL;
  }

  /// Returns the current instance of [InjectorProfile].
  factory InjectorProfile() {
    return _instance;
  }

  /// Configures [InjectorProfile] to use the given flavor.
  static void configure(ProfileFlavor flavor) {
    _flavor = flavor;
  }

  /// Produces a new [ApiProfileBase] based on the current flavor.
  ApiProfileBase get profileApi {
    switch (_flavor) {
      case ProfileFlavor.LOCAL:
        return new ApiProfileMock();
        break;
      default:
        return new ApiProfile();
        break;
    }
  }
}
