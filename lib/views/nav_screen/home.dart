import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/components/customappbar.dart';
import 'package:instameal/components/notifdialog.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/controllers/videocontroller.dart';
import 'package:instameal/controllers/weeklyController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/views/details/recipe.dart';
import 'package:instameal/views/details/recipeplay.dart';
import 'package:instameal/views/details/viewmore.dart';
import 'package:instameal/components/customdrawer.dart';
import 'package:instameal/controllers/searchcategcontroller.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/weektable.dart';
import 'package:instameal/views/searchcateg/searchcategrecipe.dart';

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
      }, action2: () {
        showDialog(context: context, builder: (ctx) => notifDialog(ctx));
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
                                onTapDown: ((details) => Fluttertoast.showToast(
                                    msg: "Loading, please wait",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0)),
                                onDoubleTap: () {
                                  Fluttertoast.showToast(
                                      msg: "Loading, please wait",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0);
                                },
                                onTap: () async {
                                  Fluttertoast.showToast(
                                      msg: "Loading, please wait",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0);
                                  int week = (_.currentRxWeek.value);
                                  print(week);
                                  if (week == 1) {
                                    await weeklyController.fetchWeekly(
                                        box.read('planid').toString(),
                                        (index == 0) ? 51 : 1);
                                  } else if (week == 52) {
                                    await weeklyController.fetchWeekly(
                                        box.read('planid').toString(),
                                        (index == 0) ? 50 : 51);
                                  } else {
                                    await weeklyController.fetchWeekly(
                                        box.read('planid').toString(),
                                        (index == 0) ? week - 1 : week);
                                  }

                                  Constants.navigatepush(context, WeekTable());
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: SizeConfig.heightMultiplier * 26,
                                  margin: EdgeInsets.all(
                                      SizeConfig.heightMultiplier),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            CustomTheme.grey.withOpacity(0.2),
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
                                              SizeConfig.heightMultiplier * 26,
                                          height:
                                              SizeConfig.heightMultiplier * 24,
                                          imageUrl:
                                              // "http://192.168.1.113:3000/assets/airfryer-eggplant-sticks.jpg",

                                              Constants.baseImageUrl +
                                                  _.listcurrWeekImg[index]
                                                      .imageUrl,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator())),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/breakfast.png"),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: SizeConfig.heightMultiplier,
                                        left: SizeConfig.heightMultiplier,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                              vertical:
                                                  SizeConfig.heightMultiplier *
                                                      0.5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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
                                        right: SizeConfig.heightMultiplier,
                                        top: SizeConfig.heightMultiplier,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                              vertical:
                                                  SizeConfig.heightMultiplier *
                                                      0.5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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
                  },
                ),
              ),

              ListTile(
                tileColor: CustomTheme.bgColor,
                title: Text(
                  "Explore Instameal",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                      ),
                ),
                subtitle: Text(
                  "Any day any time any recipe",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              space0(),
              //Top Trending
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
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: 6,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return (index == 5)
                                        ? InkWell(
                                            onTap: () async {
                                              final searchCategContr = Get.put(
                                                  SearchCategController());

                                              await searchCategContr
                                                  .filterSCategRecipe(17);
                                              Constants.navigatepush(
                                                context,
                                                SearchCategRecipe(
                                                  scategId: 17,
                                                  scategName: "Trending",
                                                ),
                                              );
                                            },
                                            child: arrowBox())
                                        : InkWell(
                                            onTap: () {
                                              Constants.navigatepush(
                                                context,
                                                RecipeDetail(
                                                  modelType: "collection",
                                                  recipeModel:
                                                      _.listofFav[index],
                                                ),
                                              );
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
              //Small Bites
              GetBuilder<UniversalController>(
                  init: UniversalController(),
                  builder: (_) {
                    return (_.listofFestival.length == 0)
                        ? SizedBox()
                        : Container(
                            color: CustomTheme.bgColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.5,
                                ),
                                Text(
                                  "   Small Bites",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 35,
                                  child: ListView.builder(
                                    itemCount: 6,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return (index == 5)
                                          ? InkWell(
                                              onTap: () async {
                                                final searchCategContr = Get.put(
                                                    SearchCategController());

                                                await searchCategContr
                                                    .filterSCategRecipe(9);
                                                Constants.navigatepush(
                                                  context,
                                                  SearchCategRecipe(
                                                    scategId: 9,
                                                    scategName: "Small Bites",
                                                  ),
                                                );
                                              },
                                              child: arrowBox())
                                          : InkWell(
                                              onTap: () {
                                                Constants.navigatepush(
                                                    context,
                                                    RecipeDetail(
                                                      modelType: "collection",
                                                      recipeModel:
                                                          _.listofFestival[
                                                              index],
                                                    ));
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
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                  }),

              space0(),
              //Desserts
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
                                "   Desserts",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: 6,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return (index == 5)
                                        ? InkWell(
                                            onTap: () async {
                                              final searchCategContr = Get.put(
                                                  SearchCategController());

                                              await searchCategContr
                                                  .filterSCategRecipe(3);
                                              Constants.navigatepush(
                                                context,
                                                SearchCategRecipe(
                                                  scategId: 3,
                                                  scategName: "Desserts",
                                                ),
                                              );
                                            },
                                            child: arrowBox())
                                        : InkWell(
                                            onTap: () {
                                              Constants.navigatepush(
                                                context,
                                                RecipeDetail(
                                                  modelType: "collection",
                                                  recipeModel:
                                                      _.listofCollection[index],
                                                ),
                                              );
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
              //Weekly Top Picks
              GetBuilder<UniversalController>(
                  init: UniversalController(),
                  builder: (_) {
                    return (_.listofDesserts.length == 0)
                        ? SizedBox()
                        : Container(
                            color: CustomTheme.bgColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 0.5,
                                ),
                                Text(
                                  "   Weekly Top Picks",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 35,
                                  child: ListView.builder(
                                    itemCount: 6,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return (index == 5)
                                          ? InkWell(
                                              onTap: () async {
                                                final searchCategContr = Get.put(
                                                    SearchCategController());

                                                await searchCategContr
                                                    .filterSCategRecipe(16);
                                                Constants.navigatepush(
                                                  context,
                                                  SearchCategRecipe(
                                                    scategId: 16,
                                                    scategName:
                                                        "Weekly Top Picks",
                                                  ),
                                                );
                                              },
                                              child: arrowBox())
                                          : InkWell(
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
              //Latest Videos
              GetBuilder<VideoController>(
                init: VideoController(),
                builder: (_) {
                  return (_.listofVideos.length == 0)
                      ? SizedBox()
                      : Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space0(),
                              Text(
                                "   Latest Videos",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofVideos.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        // Constants.navigatepush(
                                        //     context,
                                        //     PlayRecipe(
                                        //       vmodel: _.listofVideos[index],
                                        //     ));
                                        Constants.navigatepush(
                                            context,
                                            RecipePlayer(
                                              latVideoData:
                                                  _.listofVideos[index],
                                            ));
                                      },
                                      child: videoBox(
                                        context,
                                        _.listofVideos[index].imageUrl,
                                        index + 1,
                                        "",
                                        _.listofVideos[index].title,
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
            ],
          ),
        ),
      ),
    );
  }
}
