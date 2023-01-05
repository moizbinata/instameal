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
import 'package:instameal/components/components.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/views/subscription/trial_screen.dart';

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
                      final UniversalController universalController =
                          Get.put(UniversalController());
                      universalController.fetchUniversal();

                      // print(universalController.currentDate.toString());

                      DateTime now = DateTime.parse(
                          universalController.currentDate.toString());
                      // DateTime now = DateTime.now();
                      print("now" + now.toString());
                      print(
                          "mem type " + box.read('membershipType').toString());
                      print("paymentStatus " +
                          box.read('paymentStatus').toString());
                      final univerContr = Get.put(UniversalController());
                      univerContr.fetchAllRecipes();
                      if (now.toString().length > 2) {
                        if (box.read('username') == null) {
                          print("nav to home intro");
                          Constants.navigatepushreplac(context, HomeIntro());
                        } else if (box.read('subscriptionEnd') != null) {
                          var payStatus =
                              box.read('paymentStatus').toString() ?? "";
                          var memType =
                              box.read('membershipType').toString() ?? "";
                          DateTime subsEnd = DateTime.parse(
                              box.read('subscriptionEnd').toString());
                          print("now" + subsEnd.toString());
                          if (DateTime.parse(
                                      box.read('subscriptionEnd').toString())
                                  .isAfter(now) &&
                              payStatus == "Paid")
                            Get.offAll(BottomNavigator());
                          else if (payStatus == "Trial" && memType == "Trial")
                            Get.offAll(TrialScreen());
                          else if (DateTime.parse(
                                      box.read('subscriptionEnd').toString())
                                  .isBefore(now) &&
                              payStatus == "Paid" &&
                              memType == "Trial")
                            Get.offAll(PaymentScreen());
                          else {
                            print(payStatus);
                            print(now);
                            print(memType);
                            print(subsEnd);
                          }
                          // if (now.isAfter(subsEnd)) {
                          //   print("nav to pay screenn");
                          //   Constants.navigatepushreplac(
                          //       context, PaymentScreen());
                          // } else if (payStatus == "Trial" && memType == "Trial") {
                          //   print("nav to trial screenn");
                          //   Constants.navigatepushreplac(context, TrialScreen());
                          // } else {
                          //   print("nav to home");
                          //   Constants.navigatepushreplac(
                          //       context, BottomNavigator());
                          // }
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
