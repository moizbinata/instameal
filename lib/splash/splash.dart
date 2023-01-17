import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/splash/payscreen.dart';
import 'package:instameal/src/model/singletons_data.dart';
import 'package:instameal/src/store_config.dart';
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
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../src/components/native_dialog.dart';
import '../src/constant.dart';
import '../src/model/weather_data.dart';
import '../views/subscription/paywallwidget.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key}) : super(key: key);

  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/logoCircle.png',
                      width: SizeConfig.screenWidth * 0.5),
                  Image.asset(
                    "assets/images/splash.png",
                    width: SizeConfig.screenWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.1),
                    child: InkWell(
                      onTap: () async {
                        final UniversalController universalController =
                            Get.put(UniversalController());
                        universalController.fetchUniversal();
                        universalController.fetchAllRecipes();
                        if (box.read('username') == null &&
                            box.read('subscriptionStart') == null) {
                          Constants.navigatepushreplac(context, HomeIntro());
                        } else {
                          Get.offAll(BottomNavigator());
                        }
                        // if (now.toString().length > 2) {
                        //   if (box.read('username') == null) {
                        //     print("nav to home intro");
                        //     Constants.navigatepushreplac(context, HomeIntro());
                        //   } else if (box.read('subscriptionEnd') != null) {
                        //     var payStatus =
                        //         box.read('paymentStatus').toString() ?? "";
                        //     var memType =
                        //         box.read('membershipType').toString() ?? "";
                        //     DateTime subsEnd = DateTime.parse(
                        //         box.read('subscriptionEnd').toString());
                        //     print("now" + subsEnd.toString());
                        //     if (DateTime.parse(
                        //                 box.read('subscriptionEnd').toString())
                        //             .isAfter(now) &&
                        //         payStatus == "Paid")
                        //       Get.offAll(BottomNavigator());
                        //     else if (payStatus == "Trial" && memType == "Trial")
                        //       Get.offAll(TrialScreen());
                        //     else if (DateTime.parse(
                        //                 box.read('subscriptionEnd').toString())
                        //             .isBefore(now) &&
                        //         payStatus == "Paid" &&
                        //         memType == "Trial")
                        //       Get.offAll(PaymentScreen());
                        //     else {
                        //       print(payStatus);
                        //       print(now);
                        //       print(memType);
                        //       print(subsEnd);
                        //     }
                        //   }
                        // }
                      },
                      child: customButton3(
                        context,
                        CustomTheme.bgColor,
                        Colors.white,
                        "Get Started",
                      ),
                    ),
                  ),
                  space0(),
                ],
              ),
            ),
          ),
        ));
  }
}
