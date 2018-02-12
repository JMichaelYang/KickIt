/// An object that can be stored in a [Firestore] instance.
abstract class IStorable {
  /// Converts the object into a [Map] that is storable in [Firestore].
  Map<String, dynamic> toMap();

  /// Gets a copy of the object from data fetched from [Firestore] in the form
  /// of [data].
  IStorable fromMap(Map<String, dynamic> data);
}
