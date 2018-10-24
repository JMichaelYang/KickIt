import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

/// Base class for a login handler.
abstract class LoginBase {
  /// Gets the uid of the currently logged in user.
  String getUid();

  /// Attempts to log the user in silently.
  Future<bool> loginSilently();

  /// Attempts to log the user in with a popup window.
  Future<bool> login();
}

/// Google login api handler.
class Login extends LoginBase {
  /// A single instance of the api handler.
  static final Login _instance = new Login._internal();

  /// The [GoogleSignIn] object for this app.
  GoogleSignIn _signIn;

  /// Internal constructor for the default value.
  Login._internal() {
    _signIn = new GoogleSignIn();
  }

  /// Returns the current instance of [Login].
  factory Login() {
    return _instance;
  }

  /// Gets the uid of the currently logged in user.
  String getUid() {
    return this._signIn?.currentUser?.id;
  }

  /// Attempts to log the user in silently.
  Future<bool> loginSilently() async {
    try {
      await this._signIn.signInSilently();
    } catch (error) {
      return false;
    }

    if (await this._signIn.isSignedIn()) {
      return true;
    }

    return false;
  }

  /// Attempts to log the user in with a popup window.
  Future<bool> login() async {
    try {
      await this._signIn.signIn();
    } catch (error) {
      return false;
    }

    if (await this._signIn.isSignedIn()) {
      return true;
    }

    return false;
  }
}

/// Mock login that logs in after two seconds and always returns the same uid.
class LoginMock extends LoginBase {
  /// A predetermined uid.
  static const String uid = "00001";

  /// Gets the predetermined [uid].
  @override
  String getUid() {
    return uid;
  }

  /// Logs the user in after two seconds.
  @override
  Future<bool> login() {
    return Future.delayed(new Duration(seconds: 2), () => Future.value(true));
  }

  /// Logs the user in after two seconds.
  @override
  Future<bool> loginSilently() {
    return Future.delayed(new Duration(seconds: 2), () => Future.value(true));
  }
}
