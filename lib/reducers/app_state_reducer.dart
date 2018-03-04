import 'package:kickit/models/app_state.dart';
import 'package:kickit/reducers/sign_in_reducer.dart';
import 'package:kickit/reducers/sign_in_state_reducer.dart';

/// The main state reducer made by combining the individual reducers.
AppState appReducer(AppState state, action) {
  return new AppState(
    profile: signInReducer(state.profile, action),
    signInState: signInStateReducer(state.signInState, action),
  );
}
