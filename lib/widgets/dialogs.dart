import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/util/strings.dart';
import 'package:meta/meta.dart';

/// A generic error dialog.
class ErrorDialog extends AlertDialog {
  ErrorDialog({
    @required String label,
    @required String body,
    @required VoidCallback press,
    @required BuildContext context,
  }) : super(
          title: new Text(
            label,
            style: Theme.of(context).textTheme.title,
          ),
          content: new SingleChildScrollView(
            child: new Text(
              body,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                APP_OK,
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: press,
            ),
          ],
        );
}
