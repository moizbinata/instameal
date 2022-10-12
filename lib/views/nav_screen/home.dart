import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instameal/components/components.dart';

import '../../components/drawer.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController passwordController = TextEditingController();

  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
              } else {
                _scaffoldKey.currentState.openDrawer();
              }
            },
            icon: FaIcon(
                (_scaffoldKey.currentState.isDrawerOpen)
                    ? FontAwesomeIcons.cross
                    : FontAwesomeIcons.barsStaggered,
                color: CustomTheme.bgColor),
          ),
          title: Center(
            child: Image.asset(
              "assets/images/logo2.png",
              height: SizeConfig.heightMultiplier * 5,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.bell,
                color: CustomTheme.bgColor,
              ),
            ),
          ],
        ),
        backgroundColor: CustomTheme.bgColor2,
        body: SafeArea(
            child: ListView(
          children: [
            space0(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "     Dinner Plans for you",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: SizeConfig.heightMultiplier * 2,
                //     vertical: SizeConfig.heightMultiplier * 0.5,
                //   ),
                //   child: customField(passwordController, "Search",
                //       icon: Icons.search,
                //       bgcolor: CustomTheme.grey,
                //       iconColor: Colors.grey),
                // ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 24,
                  child: ListView.builder(
                    itemCount: 8,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Fluttertoast.showToast(msg: "In progress");
                          // setState(() {
                          //   selectedTab = index;
                          // });
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: SizeConfig.heightMultiplier * 26,
                          margin: EdgeInsets.all(SizeConfig.heightMultiplier),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://instamealplans.com/wp-content/uploads/2022/02/pexels-chan-walrus-958545.jpg",
                                ),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                color: CustomTheme.grey.withOpacity(0.2),
                                blurRadius: 6,
                                spreadRadius: 6,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: SizeConfig.heightMultiplier,
                                left: SizeConfig.heightMultiplier,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.heightMultiplier * 1.5,
                                      vertical:
                                          SizeConfig.heightMultiplier * 0.5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "Breakfast",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: SizeConfig.heightMultiplier,
                                top: SizeConfig.heightMultiplier,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.heightMultiplier * 1.5,
                                      vertical:
                                          SizeConfig.heightMultiplier * 0.5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "30 Mins Plan",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                space0(),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 6.5,
                  child: ListView.builder(
                    itemCount: 8,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        color: CustomTheme.bgColor2,
                        child: InkWell(
                          onTap: () {
                            // setState(() {
                            //   selectedTab = index;
                            // });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 2,
                            ),
                            padding: EdgeInsets.only(
                              left: SizeConfig.heightMultiplier * 2,
                              right: SizeConfig.heightMultiplier * 2,
                              // bottom: SizeConfig.heightMultiplier * 2,
                            ),
                            decoration: BoxDecoration(
                                color: CustomTheme.bgColor2,
                                boxShadow: [
                                  BoxShadow(
                                    color: (selectedTab == index)
                                        ? CustomTheme.shadowColor2
                                        : Colors.transparent,
                                    blurRadius: 20,
                                    offset: Offset(20, -6),
                                  ),
                                ],
                                border: Border(
                                    bottom: (selectedTab == index)
                                        ? BorderSide(
                                            color: CustomTheme.bgColor,
                                            width: 4)
                                        : BorderSide.none)),
                            child: Column(
                              children: [
                                Text(
                                  "Breakfast",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      .copyWith(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2.0,
                                          color: (selectedTab == index)
                                              ? CustomTheme.bgColor
                                              : CustomTheme.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 35,
                  child: ListView.builder(
                    itemCount: 8,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: SizeConfig.screenWidth * 0.4,
                        padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                        child: Stack(
                          children: [
                            Positioned(
                                top: SizeConfig.heightMultiplier * 8,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width: double.infinity,
                                  height: SizeConfig.heightMultiplier * 21,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 10.0,
                                        offset: Offset(-5, 5),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier,
                                horizontal: SizeConfig.heightMultiplier * 2,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: SizeConfig.heightMultiplier * 15,
                                    width: SizeConfig.heightMultiplier * 15,
                                    padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.heightMultiplier * 2,
                                      horizontal:
                                          SizeConfig.heightMultiplier * 2,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: SizeConfig.heightMultiplier,
                                      horizontal: SizeConfig.heightMultiplier,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 10.0,
                                            offset: Offset(-5, 5),
                                          ),
                                        ],
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/plate.png",
                                            ),
                                            fit: BoxFit.cover)),
                                    child: Image.asset(
                                      "assets/images/breakfast.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text("Veggie Tomatoe Mix",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  space0(),
                                  Text(
                                    "N1,900",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        .copyWith(
                                          color: CustomTheme.bgColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
