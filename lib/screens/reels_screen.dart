import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../screens/settings.dart';
import '../services/ad_helper.dart';
import 'notifications_screen.dart';
import 'send_photo_screen.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  // void _loadInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: AdHelper.interstitialAdUnitId,
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         this._interstitialAd = ad;
  //
  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {
  //           },
  //         );
  //
  //         _isInterstitialAdReady = true;
  //       },
  //       onAdFailedToLoad: (err) {
  //         print('Failed to load an interstitial ad: ${err.message}');
  //         _isInterstitialAdReady = false;
  //       },
  //     ),
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // NativeAd? nativeAd;
  // bool _isAdLoaded = false;
  // static const _kAdIndex = 4;
  // int _getDestinationItemIndex(int rawIndex) {
  //   if (rawIndex >= _kAdIndex && _isAdLoaded) {
  //     return rawIndex - 1;
  //   }
  //   return rawIndex;
  // }

  // late BannerAd _bannerAd;
  // bool _isBannerAdReady = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _bannerAd = BannerAd(
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.leaderboard,
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         print('Failed to load a banner ad: ${err.message}');
  //         _isBannerAdReady = false;
  //         ad.dispose();
  //       },
  //     ),
  //   );
  //
  //   _bannerAd.load();
  // }
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   nativeAd = NativeAd(
  //     adUnitId: 'ca-app-pub-3940256099942544/1044960115',
  //     factoryId: 'listTile',
  //     request: const AdRequest(),
  //     listener: NativeAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isAdLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         // Releases an ad resource when it fails to load
  //         ad.dispose();
  //
  //         print('Ad load failed (code=${error.code} message=${error.message})');
  //       },
  //     ),
  //   );
  //
  //   nativeAd!.load();
  // }
  //
  // @override
  // void dispose() {
  //   nativeAd!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: const Text(
          'صور ومقاطع الطقس',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xff426981),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SendPhotoScreen())),
              icon: const Icon(
                Icons.add_box_outlined,
                size: 30,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsScreen())),
              icon: const Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
              icon: const Icon(
                Icons.menu,
                size: 32,
                color: Colors.white,
              )),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 17,
        itemBuilder: (context, index) {
          // if (index == 1) {
          //   print(index);
          //   _loadInterstitialAd();
          // }
          //
          // if (index == 3) {
          //   print(index);
          // _interstitialAd?.show();
          // }
          //
          return (index + 1) % 5 == 0
              ? Center(
                  // child:
                  // _isBannerAdReady
                  //     ? AdWidget(ad: _bannerAd)
                  //     : const CircularProgressIndicator()
                  )

              // Stack(
              //   children: [
              //     AdWidget(ad: nativeAd!),
              //     Container(
              //       margin: EdgeInsets.symmetric(vertical: 100),
              //       // padding: EdgeInsets.symmetric(vertical: 60),
              //       alignment: Alignment.topCenter,
              //       color: Colors.transparent,
              //       child: const Text('إعلان'),
              //       // width: double.infinity,
              //       // height: _bannerAd.size.height.toDouble(),
              //     ),
              //   ],
              // )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://picsum.photos/id/${index + 1047}/800/1080'),
                      )),
                  child: Center(
                      child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            begin: Alignment(0, -0.5),
                            end: Alignment(0, -2),
                          ),
                        ),
                      ),
                      // if (_isBannerAdReady)
                      //   Align(
                      //     alignment: Alignment.topCenter,
                      //     child: SizedBox(
                      //       width: _bannerAd.size.width.toDouble(),
                      //       height: _bannerAd.size.height.toDouble(),
                      //       child: AdWidget(ad: _bannerAd),
                      //     ),
                      //   ),
                    ],
                  )),
                );
        },
      ),
    );
  }
}
