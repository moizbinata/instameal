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
              leading: Container(
                width: SizeConfig.heightMultiplier * 5,
                height: SizeConfig.heightMultiplier * 5,
                decoration: BoxDecoration(
                    color: Color(0xffe0f3fb),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    color: Color(0xff9fd6e5),
                    size: SizeConfig.heightMultiplier * 2,
                  ),
                ),
              ),
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
              leading: Container(
                width: SizeConfig.heightMultiplier * 5,
                height: SizeConfig.heightMultiplier * 5,
                decoration: BoxDecoration(
                    color: Color(0xfffdeade),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.bookmark,
                    color: Color(0xfffdd47d),
                    size: SizeConfig.heightMultiplier * 2,
                  ),
                ),
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
              leading: Container(
                width: SizeConfig.heightMultiplier * 5,
                height: SizeConfig.heightMultiplier * 5,
                decoration: BoxDecoration(
                    color: Color(0xfffcedf4),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.bookmark,
                    color: Color(0xffffb2d5),
                    size: SizeConfig.heightMultiplier * 2,
                  ),
                ),
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
              leading: Container(
                width: SizeConfig.heightMultiplier * 5,
                height: SizeConfig.heightMultiplier * 5,
                decoration: BoxDecoration(
                    color: Color(0xffc9c4ed),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.handshakeAngle,
                    color: Color(0xff8b82d0),
                    size: SizeConfig.heightMultiplier * 2,
                  ),
                ),
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
              leading: Container(
                width: SizeConfig.heightMultiplier * 5,
                height: SizeConfig.heightMultiplier * 5,
                decoration: BoxDecoration(
                    color: Color(0xfff6e3bc),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.arrowTrendUp,
                    color: Color(0xffde9b12),
                    size: SizeConfig.heightMultiplier * 2,
                  ),
                ),
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
              leading: Container(
                width: SizeConfig.heightMultiplier * 5,
                height: SizeConfig.heightMultiplier * 5,
                decoration: BoxDecoration(
                    color: Color(0xfff6e3bc),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.rightFromBracket,
                    color: Color(0xffde9b12),
                    size: SizeConfig.heightMultiplier * 2,
                  ),
                ),
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
