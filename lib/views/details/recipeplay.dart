import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
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

    return Scaffold(
      floatingActionButton: floatButton(context),
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
      backgroundColor: CustomTheme.bgColor2,
      body: Container(
          height: SizeConfig.screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () => debugPrint('ready'),
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                      colors: const ProgressBarColors(
                          playedColor: CustomTheme.bgColor,
                          handleColor: CustomTheme.bgColor2),
                    ),
                    const PlaybackSpeedButton()
                  ],
                ),
                space0(),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.youtube),
                  title: Text(
                    widget.latVideoData.title,
                    style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          color: CustomTheme.bgColor,
                        ),
                  ),
                ),
                space0(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier * 2),
                  child: Column(
                    children: [
                      Text(
                        "Ingredients: ",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: SizeConfig.screenHeight,
                            minHeight: 56.0),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.latVideoData.directions.length,
                          itemBuilder: (context, index) {
                            widget.latVideoData.directions[index]
                                    .toString()
                                    .contains(":")
                                ? directionCount = directionCount
                                : directionCount++;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      (directionCount < 10)
                                          ? "0" +
                                              (directionCount).toString() +
                                              ":  "
                                          : "" +
                                              (directionCount).toString() +
                                              ":  ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          .copyWith(
                                              color: widget.latVideoData
                                                      .directions[index]
                                                      .toString()
                                                      .contains(":")
                                                  ? CustomTheme.bgColor2
                                                  : CustomTheme.bgColor)),
                                ),
                                Expanded(
                                  flex: 12,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: widget
                                                .latVideoData.directions[index]
                                                .toString()
                                                .contains(":")
                                            ? SizeConfig.heightMultiplier * 2
                                            : 0),
                                    child: Text(
                                        widget.latVideoData.directions[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .copyWith(
                                                fontWeight: widget.latVideoData
                                                        .directions[index]
                                                        .toString()
                                                        .contains(":")
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      space0(),
                      Text(
                        "Directions: ",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      space0(),
                      //directions
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 300, minHeight: 56.0),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.latVideoData.ingredients.length,
                          itemBuilder: (context, index) {
                            widget.latVideoData.ingredients[index]
                                    .toString()
                                    .contains(":")
                                ? ingredCount = ingredCount
                                : ingredCount++;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      (ingredCount < 10)
                                          ? "0" +
                                              (ingredCount).toString() +
                                              ":  "
                                          : "" +
                                              (ingredCount).toString() +
                                              ":  ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          .copyWith(
                                              color: widget.latVideoData
                                                      .ingredients[index]
                                                      .toString()
                                                      .contains(":")
                                                  ? CustomTheme.bgColor2
                                                  : CustomTheme.bgColor)),
                                ),
                                Expanded(
                                  flex: 12,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: widget
                                                .latVideoData.ingredients[index]
                                                .toString()
                                                .contains(":")
                                            ? SizeConfig.heightMultiplier * 2
                                            : 0),
                                    child: Text(
                                        widget.latVideoData.ingredients[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .copyWith(
                                                fontWeight: widget.latVideoData
                                                        .ingredients[index]
                                                        .toString()
                                                        .contains(":")
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      space2(),
                    ],
                  ),
                ),
                space0(),
              ],
            ),
          )),
    );
  }
}
