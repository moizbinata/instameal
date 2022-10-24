import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/utils/sizeconfig.dart';

import '../../components/components.dart';
import '../../components/customDialogue.dart';
import '../../components/customappbar.dart';
import '../../components/customdrawer.dart';
import '../../controllers/universalController.dart';
import '../../utils/theme.dart';

class Shopping extends StatelessWidget {
  Shopping({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final universalController = Get.put(UniversalController());

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
            title: Text("My Instameal Meals List",
                style: Theme.of(context).textTheme.headline6),
          ),
          ListTile(
            title: Text(
              "Current Added Meals",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "contains 0 meal",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: iconBox(
              Color(0xfffcedf4),
              Color(0xffffb2d5),
              FontAwesomeIcons.opencart,
            ),
            title: Text(
              "Instameal Recipe in Cart",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: iconBox(
              Color(0xffe0f3fb),
              Color(0xff9fd6e5),
              FontAwesomeIcons.bookmark,
            ),
            title: Text(
              "Selected Instameal Recipe",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            title: Text(
              "Meals History",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "contains 0 meal",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: iconBox(
              Color(0xfffdeade),
              Color(0xfffdd47d),
              FontAwesomeIcons.clockRotateLeft,
            ),
            title: Text(
              "Items/Ingredients History",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: iconBox(
              Color(0xfff6e3bc),
              Color(0xffde9b12),
              FontAwesomeIcons.cookieBite,
            ),
            title: Text(
              "Recipes you have enjoyed",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: FaIcon(FontAwesomeIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}
