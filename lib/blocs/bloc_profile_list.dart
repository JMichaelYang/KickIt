import 'dart:async';

import 'package:kickit/apis/api_profile.dart';
import 'package:kickit/apis/firestore/firestore_utils.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_profile.dart';

/// A bloc that handles multiple profile's data.
class BlocProfileList extends BlocBase {
  /// The profile api to use.
  final ApiProfileBase _api = new InjectorProfile().profileApi;

  /// A stream providing the user's [Profile] data.
  StreamController<List<Profile>> _profilesController =
      new StreamController.broadcast();

  StreamSink<List<Profile>> get _profilesIn => _profilesController.sink;

  Stream<List<Profile>> get profilesOut => _profilesController.stream;

  /// Request all of the profiles.
  void requestAllProfiles() {
    _api.getAllProfiles().then(
      (List<Profile> profiles) {
        _profilesIn.add(profiles);
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
    _profilesController.close();
  }
}
