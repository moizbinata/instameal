import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/components/customappbar.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/controllers/weeklyController.dart';
import 'package:instameal/utils/constants.dart';
import '../../components/customdrawer.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import '../details/recipe.dart';
import '../details/weektable.dart';

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
    final universalController = Get.put(UniversalController());
    final weeklyController = Get.put(WeeklyController());
    universalController.fetchUniversal();
    weeklyController.fetchWeeklyImage();
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(context),
        appBar: customAppBar(action: () {
          if (_scaffoldKey.currentState.isDrawerOpen) {
            _scaffoldKey.currentState.openEndDrawer();
          } else {
            _scaffoldKey.currentState.openDrawer();
          }
        }),
        backgroundColor: CustomTheme.bgColor2,
        body: SafeArea(
            child: RefreshIndicator(
                onRefresh: universalController.fetchUniversal,
                child: ListView(
                  children: [
                    space0(),
                    Obx(
                      () => Text(
                        "      ${universalController.plan.toString()} Weekly Plan for you",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                    //week banner
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 24,
                      child: GetBuilder<WeeklyController>(
                        init: WeeklyController(),
                        builder: (_) {
                          return (_.listofWeeklyImages.length == 0 ||
                                  _.listcurrWeekImg?.length == 0)
                              ? Center(
                                  child: Text(
                                    "Loading",
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _.listcurrWeekImg?.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        // Get.to(() => RecipeDetail());
                                        int week = _.currentRxWeek.value;
                                        await weeklyController.fetchWeekly(
                                            box.read('planid').toString(),
                                            (index == 0) ? week - 1 : week);
                                        Constants.navigatepush(
                                            context, WeekTable());
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           WeekTable()),
                                        // );
                                      },
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        width: SizeConfig.heightMultiplier * 26,
                                        margin: EdgeInsets.all(
                                            SizeConfig.heightMultiplier),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                width: SizeConfig
                                                        .heightMultiplier *
                                                    26,
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    24,
                                                imageUrl:
                                                    // "http://192.168.1.113:3000/assets/airfryer-eggplant-sticks.jpg",

                                                    _.listcurrWeekImg[index]
                                                        .imageUrl,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
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
                                              bottom:
                                                  SizeConfig.heightMultiplier,
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
                                                  (index == 0)
                                                      ? "Previous Week "
                                                      : "This Week",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right:
                                                  SizeConfig.heightMultiplier,
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
                                                  box
                                                      .read('plantype')
                                                      .toString(),
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
                        },
                      ),
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
                    GetBuilder<UniversalController>(
                      init: UniversalController(),
                      builder: (_) {
                        return (_.listofFav.length == 0)
                            ? SizedBox()
                            : Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    space0(),
                                    Text(
                                      "   Top Trending",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 35,
                                      child: ListView.builder(
                                        itemCount: _.listofFav.length,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Constants.navigatepush(
                                                context,
                                                RecipeDetail(
                                                  modelType: "collection",
                                                  recipeModel:
                                                      _.listofFav[index],
                                                ),
                                              );
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         RecipeDetail(
                                              //       modelType: "collection",
                                              //       recipeModel:
                                              //           _.listofFav[index],
                                              //     ),
                                              //   ),
                                              // );
                                            },
                                            child: recipeBox2(
                                              context,
                                              _.listofFav[index].imagesUrl,
                                              index + 1,
                                              _.listofFav[index].planName,
                                              _.listofFav[index].recipeName,
                                              CustomTheme.bgColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),

                    space0(),
                    //special occassion
                    GetBuilder<UniversalController>(
                        init: UniversalController(),
                        builder: (_) {
                          return (_.listofFestival.length == 0)
                              ? SizedBox()
                              : Container(
                                  color: CustomTheme.bgColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 0.5,
                                      ),
                                      Text(
                                        "   Special Occassion",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            .copyWith(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 35,
                                        child: ListView.builder(
                                          itemCount: _.listofFestival.length,
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Constants.navigatepush(
                                                    context,
                                                    RecipeDetail(
                                                      modelType: "collection",
                                                      recipeModel:
                                                          _.listofFestival[
                                                              index],
                                                    ));
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             RecipeDetail(
                                                //               modelType:
                                                //                   "collection",
                                                //               recipeModel:
                                                //                   _.listofFestival[
                                                //                       index],
                                                //             )));
                                              },
                                              child: recipeBox2(
                                                context,
                                                _.listofFestival[index]
                                                    .imagesUrl,
                                                index + 1,
                                                _.listofFestival[index]
                                                    .planName,
                                                _.listofFestival[index]
                                                    .recipeName,
                                                Colors.white,
                                              ),
                                              //  Container(
                                              //   margin: EdgeInsets.all(
                                              //       SizeConfig
                                              //           .heightMultiplier),
                                              //   height: SizeConfig
                                              //           .heightMultiplier *
                                              //       20,
                                              //   width: SizeConfig
                                              //           .heightMultiplier *
                                              //       20,
                                              //   child: Column(
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.start,
                                              //     children: [
                                              //       Container(
                                              //         clipBehavior:
                                              //             Clip.hardEdge,
                                              //         decoration: BoxDecoration(
                                              //           borderRadius:
                                              //               BorderRadius.only(
                                              //             topLeft:
                                              //                 Radius.circular(
                                              //                     25),
                                              //             topRight:
                                              //                 Radius.circular(
                                              //                     10),
                                              //             bottomRight:
                                              //                 Radius.circular(
                                              //                     25),
                                              //             bottomLeft:
                                              //                 Radius.circular(
                                              //                     10),
                                              //           ),
                                              //         ),
                                              //         child: CachedNetworkImage(
                                              //           height: SizeConfig
                                              //                   .heightMultiplier *
                                              //               20,
                                              //           width: SizeConfig
                                              //                   .heightMultiplier *
                                              //               20,
                                              //           imageUrl: Constants
                                              //                   .baseImageUrl +
                                              //               _
                                              //                   .listofFestival[
                                              //                       index]
                                              //                   .imagesUrl,
                                              //           fit: BoxFit.cover,
                                              //           placeholder: (context,
                                              //                   url) =>
                                              //               Center(
                                              //                   child: Center(
                                              //                       child:
                                              //                           CircularProgressIndicator())),
                                              //           errorWidget: (context,
                                              //                   url, error) =>
                                              //               Image.asset(
                                              //                   "assets/images/breakfast.png"),
                                              //         ),
                                              //       ),
                                              //       SizedBox(
                                              //         height: SizeConfig
                                              //             .heightMultiplier,
                                              //       ),
                                              //       Text(
                                              //         _.listofFestival[index]
                                              //             .planName,
                                              //         style: Theme.of(context)
                                              //             .textTheme
                                              //             .bodySmall,
                                              //       ),
                                              //       Text(
                                              //         _.listofFestival[index]
                                              //             .recipeName,
                                              //         style: Theme.of(context)
                                              //             .textTheme
                                              //             .bodyText1
                                              //             .copyWith(
                                              //               fontWeight:
                                              //                   FontWeight.bold,
                                              //               color: Colors.white,
                                              //             ),
                                              //       ),
                                              //       InkWell(
                                              //           child: customButton2(
                                              //               context,
                                              //               CustomTheme
                                              //                   .secondaryColor,
                                              //               Colors.white,
                                              //               "Add to List")),
                                              //     ],
                                              //   ),
                                              // ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),

                    space0(),
                    //colllection
                    GetBuilder<UniversalController>(
                      init: UniversalController(),
                      builder: (_) {
                        return (_.listofCollection.length == 0)
                            ? SizedBox()
                            : Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    space0(),
                                    Text(
                                      "   Top Collections",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 35,
                                      child: ListView.builder(
                                        itemCount: _.listofCollection.length,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Constants.navigatepush(
                                                  context,
                                                  RecipeDetail(
                                                    modelType: "collection",
                                                    recipeModel:
                                                        _.listofCollection[
                                                            index],
                                                  ));
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             RecipeDetail(
                                              //               modelType:
                                              //                   "collection",
                                              //               recipeModel:
                                              //                   _.listofCollection[
                                              //                       index],
                                              //             )));
                                            },
                                            child: recipeBox2(
                                              context,
                                              _.listofCollection[index]
                                                  .imagesUrl,
                                              index + 1,
                                              _.listofCollection[index]
                                                  .planName,
                                              _.listofCollection[index]
                                                  .recipeName,
                                              CustomTheme.bgColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),

                    space0(),
                    //desserts
                    GetBuilder<UniversalController>(
                        init: UniversalController(),
                        builder: (_) {
                          return (_.listofDesserts.length == 0)
                              ? SizedBox()
                              : Container(
                                  color: CustomTheme.bgColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 0.5,
                                      ),
                                      Text(
                                        "   Special Desserts",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            .copyWith(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 35,
                                        child: ListView.builder(
                                          itemCount: _.listofDesserts.length,
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Constants.navigatepush(
                                                  context,
                                                  RecipeDetail(
                                                    modelType: "collection",
                                                    recipeModel:
                                                        _.listofDesserts[index],
                                                  ),
                                                );
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         RecipeDetail(
                                                //       modelType: "collection",
                                                //       recipeModel:
                                                //           _.listofDesserts[
                                                //               index],
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                              child: recipeBox2(
                                                context,
                                                _.listofDesserts[index]
                                                    .imagesUrl,
                                                index + 1,
                                                _.listofDesserts[index]
                                                    .planName,
                                                _.listofDesserts[index]
                                                    .recipeName,
                                                Colors.white,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),

                    space0(),
                  ],
                ))));
  }
}
