/// Internal strings for use within the app (not language)
class InternalStrings {
  // Routes
  static final String mainScreenRoute = "/main";

  // Keys

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

  /// Private constructor so that an [InternalStrings] cannot be instantiated
  /// from the outside.
  InternalStrings._internal();
}