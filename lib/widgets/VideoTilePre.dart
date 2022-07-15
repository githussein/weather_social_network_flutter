import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:cached_video_player/cached_video_player.dart';
import '../providers/data.dart';

class VideoTilePre extends StatefulWidget {
  const VideoTilePre(
      {Key? key,
      required this.videoUrl,
      required this.snappedPage,
      required this.currentIndex})
      : super(key: key);

  final String videoUrl;
  final int snappedPage;
  final int currentIndex;

  @override
  State<VideoTilePre> createState() => _VideoTilePreState();
}

class _VideoTilePreState extends State<VideoTilePre> {
  late CachedVideoPlayerController _videoController;
  late Future _initializeVideoPlayer;

  @override
  void initState() {
    super.initState();
    _videoController = CachedVideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayer = _videoController.initialize();
    _videoController.setLooping(true);
    // _videoController.setVolume(0);
    _videoController.play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget.snappedPage == widget.currentIndex
    //     ? _videoController.play()
    //     : _videoController.pause();

    return Container(
      color: Colors.black,
      child: FutureBuilder(
          future: _initializeVideoPlayer,
          builder: (context, snapshot) {
            if (Provider.of<Data>(context).activeTab == 0) {
              _videoController.play();
            } else {
              _videoController.pause();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return CachedVideoPlayer(_videoController);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
