import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';

import '../views/login.dart';
import '../views/nav_screen/home.dart';

Widget drawer(context) {
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
              space0(),
              Image.asset('assets/images/logo.png',
                  width: SizeConfig.heightMultiplier * 11),
              ListTile(
                // contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                  'assets/images/icons/icon1.png',
                ),
                title: Text(
                  "Patricia Kalara",
                  style: Theme.of(context).textTheme.bodyMedium.copyWith(
                      color: CustomTheme.bgColor, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("patricia.kalara@gmail.com",
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),

          //  Image.asset('assets/images/icons/icon1.png',
          //     width: SizeConfig.heightMultiplier * 10),

          // Image(
          //   image: const AssetImage('assets/images/icons/icon1.png'),
          //   width: SizeConfig.heightMultiplier * 20,
          // ),
        ),
        space1(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("    My Account",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
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
              onTap: () {},
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
                "My Subscription",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {},
            ),
            space1(),
            Text("    Others",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
            ListTile(
              selected: true,
              selectedColor: Color(0xfffcedf4),
              tileColor: Colors.white,
              leading: iconBox(
                Color(0xfffcedf4),
                Color(0xffffb2d5),
                FontAwesomeIcons.bookmark,
              ),
              title: Text(
                "Top Plans",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {},
            ),
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
              onTap: () {},
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
                "Trending Plans",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {},
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
                print("logout");
                GetStorage box = GetStorage();
                box.erase();
                Fluttertoast.showToast(msg: 'Successfully Logout');
                Get.offAll(Login());
              },
            ),
          ],
        )
      ],
    ),
  );
}
