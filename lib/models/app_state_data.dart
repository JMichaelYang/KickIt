import 'package:kickit/data/injectors.dart';
import 'package:kickit/data/plan_store.dart';
import 'package:kickit/data/profile_package.dart';
import 'package:kickit/data/profile_store.dart';
import 'package:kickit/data/sign_in.dart';
import 'package:kickit/models/profile.dart';

/// Keeps track of the current sign in state.
enum SignInState {
  NOT_SIGNED_IN,
  SIGNING_IN,
  FAILED,
  SIGNED_IN,
}

/// Represents the current state of the app.
class AppStateData {
  static final AppStateData _singleton = new AppStateData._initial();

  // The currently logged in profile and its state.
  Profile profile;
  SignInState signInState;

  // A network manager for network operations.
  NetworkManager networkManager;

  /// Creates a new [AppStateData] with the correct initial state.
  AppStateData._initial()
      : this.profile = null,
        this.signInState = SignInState.NOT_SIGNED_IN {
    this.networkManager = new NetworkManager(this);
  }

  factory AppStateData() {
    return _singleton;
  }
}

/// Manages network transactions for the [AppStateData] model.
class NetworkManager {
  // The data that is being managed.
  final AppStateData data;

  // The stores to use for network access.
  final IPlanStore _planStore;
  final IProfileStore _profileStore;
  final ISignIn _signIn;

  /// Creates a new [NetworkManager] with the stores derived from injectors in
  /// order to ensure that the correct source is used.
  NetworkManager(this.data)
      : this._planStore = new PlanInjector().planLoader,
        this._profileStore = new ProfileInjector().profileLoader,
        this._signIn = new SignInInjector().signIn;

  void signIn() async {
    ProfilePackage package = await _signIn.signIn();
    if (package == null) {
      data.signInState = SignInState.FAILED;
    } else {
      data.profile = new Profile.fromPackage(await _signIn.signIn());
      data.signInState = SignInState.SIGNED_IN;
    }
  }
}
