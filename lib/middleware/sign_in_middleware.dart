import 'package:kickit/actions/sign_in_actions.dart';
import 'package:kickit/data/injectors.dart';
import 'package:kickit/data/sign_in.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/models/profile.dart';
import 'package:redux/redux.dart';

/// Creates all the [Middleware] associated with signing the user in and out.
List<Middleware<AppState>> createSignInMiddleware() {
  final ISignIn signIn = new SignInInjector().signIn;

  final Middleware<AppState> mSignIn = _createSignIn(signIn);
  final Middleware<AppState> mSignOut = _createSignOut(signIn);
  final Middleware<AppState> mSignOutAndDelete =
      _createSignOutAndDelete(signIn);

  return combineTypedMiddleware(
    [
      new MiddlewareBinding<AppState, SignInAction>(mSignIn),
      new MiddlewareBinding<AppState, SignOutAction>(mSignOut),
      new MiddlewareBinding<AppState, SignOutAndDeleteAction>(
          mSignOutAndDelete),
    ],
  );
}

/// Creates the [Middleware] associated with a sign in attempt.
Middleware<AppState> _createSignIn(ISignIn signIn) {
  return (Store<AppState> store, action, NextDispatcher next) {
    signIn.signIn().then(
      (user) {
        store.dispatch(
          new SignedInAction(
            new Profile.fromPackage(user),
          ),
        );
      },
    ).catchError((_) => store.dispatch(new FailedSignInAction()));

    next(action);
  };
}

/// Creates the [Middleware] associated with a sign out attempt.
Middleware<AppState> _createSignOut(ISignIn signIn) {
  return (Store<AppState> store, action, NextDispatcher next) {
    signIn.signOut().then(
      (_) {
        store.dispatch(new SignedOutAction());
      },
    );

    next(action);
  };
}

/// Creates the [Middleware] associated with a sign out and delete attempt.
Middleware<AppState> _createSignOutAndDelete(ISignIn signIn) {
  return (Store<AppState> store, action, NextDispatcher next) {
    signIn.signOutAndDelete(store.state.profile.uid).then(
      (_) {
        store.dispatch(new SignedOutAction());
      },
    );

    next(action);
  };
}
