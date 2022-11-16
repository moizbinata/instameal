import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/weeklyController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/theme.dart';
import '../../components/components.dart';
import '../../components/customdrawer.dart';
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
      key: _scaffoldKey,
      drawer: drawer(context),
      appBar: customAppBar(action: () {
        if (_scaffoldKey.currentState.isDrawerOpen) {
          _scaffoldKey.currentState.openEndDrawer();
        } else {
          _scaffoldKey.currentState.openDrawer();
        }
      }),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
          height: SizeConfig.screenHeight,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      space1(),
                      Column(
                        children: List.generate(
                          weekDays.length,
                          ((index) {
                            return Container(
                              width: SizeConfig.heightMultiplier * 3,
                              height: SizeConfig.heightMultiplier * 13,
                              color: (index % 2 == 0)
                                  ? Colors.blue
                                  : CustomTheme.bgColor,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Center(
                                  child: Text(
                                    weekDays[index],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    ]),
                  ),
                  Expanded(
                    flex: 12,
                    child: GetBuilder<WeeklyController>(
                      init: WeeklyController(),
                      builder: (_) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: (_.listofWeeklyBfast.isNotEmpty)
                                  ? Column(
                                      children: [
                                        Text(
                                          _.listofWeeklyBfast[0].categname,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                        ),
                                        Column(
                                            children: List.generate(
                                                _.listofWeeklyBfast.length,
                                                (indexi) {
                                          return InkWell(
                                              onTap: () {},
                                              child: recipeBox(
                                                  context,
                                                  _.listofWeeklyBfast[indexi]
                                                      .imagesUrl,
                                                  _.listofWeeklyBfast[indexi]
                                                      .recipeName));
                                        })),
                                      ],
                                    )
                                  : SizedBox(),
                            ),
                            Expanded(
                              flex: 1,
                              child: (_.listofWeeklyLunch.isNotEmpty)
                                  ? Column(
                                      children: [
                                        Text(
                                          _.listofWeeklyLunch[0].categname,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                        ),
                                        Column(
                                            children: List.generate(
                                                _.listofWeeklyLunch.length,
                                                (indexi) {
                                          return InkWell(
                                              onTap: () {},
                                              child: recipeBox(
                                                  context,
                                                  _.listofWeeklyLunch[indexi]
                                                      .imagesUrl,
                                                  _.listofWeeklyLunch[indexi]
                                                      .recipeName));
                                        })),
                                      ],
                                    )
                                  : SizedBox(),
                            ),
                            Expanded(
                              flex: 1,
                              child: (_.listofWeeklySnack.isNotEmpty)
                                  ? Column(
                                      children: [
                                        Text(
                                          _.listofWeeklySnack[0].categname,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                        ),
                                        Column(
                                            children: List.generate(
                                                _.listofWeeklySnack.length,
                                                (indexi) {
                                          return InkWell(
                                              onTap: () {},
                                              child: recipeBox(
                                                  context,
                                                  _.listofWeeklySnack[indexi]
                                                      .imagesUrl,
                                                  _.listofWeeklySnack[indexi]
                                                      .recipeName));
                                        })),
                                      ],
                                    )
                                  : SizedBox(),
                            ),
                            Expanded(
                              flex: 1,
                              child: (_.listofWeeklyDinner.isNotEmpty)
                                  ? Column(
                                      children: [
                                        Text(
                                          _.listofWeeklyDinner[0].categname,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                        ),
                                        Column(
                                            children: List.generate(
                                                _.listofWeeklyDinner.length,
                                                (indexi) {
                                          return InkWell(
                                              onTap: () {},
                                              child: recipeBox(
                                                  context,
                                                  _.listofWeeklyDinner[indexi]
                                                      .imagesUrl,
                                                  _.listofWeeklyDinner[indexi]
                                                      .recipeName));
                                        })),
                                      ],
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
