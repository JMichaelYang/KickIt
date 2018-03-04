import 'package:kickit/actions/sign_in_actions.dart';
import 'package:kickit/models/app_state.dart';
import 'package:redux/redux.dart';

final signInStateReducer = combineTypedReducers<SignInState>(
  [
    new ReducerBinding<SignInState, SignInAction>(_signingInReducer),
    new ReducerBinding<SignInState, SignedInAction>(_signedInReducer),
    new ReducerBinding<SignInState, FailedSignInAction>(_failedReducer),
    new ReducerBinding<SignInState, ConfirmSignInFailedAction>(
        _notSignedInReducer),
    new ReducerBinding<SignInState, SignedOutAction>(_notSignedInReducer),
  ],
);

SignInState _notSignedInReducer(SignInState signInState, action) {
  return SignInState.NOT_SIGNED_IN;
}

SignInState _signingInReducer(SignInState signInState, action) {
  return SignInState.SIGNING_IN;
}

SignInState _failedReducer(SignInState signInState, action) {
  return SignInState.FAILED;
}

SignInState _signedInReducer(SignInState signInState, action) {
  return SignInState.SIGNED_IN;
}
