import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kickit/actions/sign_in_actions.dart';
import 'package:kickit/models/app_state.dart';
import 'package:kickit/screens/settings_screen/settings_screen.dart';
import 'package:kickit/selectors/selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

/// Connects the [ProfileScreen] to the [Store] with a distinct [ViewModel].
class ProfileScreenContainer extends StatelessWidget {
  ProfileScreenContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new SettingsScreen(
          onSignOut: vm.onSignOut,
          onSignOutAndDelete: vm.onSignOutAndDelete,
        );
      },
    );
  }
}

class _ViewModel {
  final Function onSignOut;
  final Function onSignOutAndDelete;
  final SignInState state;

  _ViewModel(
      {@required this.onSignOut,
        @required this.onSignOutAndDelete,
        @required this.state});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      onSignOut: () => store.dispatch(new SignOutAction()),
      onSignOutAndDelete: () => store.dispatch(new SignOutAndDeleteAction()),
      state: signInStateSelector(store.state),
    );
  }
}
