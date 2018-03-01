import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickit/screens/feed_screen.dart';
import 'package:kickit/screens/profile_screen.dart';
import 'package:kickit/screens/talk_screen.dart';
import 'package:kickit/utils/values/internal_strings.dart';
import 'package:kickit/utils/values/keys.dart';
import 'package:kickit/utils/values/strings.dart';
import 'package:kickit/utils/values/values.dart';

/// Main screen that contains three screens within for displaying information.
/// Contains a:
/// - [TalkScreen]
/// - [FeedScreen]
/// - [ProfileScreen]
class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainScreenState();
  }
}

/// Manages the state of [MainScreen].
class _MainScreenState extends State<MainScreen> {
  // A PageController to manage which screen is currently shown.
  PageController _pageController;

  // The current page that is in focus.
  // - 0 => ConversationScreen
  // - 1 => FeedScreen
  // - 2 => ProfileScreen
  int _page = 1;

  /// Initializes this [MainScreen], setting the initial screen to the
  /// [FeedScreen] due to [_page] starting at 1.
  @override
  void initState() {
    super.initState();
    _pageController = new PageController(
      initialPage: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: Keys.mainScaffoldKey,
      appBar: _appBar(),
      body: _mainScreens(),
      bottomNavigationBar: _bottomBar(),
    );
  }

  /// Gets an [AppBar] that will be shown across all of the screens controlled
  /// by this [MainScreen]
  AppBar _appBar() {
    return new AppBar(
      key: Keys.mainAppBarKey,
      centerTitle: true,
      automaticallyImplyLeading: false,
      // Gets rid of back button
      title: new Text(
        Strings.title,
        style: Theme.of(context).textTheme.title,
      ),
      actions: <Widget>[
        new IconButton(
          key: Keys.mainSettingsButtonKey,
          icon: new Icon(Icons.settings),
          onPressed: () => Navigator
              .of(context)
              .pushNamed(InternalStrings.settingsScreenRoute),
        ),
      ],
    );
  }

  /// Gets a [PageView] storing the screens controlled by this [MainScreen].
  PageView _mainScreens() {
    return new PageView(
      key: Keys.mainPageViewKey,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      children: <Widget>[
        new Container(
          child: new TalkScreen(),
        ),
        new Container(
          child: new FeedScreen(),
        ),
        new Container(
          child: new ProfileScreen(),
        ),
      ],
    );
  }

  /// Gets a [BottomNavigationBar] that will be shown across all of the screens
  /// controlled by this [MainScreen]
  BottomNavigationBar _bottomBar() {
    return new BottomNavigationBar(
      key: Keys.mainBottomBarKey,
      items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.people),
          title: new Text(Strings.mainBottomBarTalk),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.list),
          title: new Text(Strings.mainBottomBarFeed),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.person),
          title: new Text(Strings.mainBottomBarProfile),
        ),
      ],
      onTap: _onNavigationTap,
      currentIndex: _page,
    );
  }

  /// Handles a tap on the bottom navigation bar.
  void _onNavigationTap(int page) {
    _pageController.animateToPage(
      page,
      duration: Values.animationShort,
      curve: Curves.ease,
    );
  }

  /// Handles a page change and updates the bottom bar.
  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  /// Dispose of the [PageController] when disposed.
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
