import 'package:kickit/models/profile.dart';
import 'package:test/test.dart';

/// Tests for the [Profile] class.
void main() {
  test("Profile Default Constructor Test", () {
    // Test profile constructor with no description.
    Profile profileNoDesc = new Profile("_", "Test", "Url");
    expect(profileNoDesc.uid, "_");
    expect(profileNoDesc.name, "Test");
    expect(profileNoDesc.imageUrl, "Url");
    expect(profileNoDesc.description, "");
    // Test description setter.
    profileNoDesc.description = "Test desc";
    expect(profileNoDesc.description, "Test desc");
  });

  test("Profile Mapping Test", () {
    Profile profile = new Profile("_", "Name", "Url", description: "Desc");
    Map<String, dynamic> map = profile.toMap();
    expect(map[Profile.uidKey], "_");
    expect(map[Profile.nameKey], "Name");
    expect(map[Profile.imageUrlKey], "Url");
    expect(map[Profile.descriptionKey], "Desc");

    Profile newProfile = Profile.empty.fromMap(map);
    expect(newProfile.uid, "_");
    expect(newProfile.name, "Name");
    expect(newProfile.imageUrl, "Url");
    expect(newProfile.description, "Desc");
  });

  test("Profile Null Args", () {
    expect(() => new Profile(null, "Test", "Url"),
        throwsA(new isInstanceOf<ArgumentError>()));
    expect(() => new Profile("_", null, "Url"),
        throwsA(new isInstanceOf<ArgumentError>()));
    expect(() => new Profile("_", "Nm", "Url"),
        throwsA(new isInstanceOf<ArgumentError>()));
    expect(() => new Profile("_", "Name", null),
        throwsA(new isInstanceOf<ArgumentError>()));
  });
}
