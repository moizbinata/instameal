import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/howtocook.dart';
import 'package:instameal/views/details/shopitems.dart';

import 'package:instameal/components/components.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/controllers/weeklyController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class RecipeDetail extends StatelessWidget {
  RecipeDetail({Key key, this.recipeModel, this.modelType}) : super(key: key);
  final recipeModel;
  final modelType;
  GetStorage box = GetStorage();
  int ingredCount = 0;
  int directionCount = 0;
  @override
  Widget build(BuildContext context) {
    final weeklyController = Get.put(WeeklyController());
    ingredCount = 0;
    directionCount = 0;
    return Scaffold(
      floatingActionButton: floatButton(context),
      backgroundColor: CustomTheme.bgColor2,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: Container(
              margin: EdgeInsets.all(SizeConfig.heightMultiplier),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: CustomTheme.grey,
                  )),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: CustomTheme.bgColor,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: CustomTheme.bgColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: Constants.baseImageUrl + recipeModel.imagesUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/breakfast.png"),
                  ),
                ),
              ),
            ),
            // pinned: true,
            expandedHeight: SizeConfig.screenHeight * 0.4,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  decoration: BoxDecoration(
                      color: CustomTheme.bgColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier * 2),
                  width: SizeConfig.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space0(),
                      Text(
                        recipeModel.recipeName,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipeModel.planName ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(recipeModel.categName ?? "",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              if (modelType == "scateg") {
                                if (weeklyController.listCartRecipe4
                                    .contains(recipeModel)) {
                                  weeklyController.listCartRecipe4
                                      .remove(recipeModel);
                                  box.write(
                                      'scateg',
                                      weeklyController.listCartRecipe4
                                          .toList());
                                  print(box.read('scateg').toString());
                                  Fluttertoast.showToast(msg: 'Removed');
                                } else {
                                  weeklyController.listCartRecipe4
                                      .add(recipeModel);
                                  box.write(
                                      'scateg',
                                      weeklyController.listCartRecipe4
                                          .toList());
                                  print(box.read('scateg').toString());

                                  Fluttertoast.showToast(msg: 'Added');
                                }
                              } else if (modelType == "universal") {
                                if (weeklyController.listCartRecipe3
                                    .contains(recipeModel)) {
                                  weeklyController.listCartRecipe3
                                      .remove(recipeModel);
                                  box.write(
                                      'universal',
                                      weeklyController.listCartRecipe3
                                          .toList());
                                  print(box.read('universal').toString());
                                  Fluttertoast.showToast(msg: 'Removed');
                                } else {
                                  weeklyController.listCartRecipe3
                                      .add(recipeModel);
                                  box.write(
                                      'universal',
                                      weeklyController.listCartRecipe3
                                          .toList());
                                  print(box.read('universal').toString());
                                  Fluttertoast.showToast(msg: 'Added');
                                }
                              } else if (modelType == "collection") {
                                if (weeklyController.listCartRecipe2
                                    .contains(recipeModel)) {
                                  weeklyController.listCartRecipe2
                                      .remove(recipeModel);
                                  box.write(
                                      'collection',
                                      weeklyController.listCartRecipe2
                                          .toList());
                                  print(box.read('collection').toString());
                                  Fluttertoast.showToast(msg: 'Removed');
                                } else {
                                  weeklyController.listCartRecipe2
                                      .add(recipeModel);
                                  box.write(
                                      'collection',
                                      weeklyController.listCartRecipe2
                                          .toList());
                                  print(box.read('collection').toString());

                                  Fluttertoast.showToast(msg: 'Added');
                                }
                              } else {
                                var recipeToAdd;
                                int recipeId = recipeModel.recipeid;
                                if (recipeModel.categName == "Breakfast") {
                                  recipeToAdd = weeklyController
                                      .listofWeeklyBfast
                                      .where((p0) => p0.recipeid == recipeId)
                                      .first;
                                } else if (recipeModel.categName == "Lunch") {
                                  recipeToAdd = weeklyController
                                      .listofWeeklyLunch
                                      .where((p0) => p0.recipeid == recipeId)
                                      .first;
                                } else if (recipeModel.categName == "Snack") {
                                  recipeToAdd = weeklyController
                                      .listofWeeklySnack
                                      .where((p0) => p0.recipeid == recipeId)
                                      .first;
                                } else {
                                  recipeToAdd = weeklyController
                                      .listofWeeklyDinner
                                      .where((p0) => p0.recipeid == recipeId)
                                      .first;
                                }
                                if (weeklyController.listCartRecipe1
                                    .contains(recipeToAdd)) {
                                  weeklyController.listCartRecipe1
                                      .removeWhere(recipeToAdd);
                                  box.write(
                                      'breakfast',
                                      weeklyController.listCartRecipe1
                                          .toList());
                                  Fluttertoast.showToast(msg: 'Removed');
                                } else {
                                  weeklyController.listCartRecipe1
                                      .add(recipeToAdd);
                                  box.write(
                                      'breakfast',
                                      weeklyController.listCartRecipe1
                                          .toList());
                                  print(box.read('breakfast').toString());
                                  Fluttertoast.showToast(msg: 'Added');
                                }
                                print("moiuz");
                                print(recipeModel.recipeName);
                                print(weeklyController
                                    .listCartRecipe1.first.recipeName);
                              }
                            },
                            icon: GetX<WeeklyController>(
                              builder: (controller) => FaIcon(
                                (controller.listCartRecipe1
                                            .contains(recipeModel) ||
                                        controller.listCartRecipe2
                                            .contains(recipeModel) ||
                                        controller.listCartRecipe3
                                            .contains(recipeModel) ||
                                        controller.listCartRecipe4
                                            .contains(recipeModel))
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: (controller.listCartRecipe1
                                            .contains(recipeModel) ||
                                        controller.listCartRecipe2
                                            .contains(recipeModel) ||
                                        controller.listCartRecipe3
                                            .contains(recipeModel) ||
                                        controller.listCartRecipe4
                                            .contains(recipeModel))
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                            label: Text(
                              "Favorite",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              Constants.navigatepush(
                                context,
                                HowtoCook(
                                  directionsList: recipeModel.direction,
                                ),
                              );
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.kitchenSet,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Start Cook",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              const storeUrl =
                                  "https://play.google.com/store/apps/details?id=com.insta.instameal";
                              final imgUrl = Uri.parse(Constants.baseImageUrl +
                                  recipeModel.imagesUrl);
                              final response = await http.get(imgUrl);
                              final bytes = response.bodyBytes;
                              final temp = await getTemporaryDirectory();
                              final path =
                                  "${temp.path}/${recipeModel.imagesUrl}";
                              File(path).writeAsBytesSync(bytes);

                              await Share.shareFiles(
                                [path],
                                text:
                                    "Checkout this recipe on Instameal App💜.\n\n $storeUrl \n\nRecipe Name: ${recipeModel.recipeName}",
                              );
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.share,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Share",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                space0(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier * 2),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/food.png",
                              height: SizeConfig.heightMultiplier * 4,
                              fit: BoxFit.contain,
                            ),
                            Text(recipeModel.prepTime + " Prep Time",
                                style: Theme.of(context).textTheme.bodySmall),
                            Text(recipeModel.cookTime + " Cook Time",
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Constants.navigatepush(
                                    context,
                                    ShopItems(
                                      itemList: recipeModel,
                                    ));
                              },
                              child: customButton2(context, Colors.white,
                                  CustomTheme.bgColor, "Order items",
                                  bg: CustomTheme.bgColor),
                            ),
                            SizedBox(
                              width: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                        Text(
                          "Servings: " + recipeModel.serving.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        space0(),
                        Text(
                          "Ingredients: ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        space0(),
                        //ingredients
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 2000, minHeight: 56.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: recipeModel.whatYouNeed.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              recipeModel.whatYouNeed[index]
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
                                                color: recipeModel
                                                        .whatYouNeed[index]
                                                        .toString()
                                                        .contains(":")
                                                    ? CustomTheme.bgColor2
                                                    : CustomTheme.bgColor)),
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: recipeModel
                                                  .whatYouNeed[index]
                                                  .toString()
                                                  .contains(":")
                                              ? SizeConfig.heightMultiplier * 2
                                              : 0),
                                      child: Text(
                                          recipeModel.whatYouNeed[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              .copyWith(
                                                  fontWeight: recipeModel
                                                          .whatYouNeed[index]
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
                        space0(),
                        Text(
                          "Directions: ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        space0(),
                        //directions
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 2000, minHeight: 56.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipeModel.direction.length,
                            itemBuilder: (context, index) {
                              recipeModel.direction[index]
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
                                                color: recipeModel
                                                        .direction[index]
                                                        .toString()
                                                        .contains(":")
                                                    ? CustomTheme.bgColor2
                                                    : CustomTheme.bgColor)),
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: recipeModel.direction[index]
                                                  .toString()
                                                  .contains(":")
                                              ? SizeConfig.heightMultiplier * 2
                                              : 0),
                                      child: Text(recipeModel.direction[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              .copyWith(
                                                  fontWeight: recipeModel
                                                          .direction[index]
                                                          .toString()
                                                          .contains(":")
                                                      ? FontWeight.bold
                                                      : FontWeight.normal)),
                                    ),
                                  )
                                ],
                              );

                              // RichText(
                              //   text: TextSpan(
                              //     children: [
                              //       TextSpan(
                              //           text: (directionCount < 10)
                              //               ? "0" +
                              //                   (directionCount).toString() +
                              //                   ":  "
                              //               : "" +
                              //                   (directionCount).toString() +
                              //                   ":  ",
                              //           style: Theme.of(context)
                              //               .textTheme
                              //               .bodySmall
                              //               .copyWith(
                              //                   color: recipeModel
                              //                           .direction[index]
                              //                           .toString()
                              //                           .contains(":")
                              //                       ? CustomTheme.bgColor2
                              //                       : CustomTheme.bgColor)),
                              //       TextSpan(
                              //           text: recipeModel.direction[index],
                              //           style: Theme.of(context)
                              //               .textTheme
                              //               .bodySmall)
                              //     ],
                              //   ),
                              // );
                            },
                          ),
                        ),

                        space0(),
                        space0(),
                        Text(
                          "Nutrition Per Serve: ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        space0(),
                        Container(
                          height: SizeConfig.heightMultiplier * 4,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: recipeModel.nutritPerServe.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              print(recipeModel.nutritPerServe.length);
                              return Container(
                                height: SizeConfig.heightMultiplier * 4,
                                width: SizeConfig.heightMultiplier * 12,
                                margin: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.heightMultiplier),
                                decoration: BoxDecoration(
                                    color: (recipeModel.nutritPerServe[index]
                                            .toString()
                                            .contains("Fats"))
                                        ? Color(0xff8b82d0)
                                        : (recipeModel.nutritPerServe[index]
                                                .toString()
                                                .contains("Fiber"))
                                            ? Color(0xffde9b12)
                                            : (recipeModel.nutritPerServe[index]
                                                    .toString()
                                                    .contains("Kcal"))
                                                ? Color(0xffffb2d5)
                                                : (recipeModel
                                                        .nutritPerServe[index]
                                                        .toString()
                                                        .contains("Protein"))
                                                    ? Color.fromARGB(
                                                        255, 57, 197, 221)
                                                    : CustomTheme.bgColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    recipeModel.nutritPerServe[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        space0(),

                        Text(
                          "Keys: ",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        //keys
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 4,
                          child: Center(
                            child: ListView.builder(
                              itemCount: recipeModel.keys.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    height: SizeConfig.heightMultiplier * 4,
                                    width: SizeConfig.heightMultiplier * 4,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.heightMultiplier),
                                    decoration: BoxDecoration(
                                        color: (recipeModel.keys[index]
                                                    .toString() ==
                                                "DF")
                                            ? Color(0xff8b82d0)
                                            : (recipeModel.keys[index]
                                                        .toString() ==
                                                    "MP")
                                                ? Color(0xffde9b12)
                                                : (recipeModel.keys[index]
                                                            .toString() ==
                                                        "V")
                                                    ? Color(0xffffb2d5)
                                                    : (recipeModel.keys[index]
                                                                .toString() ==
                                                            "N")
                                                        ? Color(0xffffb2d5)
                                                        : CustomTheme.bgColor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                        child: Text(
                                      recipeModel.keys[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          .copyWith(color: Colors.white),
                                    )));
                              },
                            ),
                          ),
                        ),
                        space0(),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
