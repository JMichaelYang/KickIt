import 'dart:async';

/// An object that handles the asynchronous loading of data. The generic
/// parameter represents the type of the object that is to be loaded and stored.
abstract class ILoader<T> {
  /// Gets the stream for the data that this loader is set up to fetch. Returns
  /// the stream of data.
  Stream<T> getStream();
}

/// A type of exception that is thrown when an attempt to fetch data in a loader
/// fails.
class FetchDataException implements Exception {
  String _message;

  /// Creates a new FetchDataException with the given message. The message will
  /// be displayed in the form: "Exception when fetching data: [message]".
  FetchDataException(this._message);

  String toString() {
    return "Exception when fetching data: $_message";
  }
}
