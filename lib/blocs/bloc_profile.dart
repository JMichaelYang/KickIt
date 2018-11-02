import 'dart:async';

import 'package:kickit/apis/api_profile.dart';
import 'package:kickit/apis/firestore/firestore_utils.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_profile.dart';

/// A bloc that handles a single profile's data.
class BlocProfile extends BlocBase {
  /// The profile api to use.
  final ApiProfileBase _api = new InjectorProfile().profileApi;

  /// A stream providing the user's [Profile] data.
  StreamController<Profile> _profileController =
      new StreamController.broadcast();

  StreamSink<Profile> get _profileIn => _profileController.sink;

  Stream<Profile> get profileOut => _profileController.stream;

  /// Request the user's profile.
  void requestProfile(String uid) {
    _api.getProfileById(uid).then(
      (Profile profile) {
        if(!_profileController.isClosed) {
          _profileIn.add(profile);
        }
      },
      onError: () => throw new DatabaseError(
            message: "Failed to get profile information from the database",
          ),
    );
  }

  /// Dispose the resources used by this bloc.
  @override
  void dispose() {
    print("Disposed profile controller.");
    _profileController.close();
  }
}
