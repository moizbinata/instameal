import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/weeklyController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/recipe.dart';
import '../../components/components.dart';
import '../../components/customdrawer.dart';
import '../../controllers/universalController.dart';
import '../../utils/sizeconfig.dart';
import 'package:instameal/components/customappbar.dart';

class WeekTable extends StatefulWidget {
  WeekTable({
    Key key,
  }) : super(key: key);

  @override
  State<WeekTable> createState() => _WeekTableState();
}

class _WeekTableState extends State<WeekTable> {
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
                              Text(
                                "   For ${_.listofWeeklyBfast.first.categName}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklyBfast.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Constants.navigatepush(
                                            context,
                                            RecipeDetail(
                                              modelType: "breakfast",
                                              recipeModel:
                                                  _.listofWeeklyBfast[index],
                                            ));
                                      },
                                      child: recipeBox2(
                                        context,
                                        _.listofWeeklyBfast[index].imagesUrl,
                                        _.listofWeeklyBfast[index].day,
                                        _.listofWeeklyBfast[index].recipeName,
                                        _.listofWeeklyBfast[index].dayName,
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
                              Text(
                                "   For ${_.listofWeeklyLunch.first.categName}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklyLunch.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Constants.navigatepush(
                                            context,
                                            RecipeDetail(
                                              modelType: "breakfast",
                                              recipeModel:
                                                  _.listofWeeklyLunch[index],
                                            ),
                                          );
                                        },
                                        child: recipeBox2(
                                          context,
                                          _.listofWeeklyLunch[index].imagesUrl,
                                          _.listofWeeklyLunch[index].day,
                                          _.listofWeeklyLunch[index].recipeName,
                                          _.listofWeeklyLunch[index].dayName,
                                          CustomTheme.bgColor,
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
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
                              Text(
                                "   For ${_.listofWeeklySnack.first.categName}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklySnack.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Constants.navigatepush(
                                              context,
                                              RecipeDetail(
                                                modelType: "breakfast",
                                                recipeModel:
                                                    _.listofWeeklySnack[index],
                                              ));
                                        },
                                        child: recipeBox2(
                                          context,
                                          _.listofWeeklySnack[index].imagesUrl,
                                          _.listofWeeklySnack[index].day,
                                          _.listofWeeklySnack[index].recipeName,
                                          _.listofWeeklySnack[index].dayName,
                                          CustomTheme.bgColor,
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
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
                              Text(
                                "   For ${_.listofWeeklyDinner.first.categName}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 35,
                                child: ListView.builder(
                                  itemCount: _.listofWeeklyDinner.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Constants.navigatepush(
                                              context,
                                              RecipeDetail(
                                                modelType: "breakfast",
                                                recipeModel:
                                                    _.listofWeeklyDinner[index],
                                              ));
                                        },
                                        child: recipeBox2(
                                          context,
                                          _.listofWeeklyDinner[index].imagesUrl,
                                          _.listofWeeklyDinner[index].day,
                                          _.listofWeeklyDinner[index]
                                              .recipeName,
                                          _.listofWeeklyDinner[index].dayName,
                                          CustomTheme.bgColor,
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
