import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_profile.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_login.dart';

/// Displays the details of a [Profile] on the screen.
class ProfileDetailsWidget extends StatelessWidget {
  /// Builds a scrollable list of information regarding this [Profile].
  @override
  Widget build(BuildContext context) {
    BlocProfile bloc = BlocProvider.of<BlocProfile>(context);
    bloc.getProfileById(new InjectorLogin().login.getUid());
    return new StreamBuilder(
      initialData: null,
      stream: bloc.stream,
      builder: _getBody,
    );
  }

  /// Gets the body to display.
  Widget _getBody(BuildContext context, AsyncSnapshot<BlocProfileState> snap) {
    if(snap != null && snap.data != null && snap.data.profiles.length > 0) {
      return _getList(context, snap.data.profiles[0]);
    } else {
      return new Center(child: new CircularProgressIndicator());
    }
  }

  /// Gets the list that displays the given [Profile].
  Widget _getList(BuildContext context, Profile profile) {
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
