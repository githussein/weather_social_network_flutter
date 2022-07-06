import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  const VideoTile(
      {Key? key,
      required this.videoUrl,
      required this.snappedPage,
      required this.currentIndex})
      : super(key: key);

  final String videoUrl;
  final int snappedPage;
  final int currentIndex;

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _videoController;
  late Future _initializeVideoPlayer;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayer = _videoController.initialize();
    _videoController.setLooping(true);
    // _videoController.play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.snappedPage == widget.currentIndex
        ? _videoController.play()
        : _videoController.pause();
    if (widget.snappedPage == 0) _videoController.pause();
    return Container(
      color: Colors.black,
      child: FutureBuilder(
          future: _initializeVideoPlayer,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return VideoPlayer(_videoController);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
