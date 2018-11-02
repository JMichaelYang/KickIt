// Path to user collection.
const String USER_PATH = "users";

/// An [Error] thrown when a [Firestore] transaction fails.
class DatabaseError extends Error {
  /// The message associated with this error.
  final Object _message;

  /// Creates a new [DatabaseError] with the given message describing what went
  /// wrong with the transaction.
  DatabaseError({Object message}) : this._message = message;

  /// Converts this [DatabaseError] to a string to be printed.
  @override
  String toString() {
    return "Database error: "
        "${_message == null ? "no message" : _message.toString()}";
  }
}
