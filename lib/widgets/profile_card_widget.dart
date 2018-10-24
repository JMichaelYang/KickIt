import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/data/profile.dart';

/// Displays a card with [Profile] information.
class ProfileCardWidget extends StatelessWidget {
  /// The [Profile] to display.
  final Profile _profile;

  /// Creates a new [ProfileCardWidget] with the given [Profile].
  ProfileCardWidget({
    Key key,
    @required Profile profile,
  })  : this._profile = profile,
        super(key: key);

  /// Builds a card that displays this [Profile].
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        this._profile.name,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
