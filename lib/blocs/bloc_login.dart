import 'dart:async';

import 'package:kickit/apis/api_login.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/util/injectors/injector_login.dart';

/// An enumerator representing the state of a login attempt.
enum LoginState {
  WAITING,
  LOGGING_IN,
  LOGGED_IN,
  ERROR,
}

/// A bloc that handles logging in to the app.
class BlocLogin implements BlocBase {
  /// The login api to use.
  final LoginBase _login = new InjectorLogin().login;

  /// A stream communicating the current state of the login attempt.
  StreamController<LoginState> _loginController =
      new StreamController.broadcast<LoginState>();

  StreamSink<LoginState> get loginIn => _loginController.sink;

  Stream<LoginState> get loginOut => _loginController.stream;

  /// Set up a new [BlocLogin] with an injected api and a default state.
  BlocLogin() {
    this.loginIn.add(LoginState.WAITING);
  }

  /// Attempt to log the user in silently.
  void loginSilently() {
    this.loginIn.add(LoginState.LOGGING_IN);
    this._login.loginSilently().then(
      (success) {
        if (success) {
          this.loginIn.add(LoginState.LOGGED_IN);
        } else {
          this.loginIn.add(LoginState.WAITING);
        }
      },
      onError: () => this.loginIn.add(LoginState.ERROR),
    );
  }

  /// Attempt to log the user in, presenting them with a dialog.
  void login() {
    this.loginIn.add(LoginState.LOGGING_IN);
    this._login.login().then(
      (success) {
        if (success) {
          this.loginIn.add(LoginState.LOGGED_IN);
        } else {
          this.loginIn.add(LoginState.WAITING);
        }
      },
      onError: () => this.loginIn.add(LoginState.ERROR),
    );
  }

  /// Dispose the resources allocated by this bloc.
  @override
  void dispose() {
    _loginController.close();
  }
}
