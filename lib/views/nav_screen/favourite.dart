import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';
import '../../controllers/universalController.dart';
import '../../controllers/weeklyController.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import '../details/recipe.dart';

class Favourite extends StatelessWidget {
  Favourite({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GetStorage box = GetStorage();
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
        body: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "   Favorite meals",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: CustomTheme.bgColor),
              ),
              TextButton(
                onPressed: () {
                  final WeeklyController weeklyController =
                      Get.put(WeeklyController());
                  weeklyController.getCartRecipe();
                },
                child: Text(
                  "Refresh",
                  style: Theme.of(context).textTheme.bodySmall.copyWith(
                        color: CustomTheme.bgColor,
                      ),
                ),
              )
            ],
          ),
          space0(),
          DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Container(
                  height: SizeConfig.heightMultiplier * 5,
                  width: SizeConfig.screenWidth,
                  child: Center(
                    child: TabBar(
                        isScrollable: true,
                        indicatorColor: CustomTheme.bgColor,
                        tabs: [
                          Text("Weekly Favorites",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Other Favorites",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Category's Favorites",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("All Recipe Favorites",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                  ),
                ),
                space0(),
                Container(
                  height: SizeConfig.screenHeight,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      buildFavListWeekly(),
                      buildFavListOther(),
                      buildScategRecipeListOther(),
                      buildAllRecipeListOther(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}

Widget buildFavListWeekly() {
  return SizedBox(
    height: SizeConfig.screenHeight,
    child: GetX<WeeklyController>(
        init: WeeklyController(),
        builder: (_) {
          return (_.listCartRecipe1.length == 0)
              ? Center(
                  child: Image.asset(
                  "assets/images/norecord.png",
                  width: SizeConfig.screenWidth * 0.7,
                ))
              : ListView.builder(
                  itemCount: _.listCartRecipe1.length + 1,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return (index == _.listCartRecipe1.length)
                        ? SizedBox(
                            height: SizeConfig.heightMultiplier * 40,
                          )
                        : InkWell(
                            onTap: () {
                              Constants.navigatepush(
                                  context,
                                  RecipeDetail(
                                    modelType: "breakfast",
                                    recipeModel: _.listCartRecipe1[index],
                                  ));
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              margin:
                                  EdgeInsets.all(SizeConfig.heightMultiplier),
                              decoration: BoxDecoration(
                                color: CustomTheme.bgColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomTheme.grey.withOpacity(0.5),
                                    blurRadius: 6,
                                    spreadRadius: 6,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    20,
                                            width: SizeConfig.heightMultiplier *
                                                20,
                                            imageUrl: Constants.baseImageUrl +
                                                _.listCartRecipe1[index]
                                                    .imagesUrl,
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
                                          Positioned(
                                              child: CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                            child: Text((index + 1).toString()),
                                          ))
                                        ],
                                      )),
                                  SizedBox(
                                    width: SizeConfig.heightMultiplier,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: SizeConfig.heightMultiplier * 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _.listCartRecipe1[index].planName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            _.listCartRecipe1[index].recipeName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          // InkWell(
                                          //     child: customButton2(
                                          //         context,
                                          //         Colors.white,
                                          //         Colors.white,
                                          //         "Add to List")),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                );
        }),
  );
}

Widget buildFavListOther() {
  return SizedBox(
    height: SizeConfig.screenHeight,
    child: GetX<WeeklyController>(
        init: WeeklyController(),
        builder: (_) {
          return (_.listCartRecipe2.length == 0)
              ? Center(
                  child: Image.asset(
                    "assets/images/norecord.png",
                    width: SizeConfig.screenWidth * 0.7,
                  ),
                )
              : ListView.builder(
                  itemCount: _.listCartRecipe2.length + 1,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return (index == _.listCartRecipe2.length)
                        ? SizedBox(
                            height: SizeConfig.heightMultiplier * 40,
                          )
                        : InkWell(
                            onTap: () {
                              Constants.navigatepush(
                                  context,
                                  RecipeDetail(
                                    modelType: "collection",
                                    recipeModel: _.listCartRecipe2[index],
                                  ));
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              margin:
                                  EdgeInsets.all(SizeConfig.heightMultiplier),
                              decoration: BoxDecoration(
                                color: CustomTheme.bgColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomTheme.grey.withOpacity(0.5),
                                    blurRadius: 6,
                                    spreadRadius: 6,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    20,
                                            width: SizeConfig.heightMultiplier *
                                                20,
                                            imageUrl: Constants.baseImageUrl +
                                                _.listCartRecipe2[index]
                                                    .imagesUrl,
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
                                          Positioned(
                                              child: CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                            child: Text((index + 1).toString()),
                                          ))
                                        ],
                                      )),
                                  SizedBox(
                                    width: SizeConfig.heightMultiplier,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: SizeConfig.heightMultiplier * 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _.listCartRecipe2[index].planName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            _.listCartRecipe2[index].recipeName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          // InkWell(
                                          //     child: customButton2(
                                          //         context,
                                          //         Colors.white,
                                          //         Colors.white,
                                          //         "Add to List")),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                );
        }),
  );
}

Widget buildAllRecipeListOther() {
  return SizedBox(
    height: SizeConfig.screenHeight,
    child: GetX<WeeklyController>(
        init: WeeklyController(),
        builder: (_) {
          return (_.listCartRecipe4.length == 0)
              ? Center(
                  child: Image.asset(
                  "assets/images/norecord.png",
                  width: SizeConfig.screenWidth * 0.7,
                ))
              : ListView.builder(
                  itemCount: _.listCartRecipe4.length + 1,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return (index == _.listCartRecipe4.length)
                        ? SizedBox(
                            height: SizeConfig.heightMultiplier * 40,
                          )
                        : InkWell(
                            onTap: () {
                              Constants.navigatepush(
                                  context,
                                  RecipeDetail(
                                    modelType: "scateg",
                                    recipeModel: _.listCartRecipe4[index],
                                  ));
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              margin:
                                  EdgeInsets.all(SizeConfig.heightMultiplier),
                              decoration: BoxDecoration(
                                color: CustomTheme.bgColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomTheme.grey.withOpacity(0.5),
                                    blurRadius: 6,
                                    spreadRadius: 6,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    20,
                                            width: SizeConfig.heightMultiplier *
                                                20,
                                            imageUrl: Constants.baseImageUrl +
                                                _.listCartRecipe4[index]
                                                    .imagesUrl,
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
                                          Positioned(
                                              child: CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                            child: Text((index + 1).toString()),
                                          ))
                                        ],
                                      )),
                                  SizedBox(
                                    width: SizeConfig.heightMultiplier,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: SizeConfig.heightMultiplier * 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _.listCartRecipe4[index].planName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            _.listCartRecipe4[index].recipeName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          // InkWell(
                                          //     child: customButton2(
                                          //         context,
                                          //         Colors.white,
                                          //         Colors.white,
                                          //         "Add to List")),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                );
        }),
  );
}

Widget buildScategRecipeListOther() {
  return SizedBox(
    height: SizeConfig.screenHeight,
    child: GetX<WeeklyController>(
        init: WeeklyController(),
        builder: (_) {
          return (_.listCartRecipe3.length == 0)
              ? Center(
                  child: Image.asset(
                  "assets/images/norecord.png",
                  width: SizeConfig.screenWidth * 0.7,
                ))
              : ListView.builder(
                  itemCount: _.listCartRecipe3.length + 1,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return (index == _.listCartRecipe3.length)
                        ? SizedBox(
                            height: SizeConfig.heightMultiplier * 40,
                          )
                        : InkWell(
                            onTap: () {
                              Constants.navigatepush(
                                  context,
                                  RecipeDetail(
                                    modelType: "universal",
                                    recipeModel: _.listCartRecipe3[index],
                                  ));
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              margin:
                                  EdgeInsets.all(SizeConfig.heightMultiplier),
                              decoration: BoxDecoration(
                                color: CustomTheme.bgColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomTheme.grey.withOpacity(0.5),
                                    blurRadius: 6,
                                    spreadRadius: 6,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    20,
                                            width: SizeConfig.heightMultiplier *
                                                20,
                                            imageUrl: Constants.baseImageUrl +
                                                _.listCartRecipe3[index]
                                                    .imagesUrl,
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
                                          Positioned(
                                              child: CircleAvatar(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                            child: Text((index + 1).toString()),
                                          ))
                                        ],
                                      )),
                                  SizedBox(
                                    width: SizeConfig.heightMultiplier,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: SizeConfig.heightMultiplier * 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _.listCartRecipe3[index].planName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            _.listCartRecipe3[index].recipeName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          // InkWell(
                                          //     child: customButton2(
                                          //         context,
                                          //         Colors.white,
                                          //         Colors.white,
                                          //         "Add to List")),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                );
        }),
  );
}
