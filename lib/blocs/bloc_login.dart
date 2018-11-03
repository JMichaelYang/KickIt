import 'dart:async';

import 'package:kickit/apis/api_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/util/injectors/injector_login.dart';

/// An enumerator representing the state of a login attempt.
enum LoginState {
  WAITING,
  LOGGING_IN,
  ERROR,
}

/// A bloc that handles logging in to the app.
class BlocLogin implements BlocBase {
  /// The login api to use.
  final LoginBase _login = new InjectorLogin().login;

  /// A stream communicating the current state of the login attempt.
  StreamController<LoginState> _loginController =
      new StreamController.broadcast();

  StreamSink<LoginState> get loginIn => _loginController.sink;

  Stream<LoginState> get loginOut => _loginController.stream;

  /// A stream communicating when a login attempt succeeds.
  StreamController<bool> _loggedInController = new StreamController.broadcast();

  StreamSink<bool> get _loggedInIn => _loggedInController.sink;

  Stream<bool> get loggedInOut => _loggedInController.stream;

  /// Attempt to log the user in silently.
  void loginSilently() {
    loginIn.add(LoginState.LOGGING_IN);
    _login.loginSilently().then(
      (success) {
        if (success) {
          _loggedInIn.add(true);
        } else {
          loginIn.add(LoginState.WAITING);
        }
      },
      onError: () => loginIn.add(LoginState.ERROR),
    );
  }

  /// Attempt to log the user in, showing them a login dialog.
  void login() {
    loginIn.add(LoginState.LOGGING_IN);
    _login.login().then(
      (success) {
        if (success) {
          _loggedInIn.add(true);
        } else {
          loginIn.add(LoginState.WAITING);
        }
      },
      onError: () => loginIn.add(LoginState.ERROR),
    );
  }

  /// Log the user out.
  Future<bool> logout() async {
    return await _login.logout();
  }

  /// Dispose the resources allocated by this bloc.
  @override
  void dispose() {
    _loginController.close();
    _loggedInController.close();
  }
}
