import 'package:flutter/material.dart';
import 'package:matar_weather/screens/new_nav.dart';
import 'package:provider/provider.dart';
import 'screens/choose_country_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'screens/bottom_nav_bar.dart';
import 'providers/Auth.dart';
import 'providers/posts.dart';
import 'providers/engagement.dart';
import 'providers/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Posts()),
        ChangeNotifierProvider(create: (context) => Engagement()),
        ChangeNotifierProvider(create: (context) => Data()),
      ],
      child: MaterialApp(
        title: 'Matar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          BottomNavBar.routeName: (context) => const BottomNavBar(),
        },
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: BottomNavBar(),
        ),
      ),
    );
  }
}
