import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../../src/components/native_dialog.dart';
import '../../src/model/weather_data.dart';
import '../../utils/network.dart';

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

  // @override
  // void initState() {
  //   // initPlatformState();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: Container(
        height: SizeConfig.screenHeight,
        padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         Constants.navigatepushreplac(context, Login());
            //       },
            //       icon: FaIcon(
            //         FontAwesomeIcons.rightToBracket,
            //         color: CustomTheme.bgColor,
            //       ),
            //     ),
            //   ],
            // ),

            // Icon(isSubscriberd ? Icons.paid : Icons.lock),
            // Text(coins.toString()),
            Text(
              "Activate Account",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: CustomTheme.bgColor),
            ),
            space0(),

            InkWell(
              onTap: (() {
                perfomMagic(context);
              }),
              child: customButton(
                  context, Colors.white, CustomTheme.bgColor, "Activate"),
            ),
            space0(),
            InkWell(
              onTap: (() {
                GetStorage box = GetStorage();
                box.erase();
                Fluttertoast.showToast(msg: 'Successfully Logout');
                Get.offAll(Login(
                  type: 1,
                ));
              }),
              child: customButton(
                  context, CustomTheme.bgColor, Colors.white, "Logout"),
            ),
          ],
        ),
      ),
    );
  }

  /*
    We should check if we can magically change the weather 
    (subscription active) and if not, display the paywall.
  */
  void perfomMagic(ctx) async {
    print("perfomMagic");
    appData.appUserID = box.read('email').toString();
    // appData.currentData
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID].isActive == true) {
      appData.currentData = WeatherData.generateData();
      print("checking if");
    } else {
      print("checking else");

      Offerings offerings;
      try {
        print("checking getoffering try");
        offerings = await Purchases.getOfferings();
      } on PlatformException catch (e) {
        print("checking getoffering catch");

        await showDialog(
          context: context,
          builder: (BuildContext context) => ShowDialogToDismiss(
            title: "Error",
            content: e.message,
            buttonText: 'OK',
          ),
        );
      }

      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to your user
        print("offerings null");
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
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: SafeArea(
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        height: 70.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: CustomTheme.bgColor,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0))),
                        child: const Center(
                            child: Text('✨ Instameal Plans Premium')),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 32, bottom: 16, left: 16.0, right: 16.0),
                        child: SizedBox(
                          child: Text(
                            'Instameal Plans we are offering: ',
                          ),
                          width: double.infinity,
                        ),
                      ),
                      ListView.builder(
                        itemCount: offerings.current.availablePackages.length,
                        itemBuilder: (BuildContext context, int index) {
                          var myProductList =
                              offerings.current.availablePackages;
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                                onTap: () async {
                                  try {
                                    CustomerInfo customerInfo =
                                        await Purchases.purchasePackage(
                                      myProductList[index],
                                    )
                                            // ignore: missing_return
                                            .then((value) {
                                      Fluttertoast.showToast(msg: 'Updated 1');

                                      updateSubscription(ctx, 2);
                                    });
                                    appData.appUserID =
                                        await Purchases.appUserID;
                                    await updateSubscription(ctx, 2);
                                    Fluttertoast.showToast(msg: 'Updated 2');

                                    if (customerInfo.entitlements
                                            .all[entitlementID].isActive &&
                                        appData.appUserID != null) {
                                      Fluttertoast.showToast(msg: 'Updated 3');
                                      print("MOIZ IS PAID");
                                      // await postSignup(ctx);
                                      await updateSubscription(ctx, 1);
                                    } else {
                                      print("MOIZ IS NOT PAID");
                                    }

                                    // appData.entitlementIsActive = customerInfo
                                    //     .entitlements.all[entitlementID].isActive;
                                  } catch (e) {
                                    print(e);
                                    print("payment  error");
                                  }

                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                title: Text(
                                  myProductList[index].storeProduct.title,
                                ),
                                subtitle: Text(
                                  myProductList[index].storeProduct.description,
                                ),
                                trailing: Text(
                                  myProductList[index].storeProduct.priceString,
                                )),
                          );
                        },
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                "https://instamealplans.com/terms-conditions/"));
                          },
                          child: Text(
                            "By continuing, I agree to Terms and Conditions",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                .copyWith(
                                    color: CustomTheme.primaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      }
    }
  }

  updateSubscription(context, type) async {
    appData.appUserID = await Purchases.appUserID;
    var username = box.read('username');
    String url = "";
    if (type == 1)
      url =
          "${Constants.baseUrl}updatesubscription/Username/$username/SubStart/${appData.appUserID}/SubEnd/Done";
    else
      url =
          "${Constants.baseUrl}updatesubscription/Username/$username/SubStart/${appData.appUserID}/SubEnd/Processing";

    var response = await Network.put(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null && response.contains("true")) {
      Fluttertoast.showToast(msg: "Successfully Subscribed");
      Constants.navigatepushreplac(
          context,
          Login(
            type: 1,
          ));
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  // Future<void> initPlatformState() async {
  //   // Enable debug logs before calling `configure`.
  //   await Purchases.setDebugLogsEnabled(true);

  //   /*
  //   - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

  //   - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
  //   */
  //   PurchasesConfiguration configuration;
  //   if (StoreConfig.isForAmazonAppstore()) {
  //     configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
  //       ..appUserID = null
  //       ..observerMode = false;
  //   } else {
  //     configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
  //       ..appUserID = null
  //       ..observerMode = false;
  //   }
  //   await Purchases.configure(configuration);

  //   appData.appUserID = await Purchases.appUserID;

  //   Purchases.addCustomerInfoUpdateListener((customerInfo) async {
  //     appData.appUserID = await Purchases.appUserID;

  //     CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  //     (customerInfo.entitlements.all[entitlementID] != null &&
  //             customerInfo.entitlements.all[entitlementID].isActive)
  //         ? appData.entitlementIsActive = true
  //         : appData.entitlementIsActive = false;

  //     // setState(() {});
  //   });
  // }

}
