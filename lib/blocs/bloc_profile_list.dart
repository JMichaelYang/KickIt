import 'dart:async';

import 'package:kickit/apis/api_profile.dart';
import 'package:kickit/apis/api_relationship.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_profile.dart';
import 'package:kickit/util/injectors/injector_relationship.dart';

/// A bloc that handles multiple profile's data.
class BlocProfileList extends BlocBase {
  /// The profile api to use.
  final ApiRelationshipBase _apiRelationship;
  final ApiProfileBase _apiProfile;

  /// Initializes the value of the api for this bloc.
  BlocProfileList()
      : _apiRelationship = new InjectorRelationship().relationshipApi,
        _apiProfile = new InjectorProfile().profileApi;

  /// A stream providing the user's [Profile] data.
  StreamController<List<Profile>> _profilesController =
      new StreamController.broadcast();

  StreamSink<List<Profile>> get _profilesIn => _profilesController.sink;

  Stream<List<Profile>> get profilesOut => _profilesController.stream;

  /// Request all of the friends of user with the given [uid].
  void requestAllFriends(String uid) {
    _apiRelationship.getAllFriends(uid).listen(
      (List<String> uids) {
        if (uids == null) {
          _profilesIn.add(new List<Profile>());
        } else {
          Iterable<Future<Profile>> profiles =
              uids.map((uid) => _apiProfile.getProfileById(uid).first);
          Future.wait(profiles).then((profiles) => _profilesIn.add(profiles));
        }
      },
    );
  }

  /// Dispose the resources used by this bloc.
  @override
  void dispose() {
    print("Disposed profile controller.");
    _profilesController.close();
  }
}
