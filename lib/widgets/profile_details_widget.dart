import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';

/// Displays the details of a [Profile] on the screen.
class ProfileDetailsWidget extends StatefulWidget {
  /// The profile to display.
  final String _uid;

  /// Set the profile to display.
  ProfileDetailsWidget(this._uid);

  /// Create the state for this widget.
  @override
  State<StatefulWidget> createState() => new _ProfileDetailsWidgetState();
}

/// Manages the state of a details widget.
class _ProfileDetailsWidgetState extends State<ProfileDetailsWidget> {
  /// The bloc that requests profile information.
  BlocProfile _bloc;

  /// Request the user information.
  @override
  void initState() {
    _bloc = BlocProvider.of<BlocProfile>(context);
    _bloc.requestProfile(widget._uid);
    super.initState();
  }

  /// Builds a scrollable list of information regarding this [Profile].
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      initialData: null,
      stream: _bloc.profileOut,
      builder: _getBody,
    );
  }

  /// Gets the body of information to be presented
  Widget _getBody(BuildContext context, AsyncSnapshot<Profile> snap) {
    /// If the given profile is null, indicate that we are loading a profile.
    if (!snap.hasData) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    Profile profile = snap.data;

    return new ListView(
      children: <Widget>[
        new Text(
          profile.name,
          style: Theme.of(context).textTheme.title,
          overflow: TextOverflow.ellipsis,
        ),
        new Text(
          profile.intro,
          style: Theme.of(context).textTheme.body1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
