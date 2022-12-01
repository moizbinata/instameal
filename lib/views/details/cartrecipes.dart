import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/controllers/weeklyController.dart';

import '../../components/components.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import '../details/recipe.dart';

class CartRecipes extends StatelessWidget {
  CartRecipes({Key key, this.cartType}) : super(key: key);
  final cartType;
  GetStorage box = GetStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
      }),
      backgroundColor: CustomTheme.bgColor2,
      body: ListView(
        children: [
          Text(
            (cartType == "collection")
                ? "   My Weekly Cart List"
                : "   My Instameal Cart List",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: CustomTheme.bgColor),
          ),
          space0(),
          (cartType == "collection")
              ? SizedBox(
                  height: SizeConfig.screenHeight,
                  child: GetBuilder<WeeklyController>(
                      init: WeeklyController(),
                      builder: (_) {
                        return (_.listCartRecipe2.length == 0)
                            ? Center(
                                child: Image.asset(
                                "assets/images/norecord.png",
                                width: SizeConfig.screenWidth * 0.7,
                              ))
                            : ListView.builder(
                                itemCount: _.listCartRecipe2.length + 1,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return (index == _.listCartRecipe2.length)
                                      ? SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 50,
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Constants.navigatepush(
                                                context,
                                                RecipeDetail(
                                                  modelType: "collection",
                                                  recipeModel:
                                                      _.listCartRecipe2[index],
                                                ));

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             RecipeDetail(
                                            //               modelType:
                                            //                   "collection",
                                            //               recipeModel:
                                            //                   _.listCartRecipe2[
                                            //                       index],
                                            //             )));
                                          },
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            margin: EdgeInsets.all(
                                                SizeConfig.heightMultiplier),
                                            decoration: BoxDecoration(
                                              color: CustomTheme.bgColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CustomTheme.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 6,
                                                  spreadRadius: 6,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: CachedNetworkImage(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        20,
                                                    width: SizeConfig
                                                            .heightMultiplier *
                                                        20,
                                                    imageUrl: Constants
                                                            .baseImageUrl +
                                                        _.listCartRecipe2[index]
                                                            .imagesUrl,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
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
                                                SizedBox(
                                                  width: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: SizedBox(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        20,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          _
                                                              .listCartRecipe2[
                                                                  index]
                                                              .planName,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                        Text(
                                                          _
                                                              .listCartRecipe2[
                                                                  index]
                                                              .recipeName,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
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
                )
              : SizedBox(
                  height: SizeConfig.screenHeight,
                  child: GetBuilder<WeeklyController>(
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
                                          height:
                                              SizeConfig.heightMultiplier * 50,
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Constants.navigatepush(
                                                context,
                                                RecipeDetail(
                                                  modelType: "collection",
                                                  recipeModel:
                                                      _.listCartRecipe1[index],
                                                ));

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             RecipeDetail(
                                            //               modelType:
                                            //                   "collection",
                                            //               recipeModel:
                                            //                   _.listCartRecipe1[
                                            //                       index],
                                            //             )));
                                          },
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            margin: EdgeInsets.all(
                                                SizeConfig.heightMultiplier),
                                            decoration: BoxDecoration(
                                              color: CustomTheme.bgColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CustomTheme.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 6,
                                                  spreadRadius: 6,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: CachedNetworkImage(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        20,
                                                    width: SizeConfig
                                                            .heightMultiplier *
                                                        20,
                                                    imageUrl: Constants
                                                            .baseImageUrl +
                                                        _.listCartRecipe1[index]
                                                            .imagesUrl,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
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
                                                SizedBox(
                                                  width: SizeConfig
                                                      .heightMultiplier,
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: SizedBox(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        20,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          _
                                                              .listCartRecipe1[
                                                                  index]
                                                              .planName,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                        Text(
                                                          _
                                                              .listCartRecipe1[
                                                                  index]
                                                              .recipeName,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
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
                ),
        ],
      ),
    );
  }
}
