import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../services/ad_helper.dart';
import 'notifications_screen.dart';
import '../screens/settings.dart';
import '../providers/posts.dart';

class PredictionsScreen extends StatefulWidget {
  const PredictionsScreen({Key? key}) : super(key: key);

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  Map<String, BannerAd> ads = <String, BannerAd>{};
  var _isInit = true;
  var _isLoading = false;
  final videoController = VideoPlayerController.network(
      'https://admin.rain-app.com/storage/outlooks/62a6456abd7b7.mp4');

  @override
  void initState() {
    super.initState();

    ///VIDEO PLAYER
    videoController
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => videoController.play());
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //fetch offers and coupons
      Provider.of<Posts>(context, listen: false).getAllPosts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var posts = Provider.of<Posts>(context, listen: false).posts;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'التوقعات ومتابعة الحالات',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: const Color(0xff426981),
        actions: [
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
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen())),
              icon: const Icon(
                Icons.menu,
                size: 32,
                color: Colors.white,
              )),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        // physics: const BouncingScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          ads['myBanner$index'] = BannerAd(
            adUnitId: AdHelper.bannerAdUnitId,
            request: const AdRequest(),
            size: AdSize.largeBanner,
            listener: BannerAdListener(onAdLoaded: (_) {
              setState(() {});
            }, onAdFailedToLoad: (ad, err) {
              print('Failed to load a banner ad: ${err.message}');
              ad.dispose();
            }, onAdWillDismissScreen: (ad) {
              ad.dispose();
            }, onAdClosed: (ad) {
              debugPrint("Ad Got Closed");
            }),
          );
          ads['myBanner$index']!.load();

          return (index == 1 || (index > 2 && (index - 1) % 4 == 0))
              ? Column(
                  children: [
                    const Text('x إيقاف الإعلانات'),
                    Expanded(
                      child: Image.asset('assets/img/ad.png', fit: BoxFit.fill),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          color: const Color(0xff707070),
                          child: posts[index]
                                  .files[0]['file']
                                  .toString()
                                  .contains('.mp4')
                              ? Expanded(
                                  child: VideoPlayer(videoController),
                                )
                              : Expanded(
                                  //@TODO zoom picture on click
                                  child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://admin.rain-app.com/storage/outlooks/${posts[index].files[0]['file']}')),
                                ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                horizontal: 26)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xff426981)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      // side: BorderSide(color: Colors.red),
                                    ))),
                                onPressed: () {},
                                child: const Text('سلطنة عمان',
                                    style: TextStyle(fontSize: 20))),
                            ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                horizontal: 16)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xff426981)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFFEF9F9)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      // side: BorderSide(color: Colors.red),
                                    ))),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 32, vertical: 120),
                                            color: Colors.white,
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/img/oman.png'),
                                                            height: 50),
                                                        Text('عمان'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: const Text('اختيار موقع آخر',
                                    style: TextStyle(fontSize: 20))),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      color: const Color(0xff426981),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset('assets/icon/time.png',
                                        width: 12, color: Colors.white)),
                                const Text(
                                  '7:55 - 2022.04.27',
                                  style: TextStyle(
                                      color: Color(0xFFFEF9F9), fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Container(width: 1, color: const Color(0xFFFEF9F9)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.49,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset('assets/icon/heart.png',
                                        color: Colors.white)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset('assets/icon/comment.png',
                                        color: Colors.white)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset('assets/icon/share2.png',
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _isLoading
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        : Expanded(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SingleChildScrollView(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      if (posts[index].title.isNotEmpty)
                                        Text(posts[index].title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      Text(posts[index].details,
                                          style: const TextStyle(fontSize: 18)),
                                      Container(
                                        height: 100,
                                        child: AdWidget(
                                            ad: ads['myBanner$index']!),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                )),
                          ),
                  ],
                );
        },
      ),
    );
  }
}
