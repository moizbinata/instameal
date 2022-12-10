import 'package:flutter/material.dart';
import 'package:instameal/components/components.dart';
import 'package:video_player/video_player.dart';

import '../../utils/constants.dart';

class Recipevideo extends StatefulWidget {
  Recipevideo({Key key, this.videoModel}) : super(key: key);
  final videoModel;

  @override
  State<Recipevideo> createState() => _RecipevideoState();
}

class _RecipevideoState extends State<Recipevideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      Constants.baseVideoUrl + widget.videoModel.videoUrl,
    );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatButton(context),
        body: VideoPlayer(_controller));
  }
}
