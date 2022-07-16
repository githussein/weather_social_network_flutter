import 'dart:io';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:matar_weather/screens/sign_in_screen.dart';
import '../providers/engagement.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/Auth.dart';
import '../services/ad_helper.dart';
import '../widgets/VideoTilePre.dart';
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
  var _isCommenting = false;
  var _isShowComment = false;
  bool _isBannerAdReady = false;
  var _isLiked = false;
  int _snappedPageIndex = 0;
  final _commentController = TextEditingController(text: '');
  RewardedAd? _rewardedAd;

  int _current = 0;
  late AdSize _adSize;
  final adHelper = AdHelper();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<Posts>(context, listen: false)
          .getAllPosts()
          .then((_) => Provider.of<Auth>(context, listen: false).getUserToken())
          .then((_) {
        setState(() => _isLoading = false);
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    var posts = Provider.of<Posts>(context, listen: false).posts;
    _adSize =
        AdSize(width: MediaQuery.of(context).size.width.toInt(), height: 60);

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        // physics: const BouncingScrollPhysics(),
        itemCount: posts.length,
        onPageChanged: (int page) => setState(() => _snappedPageIndex = page),
        itemBuilder: (context, index) {
          // _isBannerAdReady = false;
          ads['myBanner$index'] = BannerAd(
            adUnitId: AdHelper.bannerAdUnitId,
            request: const AdRequest(),
            size: _adSize,
            listener: BannerAdListener(onAdLoaded: (_) {
              setState(() {
                _isBannerAdReady = true;
              });
            }, onAdFailedToLoad: (ad, err) {
              _isBannerAdReady = false;
              print('Failed to load a banner ad: ${err.message}');
              ad.dispose();
            }, onAdWillDismissScreen: (ad) {
              ad.dispose();
            }, onAdClosed: (ad) {
              debugPrint("Ad got Closed");
            }),
          );
          ads['myBanner$index']!.load();

          late var commentObject;
          String comment = '';
          String reply = '';
          String commentDate = '';

          if (Provider.of<Auth>(context, listen: false).userToken.isNotEmpty) {
            commentObject = (posts[index].comments.firstWhereOrNull(
                  (comment) =>
                      comment['user_id'] ==
                      Provider.of<Auth>(context, listen: false).userId,
                ));
            if (commentObject != null) {
              comment = commentObject['comment'] ?? '';
              reply = commentObject['reply'] ?? '';
              commentDate = commentObject['date'] ?? '';
            }
          } else {
            commentObject = null;
          }

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
                    SizedBox(
                      height: keyboardVisible
                          ? MediaQuery.of(context).size.height * 0
                          : MediaQuery.of(context).size.height * 0.33,
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
                                        ? VideoTilePre(
                                            videoUrl:
                                                'https://admin.rain-app.com/storage/outlooks/${file['file']}',
                                            currentIndex: index,
                                            snappedPage: _snappedPageIndex,
                                          )
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
                    //middle row of buttons
                    Column(
                      children: [
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
                                        icon: Image.asset(
                                            'assets/icon/time.png',
                                            width: 12,
                                            color: Colors.white)),
                                    Text(
                                      posts[index].date,
                                      style: const TextStyle(
                                          color: Color(0xFFFEF9F9),
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: 1, color: const Color(0xFFFEF9F9)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.49,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () => setState(() {
                                              _isLiked = !_isLiked;
                                              if (!_isLiked) {
                                                Provider.of<Engagement>(context,
                                                        listen: false)
                                                    .likePost(context,
                                                        posts[index].id);
                                              }
                                            }),
                                        icon: _isLiked
                                            ? const Icon(
                                                Icons.favorite,
                                                color: Color(0xffFC0E0E),
                                                size: 32,
                                              )
                                            : Image.asset(
                                                'assets/icon/heart.png',
                                                color: Colors.white)),
                                    IconButton(
                                        onPressed: () {
                                          setState(() =>
                                              _isShowComment = !_isShowComment);
                                        },
                                        icon: Image.asset(
                                            'assets/icon/comment.png',
                                            color: Colors.white)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                            'assets/icon/share2.png',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_isBannerAdReady)
                          Container(
                            height: 60,
                            width: double.infinity,
                            color: Colors.transparent,
                            child: AdWidget(ad: ads['myBanner$index']!),
                          ),
                      ],
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
                                    if (commentObject != null)
                                      Expanded(
                                          //comment & reply
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
                                                    const Flexible(
                                                      flex: 2,
                                                      child: CircleAvatar(
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
                                                                //username
                                                                Provider.of<Auth>(
                                                                        context)
                                                                    .username,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff5A87A3),
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              Text(
                                                                //comment time
                                                                commentDate,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff707070),
                                                                  fontSize: 11,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              //user comment
                                                              comment,
                                                            ),
                                                          ),
                                                          const Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              '',
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
                                            if (reply.isNotEmpty)
                                              Container(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 40),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Flexible(
                                                        flex: 2,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
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
                                                              children: const [
                                                                Text(
                                                                  'مدير التوقعات',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff5A87A3),
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Text(
                                                                  '',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff707070),
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                              ],
                                                            ),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    reply)),
                                                            const Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                '',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff814269),
                                                                    fontSize:
                                                                        15),
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
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Focus(
                                                onFocusChange: (hasFocus) {
                                                  if (hasFocus) {
                                                    if (!Provider.of<Auth>(
                                                            context,
                                                            listen: false)
                                                        .isSignedIn) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const SignInScreen())).then(
                                                          (value) => FocusScope
                                                                  .of(context)
                                                              .requestFocus(
                                                                  FocusNode()));
                                                    }
                                                  } else {
                                                    print(
                                                        'loading rewarded ad...');
                                                    loadRewardedAd();
                                                  }
                                                },
                                                child: TextField(
                                                  controller:
                                                      _commentController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 16),
                                                    hintText: 'أرسل تعليق',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // const SizedBox(width: 4),
                                            IconButton(
                                                onPressed: () async {
                                                  setState(() =>
                                                      _isCommenting = true);
                                                  if (_commentController
                                                      .text.isNotEmpty) {
                                                    if (_rewardedAd != null) {
                                                      _rewardedAd!
                                                              .fullScreenContentCallback =
                                                          FullScreenContentCallback(
                                                              onAdShowedFullScreenContent:
                                                                  (RewardedAd
                                                                      ad) {
                                                        print(
                                                            "Ad onAdShowedFullScreenContent");
                                                      }, onAdDismissedFullScreenContent:
                                                                  (RewardedAd
                                                                      ad) {
                                                        ad.dispose();
                                                        loadRewardedAd();
                                                      }, onAdFailedToShowFullScreenContent:
                                                                  (RewardedAd
                                                                          ad,
                                                                      AdError
                                                                          error) {
                                                        ad.dispose();
                                                        loadRewardedAd();
                                                      });

                                                      _rewardedAd!
                                                          .setImmersiveMode(
                                                              true);
                                                      _rewardedAd!.show(
                                                          onUserEarnedReward:
                                                              (AdWithoutView ad,
                                                                  RewardItem
                                                                      reward) async {
                                                        try {
                                                          await Provider.of<
                                                                      Engagement>(
                                                                  context,
                                                                  listen: false)
                                                              .comment(
                                                                  context,
                                                                  posts[index]
                                                                      .id,
                                                                  _commentController
                                                                      .text);

                                                          if (comment.isEmpty) {
                                                            await Provider.of<
                                                                        Posts>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getAllPosts()
                                                                .then((_) {
                                                              setState(() =>
                                                                  _commentController
                                                                      .clear());
                                                            });
                                                          }
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  Colors.green
                                                                      .shade500,
                                                              content: const Text(
                                                                  'تم إرسال التعليق'),
                                                            ),
                                                          );
                                                        } catch (e) {
                                                          print(
                                                              'failed to comment');
                                                        }
                                                      });
                                                    }

                                                    // showDialog(
                                                    //     context: context,
                                                    //     builder:
                                                    //         (context) =>
                                                    //             AlertDialog(
                                                    //               title: const Text(
                                                    //                   "إرسال تعليق",
                                                    //                   textAlign:
                                                    //                       TextAlign
                                                    //                           .right),
                                                    //               content: Text(
                                                    //                   "لكي تتمكن من إرسال تعليق يلزم مشاهدة إعلان قصير.",
                                                    //                   textAlign:
                                                    //                       TextAlign
                                                    //                           .right),
                                                    //               actions: [
                                                    //                 TextButton(
                                                    //                   child: Text(
                                                    //                       "موافق"),
                                                    //                   onPressed:
                                                    //                       () {
                                                    //                     if (_rewardedAd !=
                                                    //                         null) {
                                                    //                       _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(onAdShowedFullScreenContent: (RewardedAd
                                                    //                           ad) {
                                                    //                         print("Ad onAdShowedFullScreenContent");
                                                    //                       }, onAdDismissedFullScreenContent: (RewardedAd
                                                    //                           ad) {
                                                    //                         ad.dispose();
                                                    //                         loadRewardedAd();
                                                    //                       }, onAdFailedToShowFullScreenContent:
                                                    //                           (RewardedAd ad, AdError error) {
                                                    //                         ad.dispose();
                                                    //                         loadRewardedAd();
                                                    //                       });
                                                    //
                                                    //                       _rewardedAd!
                                                    //                           .setImmersiveMode(true);
                                                    //                       _rewardedAd!.show(onUserEarnedReward:
                                                    //                           (AdWithoutView ad, RewardItem reward) async {
                                                    //                         try {
                                                    //                           await Provider.of<Engagement>(context, listen: false).comment(context, posts[index].id, _commentController.text);
                                                    //
                                                    //                           if (comment.isEmpty) {
                                                    //                             await Provider.of<Posts>(context, listen: false).getAllPosts().then((_) {
                                                    //                               setState(() => _commentController.clear());
                                                    //                             });
                                                    //                           }
                                                    //                           ScaffoldMessenger.of(context).showSnackBar(
                                                    //                             SnackBar(
                                                    //                               backgroundColor: Colors.green.shade500,
                                                    //                               content: const Text('تم إرسال التعليق'),
                                                    //                             ),
                                                    //                           );
                                                    //                         } catch (e) {
                                                    //                           print('failed to comment');
                                                    //                         }
                                                    //                       });
                                                    //                     }
                                                    //
                                                    //                     _rewardedAd?.dispose();
                                                    //                     setState(() =>
                                                    //                         Navigator.of(context).pop());
                                                    //                   },
                                                    //                 ),
                                                    //                 TextButton(
                                                    //                   child: Text(
                                                    //                       "إلغاء"),
                                                    //                   onPressed:
                                                    //                       () {
                                                    //                     Navigator.of(context)
                                                    //                         .pop();
                                                    //                   },
                                                    //                 ),
                                                    //               ],
                                                    //             ));
                                                  }
                                                  setState(() =>
                                                      _isCommenting = false);
                                                },
                                                icon: _isCommenting
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : const Icon(
                                                        Icons
                                                            .arrow_circle_up_outlined,
                                                        size: 36,
                                                        color: Colors.purple))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SingleChildScrollView(
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
                              ),
                  ],
                );
        },
      ),
    );
  }

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isIOS
            ? "ca-app-pub-3940256099942544/1712485313"
            : "ca-app-pub-3940256099942544/5224354917",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
        }));
  }
}
