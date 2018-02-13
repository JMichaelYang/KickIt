/// Internal strings for use within the app (not language)
class InternalStrings {
  // Routes
  static const String splashScreenRoute = "/";
  static const String mainScreenRoute = "/main";
  static const String settingsScreenRoute = "/settings";

  // Keys

  // Splash Screen
  static const String splashScaffoldKey = "splash_scaffold";
  static const String splashImageKey = "splash_image";
  static const String splashButtonKey = "splash_button";

  // Main Screen
  static const String mainScaffoldKey = "main_scaffold";
  static const String mainAppBarKey = "main_appBar";
  static const String mainSettingsButtonKey = "main_settingsButton";
  static const String mainPageViewKey = "main_pageView";
  static const String mainBottomBarKey = "main_bottomBar";
  static const String mainBottomBarTalkKey = "main_bottomBarTalk";
  static const String mainBottomBarFeedKey = "main_bottomBarFeed";
  static const String mainBottomBarProfileKey = "main_bottomBarProfile";

  // Talk Screen
  static const String talkScaffoldKey = "talk_scaffold";

  // Feed Screen
  static const String feedScaffoldKey = "feed_scaffold";

  // Profile Screen
  static final String profileScaffoldKey = "profile_scaffold";

  // Settings Screen
  static const String settingsScaffoldKey = "settings_scaffold";
  static const String settingsAppBarKey = "settings_appBar";
  static const String settingsBodyKey = "settings_body";
  static const String settingsLogoutKey = "settings_logout";

  /// Private constructor so that an [InternalStrings] cannot be instantiated
  /// from the outside.
  InternalStrings._internal();
}