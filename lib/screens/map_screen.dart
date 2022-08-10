import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';
import '../services/ad_helper.dart';
import 'settings.dart';
import 'notifications_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String mapUrl =
      'https://www.meteoblue.com/ar/weather/maps/widget/oman?windAnimation=1#coords=4.33/25.78/53.29&map=windAnimation~rainbow~auto~10%20m%20above%20gnd~none';
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<Data>(context, listen: false)
          .getMapUrl()
          .then(
              (_) => mapUrl = Provider.of<Data>(context, listen: false).mapUrl)
          .then((_) => setState(() => _isLoading = false));
    }
    _isInit = false;
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : WebView(
                  debuggingEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: mapUrl,
                ),
          if (_isBannerAdReady)
            Container(
              padding: EdgeInsets.zero,
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              width: double.infinity,
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
        ],
      ),
    );
  }
}
