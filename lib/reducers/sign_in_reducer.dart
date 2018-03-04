import 'package:kickit/actions/sign_in_actions.dart';
import 'package:kickit/models/profile.dart';
import 'package:redux/redux.dart';

final signInReducer = combineTypedReducers<Profile>(
  [
    new ReducerBinding<Profile, SignInAction>(_signInReducer),
    new ReducerBinding<Profile, SignedInAction>(_signedInReducer),
    new ReducerBinding<Profile, FailedSignInAction>(_signInReducer),
    new ReducerBinding<Profile, ConfirmSignInFailedAction>(_signInReducer),
    new ReducerBinding<Profile, SignedOutAction>(_signInReducer),
  ],
);

Profile _signInReducer(Profile profile, action) {
  return null;
}

Profile _signedInReducer(Profile profile, action) {
  return action.profile;
}
