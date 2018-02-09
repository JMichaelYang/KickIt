/// Internal strings for use within the app (not language)
class InternalStrings {
  // Routes
  static final String splashScreenRoute = "/";
  static final String mainScreenRoute = "/main";
  static final String settingsScreenRoute = "/settings";

  // Keys

  // Splash Screen
  static final String splashScaffoldKey = "splash_scaffold";
  static final String splashImageKey = "splash_image";
  static final String splashButtonKey = "splash_button";

  // Main Screen
  static final String mainScaffoldKey = "main_scaffold";
  static final String mainAppBarKey = "main_appBar";
  static final String mainSettingsButtonKey = "main_settingsButton";
  static final String mainPageViewKey = "main_pageView";
  static final String mainBottomBarKey = "main_bottomBar";
  static final String mainBottomBarTalkKey = "main_bottomBarTalk";
  static final String mainBottomBarFeedKey = "main_bottomBarFeed";
  static final String mainBottomBarProfileKey = "main_bottomBarProfile";

  // Talk Screen
  static final String talkScaffoldKey = "talk_scaffold";

  // Feed Screen
  static final String feedScaffoldKey = "feed_scaffold";

  // Profile Screen
  static final String profileScaffoldKey = "profile_scaffold";

  // Settings Screen
  static final String settingsScaffoldKey = "settings_scaffold";
  static final String settingsAppBarKey = "settings_appBar";
  static final String settingsBodyKey = "settings_body";
  static final String settingsLogoutKey = "settings_logout";

  /// Private constructor so that an [InternalStrings] cannot be instantiated
  /// from the outside.
  InternalStrings._internal();
}