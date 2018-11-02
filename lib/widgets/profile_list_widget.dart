import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_profile_list.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';
import 'package:kickit/widgets/profile_card_widget.dart';

/// A widget that displays a list of [Profile] objects.
class ProfileListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileListWidgetState();
}

class _ProfileListWidgetState extends State<ProfileListWidget> {
  BlocProfileList _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<BlocProfileList>(context);
    _bloc.requestAllProfiles();
    super.initState();
  }

  /// Builds the list of [Profile] objects to display.
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      initialData: null,
      stream: _bloc.profilesOut,
      builder: (BuildContext context, AsyncSnapshot<List<Profile>> snap) {
        if (!snap.hasData) {
          return new Center(child: CircularProgressIndicator());
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
}