import 'package:kickit/middleware/sign_in_middleware.dart';
import 'package:kickit/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAppStateMiddleware() {
  return createSignInMiddleware();
}
