import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/weeklyController.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/ingredientlist.dart';
import 'package:instameal/views/details/recipe.dart';
import 'package:instameal/views/details/shopitems.dart';
import '../../components/components.dart';
import '../../components/customdrawer.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import 'package:instameal/components/customappbar.dart';

class WeeklyIngred extends StatefulWidget {
  const WeeklyIngred({Key key}) : super(key: key);

  @override
  State<WeeklyIngred> createState() => _WeeklyIngredState();
}

class _WeeklyIngredState extends State<WeeklyIngred> {
  List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final weeklyController = Get.put(WeeklyController());
    return Scaffold(
      floatingActionButton: floatButton(context),
      backgroundColor: CustomTheme.bgColor2,
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: customAppBar(action: () {
        if (_scaffoldKey.currentState.isDrawerOpen) {
          _scaffoldKey.currentState.openEndDrawer();
        } else {
          _scaffoldKey.currentState.openDrawer();
        }
      }),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
        height: SizeConfig.screenHeight,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(),

              //Breakfast
              GetBuilder<WeeklyController>(
                init: WeeklyController(),
                builder: (_) {
                  return (_.listofWeeklyBfast.isEmpty)
                      ? Text("No recipe added")
                      : Container(
                          // color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space0(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "   For ${_.listofWeeklyBfast.first.categName}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Constants.navigatepush(
                                      //     context,
                                      //     IngredientList(
                                      //       recipeModel: recipe,
                                      //     ));
                                    },
                                    child: Text("Order all",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklyBfast.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: ingredientList(
                                          _.listofWeeklyBfast[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
              Divider(),
              Divider(),
              //Lunch
              GetBuilder<WeeklyController>(
                init: WeeklyController(),
                builder: (_) {
                  return (_.listofWeeklyLunch.isEmpty)
                      ? Text("No recipe added")
                      : Container(
                          // color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space0(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "   For ${_.listofWeeklyLunch.first.categName}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Constants.navigatepush(
                                      //     context,
                                      //     IngredientList(
                                      //       recipeModel: recipe,
                                      //     ));
                                    },
                                    child: Text("Order all",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklyLunch.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: ingredientList(
                                          _.listofWeeklyLunch[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
              Divider(),
              Divider(),
              //Snack
              GetBuilder<WeeklyController>(
                init: WeeklyController(),
                builder: (_) {
                  return (_.listofWeeklySnack.isEmpty)
                      ? Text("No recipe added")
                      : Container(
                          // color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space0(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "   For ${_.listofWeeklySnack.first.categName}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Constants.navigatepush(
                                      //     context,
                                      //     IngredientList(
                                      //       recipeModel: recipe,
                                      //     ));
                                    },
                                    child: Text("Order all",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklySnack.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: ingredientList(
                                          _.listofWeeklySnack[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
              Divider(),
              Divider(),
              //Dinner
              GetBuilder<WeeklyController>(
                init: WeeklyController(),
                builder: (_) {
                  return (_.listofWeeklyDinner.isEmpty)
                      ? Text("No recipe added")
                      : Container(
                          // color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space0(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "   For ${_.listofWeeklyDinner.first.categName}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Constants.navigatepush(
                                      //     context,
                                      //     ShopItems(
                                      //       itemList: recipeModel,
                                      //     ));
                                    },
                                    child: Text("Order all",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklyDinner.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: ingredientList(
                                          _.listofWeeklyDinner[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  ingredientList(recipe) {
    return Container(
        margin: EdgeInsets.all(SizeConfig.heightMultiplier),
        height: SizeConfig.heightMultiplier * 20,
        width: SizeConfig.heightMultiplier * 20,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(recipe.dayName.toString(),
                    style: Theme.of(context).textTheme.bodySmall),
                TextButton(
                  onPressed: () {
                    Constants.navigatepush(
                        context,
                        IngredientList(
                          recipeModel: recipe,
                        ));
                  },
                  child: Text("Show all",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          .copyWith(decoration: TextDecoration.underline)),
                )
              ],
            ),
            Text(
              recipe.recipeName,
              maxLines: 2,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium.copyWith(
                  decoration: TextDecoration.underline,
                  color: CustomTheme.bgColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                recipe.items.length,
                (index) {
                  return Text(
                    recipe.items[index].toString().capitalizeFirst,
                    style: TextStyle(color: Colors.black),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
