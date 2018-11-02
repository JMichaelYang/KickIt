import 'dart:async';

import 'package:kickit/apis/api_login.dart';
import 'package:kickit/apis/api_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/injectors/injector_profile.dart';

/// A bloc that handles the user's profile data.
class BlocUserProfile extends BlocBase {
  /// The profile api to use.
  final ApiProfileBase _api = new InjectorProfile().profileApi;

  /// The login api to use.
  final LoginBase _login = new InjectorLogin().login;

  /// A stream providing the user's [Profile] data.
  StreamController<Profile> _profileController =
      new StreamController.broadcast();

  /// Dispose the resources used by this bloc.
  @override
  void dispose() {
    _profileController.close();
  }
}
