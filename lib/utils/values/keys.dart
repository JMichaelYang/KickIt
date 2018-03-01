import 'package:flutter/widgets.dart';

/// Stores the keys to be used for referencing widgets in tests.
class Keys {
  // Splash Screen
  static final Key splashScaffoldKey = const Key("splash_scaffold");
  static final Key splashImageKey = const Key("splash_image");
  static final Key splashButtonKey = const Key("splash_button");

  // Main Screen
  static final Key mainScaffoldKey = const Key("main_scaffold");
  static final Key mainAppBarKey = const Key("main_appBar");
  static final Key mainSettingsButtonKey = const Key("main_settingsButton");
  static final Key mainPageViewKey = const Key("main_pageView");
  static final Key mainBottomBarKey = const Key("main_bottomBar");

  // Talk Screen
  static final Key talkScaffoldKey = const Key("talk_scaffold");

  // Feed Screen
  static final Key feedScaffoldKey = const Key("feed_scaffold");
  static final Key feedListKey = const Key("feed_list");

  // Profile Screen
  static final Key profileScaffoldKey = const Key("profile_scaffold");

  // Settings Screen
  static final Key settingsScaffoldKey = const Key("settings_scaffold");
  static final Key settingsAppBarKey = const Key("settings_appBar");
  static final Key settingsBodyKey = const Key("settings_body");
  static final Key settingsLogoutKey = const Key("settings_logout");
  static final Key settingsDeleteKey = const Key("settings_delete");
  static final Key settingsDeleteConfirmKey =
      const Key("settings_deleteConfirm");

  /// Private constructor so that a [Keys] cannot be instantiated from the
  /// outside.
  Keys._internal();
}
