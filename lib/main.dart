import 'package:flutter/material.dart';
import 'screens/choose_country_screen.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/bottom_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavBar(),
      ),
    );
  }
}
