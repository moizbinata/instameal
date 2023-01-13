import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/splash/payscreen.dart';
import 'package:instameal/src/constant.dart';
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
import 'package:instameal/views/subscription/paywallwidget.dart';
import 'package:instameal/views/subscription/trial_screen.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../src/components/native_dialog.dart';
import '../../src/model/weather_data.dart';

// import '../src/components/native_dialog.dart';
// import '../src/constant.dart';
// import '../src/model/weather_data.dart';
// import '../views/subscription/paywallwidget.dart';

class SubscribePlans extends StatefulWidget {
  const SubscribePlans({Key key}) : super(key: key);

  @override
  State<SubscribePlans> createState() => SubscribePlansState();
}

class SubscribePlansState extends State<SubscribePlans> {
  GetStorage box = GetStorage();
  bool _isLoading = false;
  int currentIndex = 0;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight,
          padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Constants.navigatepushreplac(context, Login());
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.rightToBracket,
                        color: CustomTheme.bgColor,
                      ),
                    ),
                  ],
                ),
                // Icon(isSubscriberd ? Icons.paid : Icons.lock),
                // Text(coins.toString()),
                Text(
                  "Sign up for Free 14 days Trial",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: CustomTheme.bgColor),
                ),
                space0(),
                bulletPoints(context, label: "More Than Just a Meal Plan."),
                bulletPoints(
                  context,
                  label:
                      "With a InstaMeals subscription, it`s like getting a personal chef and dietitian all in one.",
                ),
                bulletPoints(context, label: "The easiest way to eat healthy."),
                bulletPoints(
                  context,
                  label:
                      "Good for your groceries, simple recipes, recommended just for you.",
                ),

                bulletPoints(
                  context,
                  label: "Youre always in control.",
                ),
                bulletPoints(
                  context,
                  label: "Take our suggestions or choose exactly what you want",
                ),
                bulletPoints(
                  context,
                  label: "Calorie & Portion Controlled",
                ),
                bulletPoints(
                  context,
                  label: "Nutritionally Balanced",
                ),
                bulletPoints(
                  context,
                  label:
                      "Printable weekly shopping list/send shopping list to instacart",
                ),
                bulletPoints(
                  context,
                  label:
                      "Access to 5000 breakfast, lunch, snacks, dinner, dessert and holidays recipes",
                ),

                bulletPoints(
                  context,
                  label: "Hit Pause Anytime",
                ),
                bulletPoints(
                  context,
                  label: "Keep it USD 9.99 & USD 99",
                ),
                bulletPoints(
                  context,
                  label: "Start your trial with 1 USD, and enjoy for 14 days",
                ),
                space0(),
                InkWell(
                  onTap: (() {
                    perfomMagic();
                  }),
                  child: customButton(
                      context,
                      Colors.white,
                      CustomTheme.bgColor,
                      "Continue and Enjoy 14 days free trial"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
    We should check if we can magically change the weather 
    (subscription active) and if not, display the paywall.
  */
  void perfomMagic() async {
    setState(() {
      _isLoading = true;
    });

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID].isActive == true) {
      appData.currentData = WeatherData.generateData();

      setState(() {
        _isLoading = false;
      });
    } else {
      Offerings offerings;
      try {
        offerings = await Purchases.getOfferings();
      } on PlatformException catch (e) {
        await showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
                title: "Error", content: e.message, buttonText: 'OK'));
      }

      setState(() {
        _isLoading = false;
      });

      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to your user
      } else {
        // current offering is available, show paywall
        await showModalBottomSheet(
          useRootNavigator: true,
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return Paywall(
                offering: offerings.current,
              );
            });
          },
        );
      }
    }
  }

  Future<void> initPlatformState() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setDebugLogsEnabled(true);

    /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
    */
    PurchasesConfiguration configuration;
    if (StoreConfig.isForAmazonAppstore()) {
      configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = null
        ..observerMode = false;
    } else {
      configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = null
        ..observerMode = false;
    }
    await Purchases.configure(configuration);

    appData.appUserID = await Purchases.appUserID;

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      appData.appUserID = await Purchases.appUserID;

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      (customerInfo.entitlements.all[entitlementID] != null &&
              customerInfo.entitlements.all[entitlementID].isActive)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;

      setState(() {});
    });
  }
}
