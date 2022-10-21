import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/controllers/weeklyController.dart';

import '../../components/drawer.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController passwordController = TextEditingController();
  GetStorage box = GetStorage();
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context),
        appBar: AppBar(
          backgroundColor: CustomTheme.bgColor2,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
              } else {
                _scaffoldKey.currentState.openDrawer();
              }
            },
            icon: FaIcon(FontAwesomeIcons.barsStaggered,
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
              onPressed: () {
                WeeklyController weeklyController = new WeeklyController();
                print("weekly");
                weeklyController.fetchWeekly();
              },
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
                  "      ${box.read('plantype').toString()} Weekly Plan for you",
                  style: Theme.of(context).textTheme.bodyMedium,
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
                  child: GetBuilder<WeeklyController>(
                      init: WeeklyController(),
                      builder: (_) {
                        return (_.listofWeeklyImages.length == 0 ||
                                _.listofWeeklyImages?.first?.data?.length == 0)
                            ? Center(
                                child: Text(
                                  "Loading",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    _.listofWeeklyImages?.first?.data?.length,
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Fluttertoast.showToast(
                                          msg: "In progress");
                                    },
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      width: SizeConfig.heightMultiplier * 26,
                                      margin: EdgeInsets.all(
                                          SizeConfig.heightMultiplier),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        // image: DecorationImage(
                                        //     image: NetworkImage(
                                        //       "https://thumbs.dreamstime.com/b/healthy-food-selection-healthy-food-selection-fruits-vegetables-seeds-superfood-cereals-gray-background-121936825.jpg",
                                        //     ),
                                        //     fit: BoxFit.cover),
                                        boxShadow: [
                                          BoxShadow(
                                            color: CustomTheme.grey
                                                .withOpacity(0.2),
                                            blurRadius: 6,
                                            spreadRadius: 6,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: CachedNetworkImage(
                                              width:
                                                  SizeConfig.heightMultiplier *
                                                      26,
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      24,
                                              imageUrl: _.listofWeeklyImages
                                                  ?.first?.data[index].imageUrl,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator())),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "assets/images/breakfast.png"),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: SizeConfig.heightMultiplier,
                                            left: SizeConfig.heightMultiplier,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .heightMultiplier *
                                                      1.5,
                                                  vertical: SizeConfig
                                                          .heightMultiplier *
                                                      0.5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                "Week ${index + 1}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: SizeConfig.heightMultiplier,
                                            top: SizeConfig.heightMultiplier,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .heightMultiplier *
                                                      1.5,
                                                  vertical: SizeConfig
                                                          .heightMultiplier *
                                                      0.5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                box.read('plantype').toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                      }),
                ),

                ListTile(
                  tileColor: CustomTheme.bgColor,
                  title: Text(
                    "Explore new plans",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  subtitle: Text(
                    "Explore new subscription plans for you",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                space0(),
                //top trending
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space0(),
                      Text(
                        "   Top Trending",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 35,
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
                                margin:
                                    EdgeInsets.all(SizeConfig.heightMultiplier),
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.heightMultiplier * 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Positioned(
                                            child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Image.network(
                                            "https://instamealplans.com/wp-content/uploads/2022/02/pexels-alleksana-4051762-scaled.jpg",
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    20,
                                            width: SizeConfig.heightMultiplier *
                                                20,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                                vertical: SizeConfig
                                                        .heightMultiplier *
                                                    1.5),
                                            decoration: BoxDecoration(
                                                color: CustomTheme.bgColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                )),
                                            child: Text(
                                              "${index + 1}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Smoothies",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      "Home Style Chicken",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: CustomTheme.bgColor,
                                          ),
                                    ),
                                    InkWell(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.heightMultiplier),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.heightMultiplier *
                                                      0.5,
                                              horizontal:
                                                  SizeConfig.heightMultiplier),
                                          decoration: BoxDecoration(
                                              color: CustomTheme.red,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            "Add to List",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                .copyWith(color: Colors.white),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                space0(),
                //special occassion
                Container(
                  color: CustomTheme.bgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 0.5,
                      ),
                      Text(
                        "   Special Occassions",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 35,
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
                                margin:
                                    EdgeInsets.all(SizeConfig.heightMultiplier),
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.heightMultiplier * 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Image.network(
                                        "https://instamealplans.com/wp-content/uploads/2022/02/pexels-dzenina-lukac-1583884.jpg",
                                        height:
                                            SizeConfig.heightMultiplier * 20,
                                        width: SizeConfig.heightMultiplier * 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Smoothies",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      "Home Style Chicken",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    ),
                                    InkWell(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.heightMultiplier),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.heightMultiplier *
                                                      0.5,
                                              horizontal:
                                                  SizeConfig.heightMultiplier),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            "Add to List",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                space0(),
                //colllection
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space0(),
                      Text(
                        "   Collections",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 35,
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
                                margin:
                                    EdgeInsets.all(SizeConfig.heightMultiplier),
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.heightMultiplier * 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Positioned(
                                            child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Image.network(
                                            "https://instamealplans.com/wp-content/uploads/2022/02/pexels-alleksana-4051762-scaled.jpg",
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    20,
                                            width: SizeConfig.heightMultiplier *
                                                20,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                                vertical: SizeConfig
                                                        .heightMultiplier *
                                                    1.5),
                                            decoration: BoxDecoration(
                                                color: CustomTheme.bgColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                )),
                                            child: Text(
                                              "${index + 1}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Smoothies",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      "Home Style Chicken",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: CustomTheme.bgColor,
                                          ),
                                    ),
                                    InkWell(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.heightMultiplier),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.heightMultiplier *
                                                      0.5,
                                              horizontal:
                                                  SizeConfig.heightMultiplier),
                                          decoration: BoxDecoration(
                                              color: CustomTheme.red,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            "Add to List",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                .copyWith(color: Colors.white),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                space0(),
                //desserts
                Container(
                  color: CustomTheme.bgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 0.5,
                      ),
                      Text(
                        "   Desserts",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 35,
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
                                margin:
                                    EdgeInsets.all(SizeConfig.heightMultiplier),
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.heightMultiplier * 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Image.network(
                                        "https://instamealplans.com/wp-content/uploads/2022/02/pexels-dzenina-lukac-1583884.jpg",
                                        height:
                                            SizeConfig.heightMultiplier * 20,
                                        width: SizeConfig.heightMultiplier * 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Smoothies",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      "Home Style Chicken",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    ),
                                    InkWell(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.heightMultiplier),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.heightMultiplier *
                                                      0.5,
                                              horizontal:
                                                  SizeConfig.heightMultiplier),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            "Add to List",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                space0(),
              ],
            ),
          ],
        )));
  }
}
