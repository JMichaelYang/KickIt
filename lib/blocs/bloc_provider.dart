import 'dart:async';

import 'package:flutter/widgets.dart';

/// Abstract BLoC base class to be extended by any BLoC.
abstract class BlocBase<T> {
  /// The current state of the BLoC.
  @protected
  T state;

  /// A [StreamController] that streams the state of the current BLoC.
  @protected
  final StreamController<T> controller = StreamController.broadcast<T>();

  Stream<T> get stream => controller.stream;

  /// Disposes the resources for this BLoC.
  void dispose() {
    controller.close();
  }
}

/// Generic BLoC provider for any information BLoC.
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  /// The BLoC that this [BlocProvider] will provide to its children.
  final T _bloc;

  /// The child widget of this provider.
  final Widget _child;

  /// Creates a new [BlocProvider] with the given [key], [_bloc], and [_child].
  BlocProvider({
    Key key,
    @required T bloc,
    @required Widget child,
  })  : this._bloc = bloc,
        this._child = child,
        super(key: key);

  /// Gets the closest [BlocProvider] ancestor with the given type of
  /// [BlocBase] in the current context.
  static U of<U extends BlocBase>(BuildContext context) {
    final Type type = _typeof<BlocProvider<U>>();
    BlocProvider<U> provider = context.ancestorWidgetOfExactType(type);
    return provider?._bloc;
  }

  /// Returns the type of the generic parameter.
  static Type _typeof<V>() => V;

  /// Returns a new [_BlocProviderState] for the state of this widget.
  @override
  State<StatefulWidget> createState() => new _BlocProviderState<T>();
}

/// The state of a [BlocProvider], builds the child widget.
class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  /// Builds the widget's child.
  @override
  Widget build(BuildContext context) {
    return widget._child;
  }

  /// Disposes the resources associated with this state, including the
  /// [BlocBase] stored.
  @override
  void dispose() {
    widget._bloc.dispose();
    super.dispose();
  }
}
