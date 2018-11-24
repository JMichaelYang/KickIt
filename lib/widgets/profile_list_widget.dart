import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_profile_list.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/util/injectors/injector_login.dart';
import 'package:kickit/util/strings.dart';
import 'package:kickit/widgets/profile_card_widget.dart';

/// A widget that displays a list of [Profile] objects.
class ProfileListWidget extends StatefulWidget {
  /// The stream to pull profiles from.
  final Stream<List<Profile>> _stream;

  /// A new list widget with the given stream of profiles.
  ProfileListWidget(this._stream);

  /// Returns the state management object for this screen.
  @override
  State<StatefulWidget> createState() => new _ProfileListWidgetState();
}

/// Manages the state of a profile list.
class _ProfileListWidgetState extends State<ProfileListWidget> {
  /// Builds the list of [Profile] objects to display.
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      initialData: null,
      stream: widget._stream,
      builder: (BuildContext context, AsyncSnapshot<List<Profile>> snap) {
        if (!snap.hasData) {
          return new Center(child: CircularProgressIndicator());
        } else if (snap.hasData && (snap.data == null || snap.data.isEmpty)) {
          return _noFriends(context);
        } else {
          return new ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (BuildContext context, int index) {
              return new ProfileCardWidget(
                profile: snap.data[index],
              );
            },
          );
        }
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
