import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/src/model/singletons_data.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/details/profile.dart';
import 'package:instameal/views/nav_screen/favourite.dart';
import 'package:instameal/views/nav_screen/shopping.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:instameal/utils/constants.dart';
import 'package:instameal/views/login.dart';
import 'package:instameal/views/nav_screen/home.dart';

Widget drawer(context) {
  GetStorage box = GetStorage();
  return Drawer(
    child: ListView(
      // padding: EdgeInsets.zero,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerHeader(
          duration: Duration(seconds: 5),
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Image.asset('assets/images/logo.png',
                  width: SizeConfig.heightMultiplier * 11),
              ListTile(
                // contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0.0,
                leading: Image.asset(
                  box.read('gender').toString() == "Male"
                      ? 'assets/images/icons/icon4.png'
                      : 'assets/images/icons/icon1.png',
                ),
                title: Text(
                  box.read('username'),
                  style: Theme.of(context).textTheme.bodyMedium.copyWith(
                      color: CustomTheme.bgColor, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(box.read('email'),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "    My Account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(),
                SizedBox(),
                Text(
                  "1.0.0+16",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            ListTile(
              selected: true,
              selectedColor: CustomTheme.bgColor,
              tileColor: Colors.white,
              leading: iconBox(
                  Color(0xffe0f3fb), Color(0xff9fd6e5), FontAwesomeIcons.user),
              title: Text(
                "Account Details",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Constants.navigatepush(context, Profile());
              },
            ),
            ListTile(
              selected: true,
              selectedColor: CustomTheme.bgColor,
              tileColor: Colors.white,
              leading: iconBox(
                Color.fromARGB(64, 104, 173, 194),
                Color.fromARGB(255, 104, 173, 194),
                FontAwesomeIcons.calendarWeek,
              ),
              title: Text(
                "My Subscription",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Constants.navigatepush(context, Shopping());
              },
            ),
            space1(),
            Text("    Others",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
            ListTile(
              selected: true,
              selectedColor: CustomTheme.bgColor,
              tileColor: Colors.white,
              leading: iconBox(
                Color(0xffc9c4ed),
                Color(0xff8b82d0),
                FontAwesomeIcons.handshakeAngle,
              ),
              title: Text(
                "Support Center",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                launchEmailSubmission();
              },
            ),
            ListTile(
              selected: true,
              selectedColor: CustomTheme.bgColor,
              tileColor: Colors.white,
              leading: iconBox(
                Color(0xfff6e3bc),
                Color(0xffde9b12),
                FontAwesomeIcons.arrowTrendUp,
              ),
              title: Text(
                "Favorite Plans",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Constants.navigatepush(context, Favourite());
              },
            ),
            ListTile(
              selected: true,
              selectedColor: CustomTheme.bgColor,
              tileColor: Colors.white,
              leading: iconBox(
                Color(0xfffdeade),
                Color(0xfffdd47d),
                FontAwesomeIcons.bookmark,
              ),
              title: Text(
                "Weekly Ingredients",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Constants.navigatepush(context, Shopping());
              },
            ),
            space1(),
            ListTile(
              selected: true,
              selectedColor: CustomTheme.bgColor,
              tileColor: Colors.white,
              leading: iconBox(
                Color(0xfff6e3bc),
                Color(0xffde9b12),
                FontAwesomeIcons.rightFromBracket,
              ),
              title: Text(
                "Logout",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                GetStorage box = GetStorage();
                box.erase();
                appData.appUserID = "null";
                Fluttertoast.showToast(msg: 'Successfully Logout');
                Get.offAll(Login(
                  type: 1,
                ));
              },
            ),
          ],
        )
      ],
    ),
  );
}

void launchEmailSubmission({body}) async {
  GetStorage box = GetStorage();
  final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@instamealplans.com',
      query: 'subject=Activate my subscription&body=${body ?? ""}');
  String url = params.toString();
  await launchUrl(Uri.parse(url));
}
