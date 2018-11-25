import 'dart:async';

import 'package:kickit/apis/api_profile.dart';
import 'package:kickit/apis/api_relationship.dart';
import 'package:kickit/blocs/bloc_profile_list_base.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_profile.dart';
import 'package:kickit/util/injectors/injector_relationship.dart';
import 'package:rxdart/subjects.dart';

/// A bloc that handles multiple profile's data.
class BlocFriendsList extends BlocProfileListBase {
  /// The profile api to use.
  final ApiRelationshipBase _apiRelationship;
  final ApiProfileBase _apiProfile;

  /// A stream providing the user's [Profile] data.
  final BehaviorSubject<List<Profile>> _friendsController =
      new BehaviorSubject(seedValue: null);

  StreamSink<List<Profile>> get _profilesIn => _friendsController.sink;

  Stream<List<Profile>> get profilesOut => _friendsController.stream;

  /// A reference to the api [StreamSubscription] so that we can close it.
  StreamSubscription<List<String>> _friendsStream;

  /// Initializes the value of the api for this bloc.
  BlocFriendsList(String uid)
      : _apiRelationship = new InjectorRelationship().relationshipApi,
        _apiProfile = new InjectorProfile().profileApi {
    _friendsStream = _apiRelationship.getAllFriends(uid).listen(
      (List<String> uids) {
        if (uids == null) {
          _profilesIn.add(null);
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
    _friendsStream.cancel();
    _friendsController.close();
  }
}
