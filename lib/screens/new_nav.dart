import 'package:flutter/material.dart';
import 'package:matar_weather/screens/map_screen.dart';
import 'package:matar_weather/screens/predictions_screen.dart';
import 'package:matar_weather/screens/reels_screen.dart';

class NewNav extends StatefulWidget {
  const NewNav({Key? key}) : super(key: key);

  @override
  _NewNavState createState() => _NewNavState();
}

class _NewNavState extends State<NewNav> {
  final List _screens = [
    PredictionsScreen(),
    MapScreen(),
    ReelsScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          // unselectedItemColor: Colors.grey,
          elevation: 0.0,
          items: [
            Icons.home,
            Icons.event_note,
            Icons.dashboard,
          ]
              .asMap()
              .map((key, value) => MapEntry(
                    key,
                    BottomNavigationBarItem(
                      label: '',
                      icon: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: _currentIndex == key
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Icon(value),
                      ),
                    ),
                  ))
              .values
              .toList(),
        ),
      ),
    );
  }
}
