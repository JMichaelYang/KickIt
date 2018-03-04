import 'package:kickit/models/profile.dart';

class SignInAction {}

class SignedInAction {
  final Profile profile;

  SignedInAction(this.profile);
}

class FailedSignInAction {}

class ConfirmSignInFailedAction {}

class SignOutAction {}

class SignOutAndDeleteAction {}

class SignedOutAction {}
