import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:instameal/controllers/weeklyController.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/ingredientlist.dart';
import 'package:instameal/views/details/recipe.dart';
import 'package:instameal/views/details/shopitems.dart';
import 'package:instameal/views/details/shopitems2.dart';
import '../../components/components.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';
import 'package:instameal/components/customappbar.dart';

class WeeklyIngred extends StatefulWidget {
  const WeeklyIngred({Key key}) : super(key: key);

  @override
  State<WeeklyIngred> createState() => _WeeklyIngredState();
}

class _WeeklyIngredState extends State<WeeklyIngred> {
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
      }, action2: () {
        showDialog(context: context, builder: (ctx) => notifDialog(ctx));
      }),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
        height: SizeConfig.screenHeight,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              space1(),
              Text(
                "Weekly ingredients",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "Order weekly ingredients at one click.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              space1(),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // crossAxisSpacing: SizeConfig.heightMultiplier,
                    // mainAxisSpacing: SizeConfig.heightMultiplier,
                  ),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          int lengthh = 0;
                          weeklyController.listofWeeklyBfast.forEach((element) {
                            lengthh += element.items.length;
                          });
                          print(lengthh);
                          Fluttertoast.showToast(
                              msg: "Loading, please wait",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                          Constants.navigatepush(
                              context,
                              ShopItems2(
                                itemLength: lengthh,
                                itemList: weeklyController.listofWeeklyBfast,
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(SizeConfig.heightMultiplier),
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.heightMultiplier * 1.5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: CustomTheme.grey,
                                blurRadius: 8.0,
                                spreadRadius: 7,
                                offset: Offset(-4, 3),
                              ),
                            ],
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: SizeConfig.heightMultiplier * 16,
                                  padding: EdgeInsets.all(
                                      SizeConfig.heightMultiplier),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Constants.colorList[index]),
                                  child: Image.asset(
                                    'assets/mealimg/${index + 1}.png',
                                  ),
                                ),
                                Text(
                                  Constants.categList[index].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: CustomTheme.bgColor,
                                      ),
                                )
                              ]),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
