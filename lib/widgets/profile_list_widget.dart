import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_friends_list.dart';
import 'package:kickit/blocs/bloc_profile_list_base.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/profile_card_widget.dart';

/// A wrapper for a [ProfileListWidget] that shows the friends list of a user.
Widget profileListFriendsWrapper(String uid) {
  if (uid == null) {
    throw new ArgumentError("The uid provided to the friends list is null");
  }

  // Create a new bloc for this instance.
  BlocProfileListBase bloc = new BlocFriendsList(uid);

  // Return a bloc provider as a shell to hold both objects.
  return new BlocProvider(
    bloc: bloc,
    child: new ProfileListWidget(bloc),
  );
}

/// A widget that displays a list of [Profile] objects.
class ProfileListWidget extends StatelessWidget {
  /// The stream to pull profiles from.
  final BlocProfileListBase _bloc;

  ProfileListWidget(this._bloc);

  /// Builds the list of [Profile] objects to display.
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: _bloc.profilesOut,
      builder: _getBody,
    );
  }

  /// Gets the actual widget that displays the profiles on the screen.
  Widget _getBody(BuildContext context, AsyncSnapshot<List<Profile>> snap) {
    // If we are still loading data, return a loading indicator.
    if (snap == null || !snap.hasData) {
      return new Center(child: CircularProgressIndicator());
    }

    // If the snapshot from the repository is empty, tell the user.
    if (snap.data == null || snap.data.isEmpty) {
      return _noFriends(context);
    }

    // Return a list of the profiles displayed.
    return new ListView.builder(
      itemCount: snap.data.length,
      itemBuilder: (BuildContext context, int index) {
        return new ProfileCardWidget(
          profile: snap.data[index],
        );
      },
    );
  }

  /// Gets a widget that tells the user that they don't currently have anyone on
  /// their friends list.
  Widget _noFriends(BuildContext context) {
    return new Center(
      child: new Text(
        NO_FRIENDS,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
