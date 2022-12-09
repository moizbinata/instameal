import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/views/details/cartrecipes.dart';
import 'package:instameal/views/details/weekingredients.dart';

import '../../components/components.dart';
import '../../components/customDialogue.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../components/notifdialog.dart';
import '../../controllers/universalController.dart';
import '../../controllers/weeklyController.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';
import '../details/weektable.dart';

class Shopping extends StatelessWidget {
  Shopping({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final universalController = Get.put(UniversalController());
    // final weeklyController = Get.put(WeeklyController());
    // weeklyController.getCartRecipe();
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
      body: ListView(
        children: [
          ListTile(
            onTap: () => customDialogue(context),
            title: Text("Selected Online Mart",
                style: Theme.of(context).textTheme.headline6),
            subtitle: Text("Change Online Mart",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    .copyWith(decoration: TextDecoration.underline)),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
          Padding(
              padding:
                  EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier),
              child: Obx(
                () => Image.asset(
                  'assets/images/shop/${universalController.mart.value}.png',
                  height: SizeConfig.heightMultiplier * 5,
                  fit: BoxFit.fitHeight,
                ),
              )),
          ListTile(
            onTap: () => planDialogue(context),
            title: Text("Plan subscribed",
                style: Theme.of(context).textTheme.headline6),
            subtitle: Text(
              "Change",
              style: Theme.of(context).textTheme.bodySmall.copyWith(
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
          Obx(() => Center(
              child: Text(universalController.plan.value,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: CustomTheme.bgColor,
                        decoration: TextDecoration.underline,
                      )))),
          ListTile(
            title: Text("My Instameal Meals List",
                style: Theme.of(context).textTheme.headline6),
          ),
          ListTile(
            onTap: () async {
              final weeklyController = Get.put(WeeklyController());
              int week = weeklyController.currentRxWeek.value;
              await weeklyController.fetchWeekly(
                  box.read('planid').toString(), week);
              Constants.navigatepush(context, WeeklyIngred());
            },
            tileColor: Colors.white,
            leading: iconBox(
              Color(0xfff6e3bc),
              Color(0xffde9b12),
              FontAwesomeIcons.cookieBite,
            ),
            title: Text(
              "Weekly shopping ingredients in cart",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}
