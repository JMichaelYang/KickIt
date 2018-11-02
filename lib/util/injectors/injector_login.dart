import 'package:kickit/apis/api_login.dart';

/// Two different sources for where to get login data.
enum LoginFlavor {
  REMOTE,
  LOCAL,
}

/// Login dependency injector.
class InjectorLogin {
  /// A single instance of the injector.
  static final InjectorLogin _instance = new InjectorLogin._internal();

  /// The flavor to use when generating a new login helper.
  static LoginFlavor _flavor;

  /// Internal constructor for the default value.
  InjectorLogin._internal();

  /// Returns the current instance of [InjectorLogin].
  factory InjectorLogin() {
    return _instance;
  }

  /// Configures [InjectorLogin] to use the given flavor.
  static void configure(LoginFlavor flavor) {
    _flavor = flavor;
  }

  /// Produces a new [LoginBase] based on the current flavor.
  LoginBase get login {
    switch (_flavor) {
      case LoginFlavor.LOCAL:
        return new LoginMock();
        break;
      default:
        return new Login();
        break;
    }
  }
}
