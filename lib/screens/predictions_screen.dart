import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  var _isShowComment = false;
  var _isLiked = false;
  final videoController = VideoPlayerController.network(
      'https://admin.rain-app.com/storage/outlooks/62a6456abd7b7.mp4');

  int _current = 0;
  late AdSize _adSize;

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
    _adSize =
        AdSize(width: MediaQuery.of(context).size.width.toInt(), height: 60);

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
        scrollDirection: Axis.horizontal,
        // physics: const BouncingScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          ads['myBanner$index'] = BannerAd(
            adUnitId: AdHelper.bannerAdUnitId,
            request: const AdRequest(),
            size: _adSize,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.33,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                            items: posts[index].files.map((file) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.33,
                                    width: double.infinity,
                                    color: const Color(0xff707070),
                                    child: file['file']
                                            .toString()
                                            .contains('.mp4')
                                        ? VideoPlayer(videoController)
                                        : CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                'https://admin.rain-app.com/storage/outlooks/${file['file']}'),
                                  );
                                },
                              );
                            }).toList(),
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
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 32,
                                                      vertical: 120),
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
                                                  const SizedBox(height: 32),
                                                  SizedBox(
                                                    width: 150,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            padding: MaterialStateProperty.all<EdgeInsets>(
                                                                const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        26)),
                                                            foregroundColor: MaterialStateProperty.all<Color>(
                                                                Colors.white),
                                                            backgroundColor:
                                                                MaterialStateProperty.all<Color>(
                                                                    const Color(
                                                                        0xff814269)),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              // side: BorderSide(color: Colors.red),
                                                            ))),
                                                        onPressed: () =>
                                                            Navigator.of(context)
                                                                .pop(),
                                                        child: const Text('ابدأ',
                                                            style: TextStyle(fontSize: 22))),
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
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: posts[index].files.map(
                                (image) {
                                  int myIndex =
                                      posts[index].files.indexOf(image);
                                  return Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == myIndex
                                            ? const Color(0xff2AB1FF)
                                            : Colors.grey),
                                  );
                                },
                              ).toList(), // this was the part the I had to add
                            ),
                          ),
                        ],
                      ),
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
                                    onPressed: () =>
                                        setState(() => _isLiked = !_isLiked),
                                    icon: _isLiked
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Color(0xffFC0E0E),
                                            size: 32,
                                          )
                                        : Image.asset('assets/icon/heart.png',
                                            color: Colors.white)),
                                IconButton(
                                    onPressed: () {
                                      setState(() =>
                                          _isShowComment = !_isShowComment);
                                    },
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
                        : _isShowComment
                            ? Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: SizedBox(
                                        height: 30,
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_back),
                                          onPressed: () => setState(() =>
                                              _isShowComment = !_isShowComment),
                                        ),
                                      ),
                                    ),
                                    const Divider(thickness: 1),
                                    // Wrap(
                                    //   children: <Widget>[
                                    //     Container(
                                    //       padding:
                                    //           const EdgeInsets.only(left: 16),
                                    //       height:
                                    //           MediaQuery.of(context).size.height *
                                    //               0.18,
                                    //       child: Row(
                                    //         children: <Widget>[
                                    //           const Expanded(
                                    //             flex: 2,
                                    //             child: Align(
                                    //               alignment: Alignment.topCenter,
                                    //               child: CircleAvatar(
                                    //                 backgroundImage: AssetImage(
                                    //                     'assets/img/profile.png'),
                                    //                 radius: 24,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           Expanded(
                                    //             flex: 8,
                                    //             child: Column(
                                    //               children: <Widget>[
                                    //                 Expanded(
                                    //                   flex: 1,
                                    //                   child: Row(
                                    //                     children: <Widget>[
                                    //                       Expanded(
                                    //                         flex: 6,
                                    //                         child: Align(
                                    //                           alignment: Alignment
                                    //                               .centerRight,
                                    //                           child: Text(
                                    //                             'أبو خالد',
                                    //                             style: TextStyle(
                                    //                                 color: Color(
                                    //                                     0xff5A87A3),
                                    //                                 fontSize: 15),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       Expanded(
                                    //                         flex: 4,
                                    //                         child: Align(
                                    //                           alignment: Alignment
                                    //                               .centerLeft,
                                    //                           child: Text(
                                    //                             'منذ 11 دقيقة',
                                    //                             style: TextStyle(
                                    //                                 color: Color(
                                    //                                     0xff707070),
                                    //                                 fontSize: 12),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //                 const Expanded(
                                    //                   flex: 4,
                                    //                   child: Text(
                                    //                     'السلام عليكم ورحمة الله وبركاته ..ما شاء لله كيف توقعات للغد؟؟ هل بتشمل الامطار عمان',
                                    //                     maxLines: 3,
                                    //                     style: TextStyle(
                                    //                         color: Colors.black,
                                    //                         fontSize: 16),
                                    //                   ),
                                    //                 ),
                                    //                 const Expanded(
                                    //                   flex: 1,
                                    //                   child: Align(
                                    //                     alignment:
                                    //                         Alignment.centerLeft,
                                    //                     child: Text(
                                    //                       'تعليق',
                                    //                       style: TextStyle(
                                    //                           color: Color(
                                    //                               0xff814269),
                                    //                           fontSize: 15),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),

                                    Expanded(
                                        child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: const CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/img/profile.png'),
                                                      radius: 24,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Flexible(
                                                    flex: 8,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'أبو خالد',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff5A87A3),
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              'منذ 22 دقيقة',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff707070),
                                                                  fontSize: 11),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                            'السلام عليكم ورحمة الله وبركاته ..ما شاء لله كيف توقعات للغد؟؟ هل بتشمل الامطار عمان'),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'تعليق',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff814269),
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 40),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: const CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/img/oman.png'),
                                                      radius: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Flexible(
                                                    flex: 8,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'مدير التوقعات',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff5A87A3),
                                                                  fontSize: 14),
                                                            ),
                                                            Text(
                                                              'منذ 11 دقيقة',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff707070),
                                                                  fontSize: 11),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                            'نعم بأذن الله ... هناك توقعات بأمطار غزيرة على عمان خلال اليوم والأيام القادمة مع توقعات بأمطار جدا غزيرة على مسقط وصحار والبريمي مع جريان للأودية بقوة.'),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'تعليق',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff814269),
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                    // Row(
                                    //   children: [
                                    //     Expanded(child: TextField()),
                                    //     IconButton(
                                    //         onPressed: () {},
                                    //         icon: Icon(Icons.send))
                                    //   ],
                                    // ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    // Container(
                                    //   height: 50,
                                    //   width: double.infinity,
                                    //   color: Colors.transparent,
                                    //   child:
                                    //       AdWidget(ad: ads['myBanner$index']!),
                                    // ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SingleChildScrollView(
                                          // physics: const NeverScrollableScrollPhysics(),
                                          child: Column(
                                            children: [
                                              if (posts[index].title.isNotEmpty)
                                                Text(posts[index].title,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              Text(posts[index].details,
                                                  style: const TextStyle(
                                                      fontSize: 18)),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                  ],
                );
        },
      ),
    );
  }
}
