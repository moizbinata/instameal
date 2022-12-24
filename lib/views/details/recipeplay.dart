import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:math' as math;

import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';

class RecipePlayer extends StatefulWidget {
  RecipePlayer({Key key, this.latVideoData}) : super(key: key);
  final latVideoData;
  @override
  State<RecipePlayer> createState() => _RecipePlayerState();
}

class _RecipePlayerState extends State<RecipePlayer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  int directionCount = 0;
  int ingredCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.latVideoData.videoUrl,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          showLiveFullscreenButton: false),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  // bool rotateBool = false;
  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    directionCount = 0;
    ingredCount = 0;

    return MyWidget(
      controlller: _controller,
      title: widget.latVideoData.title,
      videoUrl: widget.latVideoData.videoUrl,
    );
  }
}

// class PortraitVideo extends StatelessWidget {
//   PortraitVideo({Key key, this.controller}) : super(key: key);
//   final controller;
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: floatButton(context),
//       key: _scaffoldKey,
//       drawer: drawer(context),
//       appBar: customAppBar(action: () {
//         if (_scaffoldKey.currentState.isDrawerOpen) {
//           _scaffoldKey.currentState.openEndDrawer();
//         } else {
//           _scaffoldKey.currentState.openDrawer();
//         }
//       }, action2: () {
//         showDialog(context: context, builder: (ctx) => notifDialog(ctx));
//       }),
//       backgroundColor: CustomTheme.bgColor2,
//       body: SizedBox(
//         // height: double.infinity,
//         // width: double.infinity,
//         child: YoutubePlayer(
//           controller: controller,
//           showVideoProgressIndicator: true,
//           width: double.infinity,
//           actionsPadding: EdgeInsets.zero,
//           aspectRatio: 16 / 9,
//           onReady: () => debugPrint('ready'),
//           // bottomActions: [
//           //   FullScreenButton(),
//           // ],
//         ),
//       ),
//     );
//   }
// }

class MyWidget extends StatelessWidget {
  MyWidget({Key key, this.title, this.controlller, this.videoUrl})
      : super(key: key);
  final title;
  final videoUrl;
  final controlller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatButton(context, color: Color(0xffff0000)),
      appBar: AppBar(
        backgroundColor: Color(0xffff0000),
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                launchUrl(
                    Uri.parse("https://www.youtube.com/watch?v=$videoUrl"));
              },
              icon: FaIcon(FontAwesomeIcons.youtube))
        ],
      ),
      body: youtubeHierarchy(),
    );
  }

  youtubeHierarchy() {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fill,
          child: YoutubePlayer(
            controller: controlller,
            bottomActions: [],
          ),
        ),
      ),
    );
  }

  // Future<bool> _willPopCallback() async {
  //   // await showDialog or Show add banners or whatever
  //   // then
  //   return Future.value(true);
  // }
}
