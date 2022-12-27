import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/intro/intro.dart';
import 'package:instameal/views/login.dart';
import 'package:instameal/views/nav_screen/home.dart';
import 'package:instameal/views/subscription/payment_screen.dart';
import '../components/components.dart';
import '../controllers/universalController.dart';
import '../utils/constants.dart';
import '../utils/sizeconfig.dart';
import '../views/subscription/trial_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key}) : super(key: key);
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomTheme.bgColor,
        body: SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.1),
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: SafeArea(
              child: Column(
                // mainAxisAlignment: MAinA,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Food for Everyone",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3),
                  Image.asset('assets/images/logoCircle.png',
                      width: SizeConfig.screenWidth * 0.5),
                  Image.asset(
                    "assets/images/splash.png",
                    width: SizeConfig.heightMultiplier * 20,
                  ),
                  InkWell(
                    onTap: () {
                      DateTime now = DateTime.now();
                      print("now" + now.toString());
                      print(
                          "mem type " + box.read('membershipType').toString());
                      print("paymentStatus " +
                          box.read('paymentStatus').toString());
                      final univerContr = Get.put(UniversalController());
                      univerContr.fetchAllRecipes();
                      if (box.read('username') == null) {
                        print("nav to home intro");
                        Constants.navigatepushreplac(context, HomeIntro());
                      } else if (box.read('subscriptionEnd') != null) {
                        DateTime subsEnd = DateTime.parse(
                            box.read('subscriptionEnd').toString());
                        var payStatus =
                            box.read('paymentStatus').toString() ?? "";
                        var memType =
                            box.read('membershipType').toString() ?? "";
                        if (now.isAfter(subsEnd)) {
                          print("nav to pay screenn");

                          Constants.navigatepushreplac(
                              context, PaymentScreen());
                        } else {
                          print("nav to home");

                          Constants.navigatepushreplac(
                              context, BottomNavigator());
                        }
                      }
                    },
                    child: customButton(
                      context,
                      CustomTheme.bgColor,
                      Colors.white,
                      "Get Started",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
