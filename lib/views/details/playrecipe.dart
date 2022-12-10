import 'package:auto_orientation/auto_orientation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instameal/utils/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';
import '../../utils/theme.dart';

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.videoModel});
  final videoModel;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
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
    print(Constants.baseVideoUrl + widget.videoModel.videoUrl);
    _videoPlayerController1 = VideoPlayerController.network(
        Constants.baseVideoUrl + widget.videoModel.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      routePageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondAnimation, provider) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return VideoScaffold(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: provider,
                ),
              ),
            );
          },
        );
      },

      // Try playing around with some of these other options:

      // showControls: false,

      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
    _chewieController.enterFullScreen();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: CustomTheme.bgColor,
            borderRadius: BorderRadius.circular(
              100,
            )),
        child: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            AutoOrientation.portraitAutoMode();
          },
          color: Colors.white,
        ),
      ),
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: customAppBar(action: () {
        if (_scaffoldKey.currentState.isDrawerOpen) {
          _scaffoldKey.currentState.openEndDrawer();
        } else {
          _scaffoldKey.currentState.openDrawer();
        }
      }, action2: () {
        showDialog(context: context, builder: (ctx) => notifDialog(ctx));
      }),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _chewieController.enterFullScreen();
            },
            child: Text('Fullscreen'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _chewieController.dispose();
                _videoPlayerController1.pause();
                _videoPlayerController1.seekTo(Duration(seconds: 0));
                _chewieController = ChewieController(
                  videoPlayerController: _videoPlayerController1,
                  aspectRatio: 3 / 2,
                  autoPlay: true,
                  looping: true,
                );
              });
            },
            child: Padding(
              child: Text("Video 1"),
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoScaffold extends StatefulWidget {
  const VideoScaffold({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _VideoScaffoldState();
}

class _VideoScaffoldState extends State<VideoScaffold> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    AutoOrientation.landscapeAutoMode();
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
