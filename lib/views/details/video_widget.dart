import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  VideoWidget({Key key, this.videoUrl}) : super(key: key);
  final videoUrl;
  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  TargetPlatform _platform;
  VideoPlayerController _controller;
  // LatVideoController latVideoController = new LatVideoController();
  Future<void> loadVideoPlayer() async {
    // latVideoController.fetchLatVideos();
    // print("moiz" +
    //     latVideoController?.listofVideos?.first?.body?.first?.videourl?.obs
    //         .toString());
    _controller = VideoPlayerController.network(
      Constants.baseVideoUrl + widget.videoUrl,
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      setState(() {
        _platform = TargetPlatform.android;
      });
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      setState(() {
        _platform = TargetPlatform.iOS;
      });
    }
    loadVideoPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    // chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(
                _controller,
              ),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    (_controller.value.isPlaying)
                        ? _controller.pause()
                        : _controller.play();
                    setState(() {});
                  },
                  icon: FaIcon(
                    (_controller.value.isPlaying)
                        ? FontAwesomeIcons.pause
                        : FontAwesomeIcons.play,
                    color: Colors.white,
                  ),
                )),
            Positioned(
                bottom: SizeConfig.heightMultiplier,
                right: SizeConfig.heightMultiplier,
                child: IconButton(
                  onPressed: () {
                    print("pressed");
                    setState(() {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                      AutoOrientation.landscapeAutoMode();
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.squareFull,
                  ),
                ))
          ])
        : Container();
  }
}
