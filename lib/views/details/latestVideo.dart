import 'package:flutter/material.dart';
import 'package:instameal/views/details/video_widget.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';
import '../../utils/theme.dart';

class LatestVideo extends StatelessWidget {
  LatestVideo({Key key, this.latVideoData}) : super(key: key);
  final latVideoData;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                VideoWidget(
                  videoUrl: latVideoData.videoUrl,
                ),
              ],
            ),
          ),
        ));
  }
}
