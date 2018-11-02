import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/blocs/bloc_user.dart';
import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/widgets/profile_card_widget.dart';
/*
/// A widget that displays a list of [Profile] objects.
class ProfileListWidget extends StatelessWidget {
  /// Builds the list of [Profile] objects to display.
  @override
  Widget build(BuildContext context) {
    BlocUser bloc = BlocProvider.of<BlocUser>(context);
    bloc.getAllProfiles();

    return new StreamBuilder(
      stream: bloc.stream,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<BlocProfileState> snap) {
        if (snap == null || snap.data == null) {
          return new Center(child: CircularProgressIndicator());
        } else {
          return new ListView.builder(
            itemCount: snap.data.profiles.length,
            itemBuilder: (BuildContext context, int index) {
              return new ProfileCardWidget(
                profile: snap.data.profiles[index],
              );
            },
          );
        }
      },
    );
  }
}
*/