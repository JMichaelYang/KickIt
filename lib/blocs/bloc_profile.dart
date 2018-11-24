import 'dart:async';

import 'package:kickit/apis/api_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_profile.dart';
import 'package:rxdart/subjects.dart';

/// A bloc that handles a single profile's data.
class BlocProfile extends BlocBase {
  /// The profile api to use.
  final ApiProfileBase _api;

  /// A stream providing the user's [Profile] data.
  final BehaviorSubject<Profile> _profileController = new BehaviorSubject(
    seedValue: null,
  );

  StreamSink<Profile> get profileIn => _profileController.sink;

  Stream<Profile> get profileOut => _profileController.stream;

  /// A reference to the Firestore [StreamSubscription] so that we can close it
  /// when we need to.
  StreamSubscription<Profile> _profileStream;

  /// Listens to the events produced by Firestore and passes along the profiles
  /// to its listener.
  BlocProfile(String uid) : _api = new InjectorProfile().profileApi {
    _profileStream = _api.getProfileById(uid).listen(
          (Profile profile) => profileIn.add(profile),
        );
  }

  /// Dispose the resources used by this bloc.
  @override
  void dispose() {
    _profileStream.cancel();
    _profileController.close();
  }
}
