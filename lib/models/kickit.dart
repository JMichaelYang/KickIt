import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:kickit/data/injectors.dart';
import 'package:kickit/data/plan_store.dart';
import 'package:kickit/data/profile_store.dart';
import 'package:kickit/data/sign_in.dart';
import 'package:kickit/models/actions/sign_in_actions.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/models/profile.dart';
import 'package:kickit/utils/values/internal_strings.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:meta/meta.dart';

/// A root level widget that stores the state data for this application.
class KickIt extends StatefulWidget {
  // The child widget that will live under this one.
  final Widget child;
  final IPlanStore planStore;
  final IProfileStore profileStore;
  final ISignIn signIn;

  /// Creates a new [KickIt] widget with the given child.
  KickIt({@required this.child})
      : planStore = new PlanInjector().planLoader,
        profileStore = new ProfileInjector().profileLoader,
        signIn = new SignInInjector().signIn;

  @override
  State<StatefulWidget> createState() {
    return new KickItState();
  }

  static KickItState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_Inherited) as _Inherited)
        .state;
  }
}

/// Houses and manipulates the app's current state. Other widgets have access
/// to this state through their given [BuildContext], and can use that
/// reference in order to access the app's state.
class KickItState extends State<KickIt> {
  // The app's current state.
  AppState state;

  Profile get profile => state.profile;

  SignInState get signInState => state.signInState;

  @override
  void initState() {
    if (state == null) {
      state = new AppState.initial();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new _Inherited(child: widget.child, state: this);
  }

  Future<Null> signIn() async {
    AppState temp = state.copyWith(signInState: SignInState.SIGNING_IN);
    _setNewState(temp);
    AppState newState = await signInAction(state, widget.signIn);
    _setNewState(newState);
    if (newState.signInState == SignInState.SIGNED_IN) {
      Keys.navigatorKey.currentState
          .pushReplacementNamed(InternalStrings.mainScreenRoute);
    }
  }

  Future<Null> signOut() async {
    AppState newState = await signOutAction(state, widget.signIn);
    _setNewState(newState);
    Keys.navigatorKey.currentState
        .pushReplacementNamed(InternalStrings.splashScreenRoute);
  }

  Future<Null> signOutAndDelete() async {
    AppState newState = await signOutAndDeleteAction(state, widget.signIn);
    _setNewState(newState);
    Keys.navigatorKey.currentState
        .pushReplacementNamed(InternalStrings.splashScreenRoute);
  }

  /// Sets the [AppState] to a new state. This should rebuild widgets underneath
  /// this one in the tree.
  void _setNewState(AppState newState) {
    setState(() => state = newState);
  }
}

/// An [InheritedWidget] that handles the rebuilding of all widgets that rely
/// on the app's state.
class _Inherited extends InheritedWidget {
  /// The current [KickItState].
  final KickItState state;

  /// Creates a new [_Inherited] with the given child, state, and key.
  const _Inherited({
    @required Widget child,
    @required this.state,
    Key key,
  })  : assert(state != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_Inherited old) => true;
}
