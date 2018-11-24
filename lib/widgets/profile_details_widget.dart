import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';

/// A wrapper for a [ProfileDetailsWidget] that gives it a specific uid.
Widget profileDetailsWrapper(String uid) {
  return new BlocProvider(
    bloc: new BlocProfile(uid),
    child: new ProfileDetailsWidget(),
  );
}

/// Displays the details of a [Profile] on the screen.
class ProfileDetailsWidget extends StatelessWidget {
  /// Set the profile to display.
  ProfileDetailsWidget();

  /// Builds a scrollable list of information regarding this [Profile].
  @override
  Widget build(BuildContext context) {
    BlocProfile bloc = BlocProvider.of<BlocProfile>(context);

    return new StreamBuilder(
      stream: bloc.profileOut,
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
