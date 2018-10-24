import 'package:kickit/apis/api_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_profile.dart';

/// A BLoC that handles the manipulation and retrieving of [Profile] data.
class BlocProfile extends BlocBase<BlocProfileState> {
  /// The [ApiProfileBase] that will be used to fetch profiles.
  final ApiProfileBase _api = new InjectorProfile().profileApi;

  /// Creates a new [BlocProfile] with a default state.
  BlocProfile() {
    this.state = new BlocProfileState.empty();
  }

  /// Sets the stream to find a [Profile] with the given [uid].
  void getProfileById(String uid) {
    this.state._loading = true;
    this.controller.add(this.state);
    _api.getProfileById(uid).listen(
      (Profile profile) {
        this.state._profiles = [profile];
        this.state._loading = false;
        this.controller.add(this.state);
      },
    );
  }

  /// Gets all of the [Profile] objects stored.
  void getAllProfiles() {
    this.state._loading = true;
    this.controller.add(this.state);
    _api.getAllProfiles().listen(
      (List<Profile> profiles) {
        this.state._profiles = profiles;
        this.state._loading = false;
        this.controller.add(state);
      },
    );
  }
}

/// Stores state information for a [BlocProfile].
class BlocProfileState {
  /// Whether a [Profile] is currently being loaded.
  bool _loading;

  bool get loading => _loading;

  /// A list of the loaded [Profile] objects.
  List<Profile> _profiles;

  List<Profile> get profiles => _profiles;

  /// Creates a new [BlocProfileState] with the given data.
  BlocProfileState(this._loading, this._profiles);

  /// Creates a new [BlocProfileState] with some default values.
  BlocProfileState.empty() {
    this._loading = false;
    this._profiles = new List<Profile>();
  }
}
