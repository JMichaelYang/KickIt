import 'package:kickit/models/app_state.dart';
import 'package:kickit/models/profile.dart';

Profile profileSelector(AppState state) => state.profile;

SignInState signInStateSelector(AppState state) => state.signInState;
