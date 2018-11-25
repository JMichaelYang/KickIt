import 'dart:async';

import 'package:kickit/apis/api_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:rxdart/subjects.dart';

/// An enumerator representing the state of a login attempt.
enum LoginState {
  LOGGING_OUT,
  LOGGED_OUT,
  LOGGING_IN_SILENTLY,
  LOGGED_OUT_SILENT,
  LOGGING_IN,
  LOGGED_IN,
  ERROR,
}

/// A bloc that handles logging in to the app.
class BlocLogin implements BlocBase {
  /// The login api to use.
  final LoginBase _login;

  /// A stream communicating the current state of the login attempt.
  final BehaviorSubject<LoginState> _loginController = new BehaviorSubject(
    seedValue: LoginState.LOGGED_OUT,
  );

  StreamSink<LoginState> get loginIn => _loginController.sink;

  Stream<LoginState> get loginOut => _loginController.stream;

  /// Initializes the value of the login api to use.
  BlocLogin() : _login = new InjectorLogin().login {
    _loginController.stream.listen(_onData);
  }

  /// Handles data events passed from the widgets that use this bloc.
  void _onData(LoginState state) {
    switch (state) {
      case LoginState.LOGGING_OUT:
        _logout();
        break;
      case LoginState.LOGGING_IN_SILENTLY:
        _doLogin(silently: true);
        break;
      case LoginState.LOGGING_IN:
        _doLogin(silently: false);
        break;
      default:
        // On logged in, logged out, or error, nothing should happen.
        break;
    }
  }

  /// Attempt to log the user in silently.
  void _doLogin({bool silently = false}) {
    _login.login(silently: silently).then(
      (success) {
        if (success) {
          loginIn.add(LoginState.LOGGED_IN);
        } else {
          loginIn.add(
              silently ? LoginState.LOGGED_OUT_SILENT : LoginState.LOGGED_OUT);
        }
      },
      onError: () => loginIn.add(LoginState.ERROR),
    );
  }

  /// Log the user out.
  void _logout() {
    _login.logout().then(
      (success) {
        if (success) {
          loginIn.add(LoginState.LOGGED_OUT);
        } else {
          loginIn.add(LoginState.LOGGED_IN);
        }
      },
      onError: () => loginIn.add(LoginState.ERROR),
    );
  }

  /// Dispose the resources allocated by this bloc.
  @override
  void dispose() {
    _loginController.close();
  }
}
