/// Strings for use for text within the app.
class Strings {
  static const String title = "KickIt";
  static const String ok = "OK";
  static const String cancel = "Cancel";

  // Main Screen
  static const String mainBottomBarTalk = "talk";
  static const String mainBottomBarFeed = "feed";
  static const String mainBottomBarProfile = "profile";

  // Settings Screen
  static const String settingsTitle = "Settings";
  static const String settingsLogout = "Logout";
  static const String settingsDelete = "Delete Account";
  static const String settingsConfirmDelete = "Are you sure you want to " +
      "delete your account? This cannot be undone.";

  // Feed Screen
  static const String feedNone = "No plans to display.";
  static const String feedClosed = "Plan loading error: Stream closed.";

  /// Private constructor so that a [Strings] cannot be instantiated from the
  /// outside.
  Strings._internal();
}
