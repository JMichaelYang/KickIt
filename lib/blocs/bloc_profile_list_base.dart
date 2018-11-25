import 'package:kickit/blocs/bloc_provider.dart';
import 'package:kickit/data/profile.dart';

/// An abstract base for any bloc that provides a list of profiles as its
/// output, for use in the list details widget.
abstract class BlocProfileListBase extends BlocBase {
  Stream<List<Profile>> get profilesOut;
}