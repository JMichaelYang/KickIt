import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kickit/actions/sign_in_actions.dart';
import 'package:kickit/models/app_state_data.dart';
import 'package:kickit/screens/splash_screen/splash_screen.dart';
import 'package:kickit/selectors/selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

/// Connects the [SplashScreen] to the [Store] with a distinct [ViewModel].
class SplashScreenContainer extends StatelessWidget {
  SplashScreenContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppStateData, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new SplashScreen(
          onSignIn: vm.onSignIn,
          state: vm.state,
        );
      },
    );
  }
}

class _ViewModel {
  final Function onSignIn;
  final SignInState state;

  _ViewModel({@required this.onSignIn, @required this.state});

  static _ViewModel fromStore(Store<AppStateData> store) {
    return new _ViewModel(
      onSignIn: () => store.dispatch(new SignInAction()),
      state: signInStateSelector(store.state),
    );
  }
}
