import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Auth.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../providers/data.dart';
import '../screens/choose_country_screen.dart';
import 'map_screen.dart';
import 'reels_screen.dart';
import 'predictions_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  static const routeName = '/bottom-nav-bar';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String _currentPage = 'Predictions';
  int _selectedIndex = 0;

  // Future<InitializationStatus> _initGoogleMobileAds() {
  //   return MobileAds.instance.initialize();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _initGoogleMobileAds();
  // }

  List<String> pageKeys = ['Predictions', 'Map', 'Reels'];

  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'Reels': GlobalKey<NavigatorState>(),
    'Map': GlobalKey<NavigatorState>(),
    'Predictions': GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    print('index: $index');
    Provider.of<Data>(context, listen: false).setReelsTab(index == 2);
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  // Future<void> printToken() async {
  //   print(
  //       '\n\n########### TOKEN: ${await Provider.of<Auth>(context).getUserToken()}\n\n');
  // }

  @override
  Widget build(BuildContext context) {
    // printToken();
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Container(
          height: 40,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: _selectedIndex == 0
                  ? const Color(0xff426981)
                  : Colors.transparent,
              shape: BoxShape.circle),
          child: const Image(image: AssetImage('assets/img/weather.png')),
        ),
        label: 'التوقعات ومتابعة الحالات',
      ),
      BottomNavigationBarItem(
        icon: Container(
          height: 40,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: _selectedIndex == 1
                  ? const Color(0xff426981)
                  : Colors.transparent,
              shape: BoxShape.circle),
          child: const Image(image: AssetImage('assets/img/sat.png')),
        ),
        label: 'خرائط الطقس',
      ),
      BottomNavigationBarItem(
        icon: Container(
          height: 40,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: _selectedIndex == 2
                  ? const Color(0xff426981)
                  : Colors.transparent,
              shape: BoxShape.circle),
          child: const Image(image: AssetImage('assets/img/camera.png')),
        ),
        label: 'صور ومقاطع الطقس',
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != 'Predictions') {
            _selectTab('Predictions', 0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator('Reels'),
            _buildOffstageNavigator('Map'),
            _buildOffstageNavigator('Predictions'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          selectedItemColor: Colors.black,
          items: items,
          currentIndex: _selectedIndex,
          onTap: (int index) => _selectTab(pageKeys[index], index),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const PredictionsScreen();

    if (tabItem == 'Map') {
      child = const MapScreen();
    } else if (tabItem == 'Reels') {
      child = const ReelsScreen();
    }

    return
        // ChooseCountryScreen()
        Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
