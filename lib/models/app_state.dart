import 'package:flutter/widgets.dart';
import 'package:kickit/models/app_state_data.dart';
import 'package:meta/meta.dart';

/// A root level widget that stores the state data for this application.
class AppState extends StatelessWidget {
  // The state data that this app has.
  final AppStateData data;

  // The widget below this one on the widget tree.
  final Widget child;

  /// Creates a new [AppState] with the given [data] and [child] widget.
  AppState({
    @required this.child,
    AppStateData data,
    Key key,
  })  : assert(child != null),
        this.data = new AppStateData(),
        super(key: key);

  /// Get's this context's state data and returns it.
  static AppStateData of(BuildContext context) {
    final _InheritedAppState appState =
        context.inheritFromWidgetOfExactType(_InheritedAppState);
    return appState.appState.data;
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedAppState(
      child: this.child,
      appState: this,
    );
  }
}

/// An [InheritedWidget] that handles the rebuilding of all widgets that rely
/// on the app's state.
class _InheritedAppState extends InheritedWidget {
  /// The current [AppState].
  final AppState appState;

  /// Creates a new [_InheritedAppState] with the given child, state, and key.
  const _InheritedAppState({
    @required Widget child,
    @required this.appState,
    Key key,
  })  : assert(appState != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedAppState old) =>
      appState.data != old.appState.data;
}
