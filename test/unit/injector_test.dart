import 'package:kickit/data/injectors.dart';
import 'package:kickit/data/test_data/test_profiles.dart';
import 'package:test/test.dart';

void main() {
  test("ProfileInjector Test", () {
    ProfileInjector.configure(Status.LOCAL);
    expect(new ProfileInjector().profileLoader.runtimeType, TestProfiles);
    ProfileInjector.configure(Status.REMOTE);
    // TODO: Test that this returns a Remote Database Loader
  });
}
