import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/views/login.dart';
import 'package:instameal/views/subscription/paywallwidget.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:instameal/checkout/constants.dart';
import 'package:instameal/components/components.dart';
import 'package:instameal/controllers/buttonController.dart';
import 'package:instameal/controllers/universalController.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/network.dart';
import 'package:instameal/utils/purchaseapi.dart';
import 'package:instameal/utils/sizeconfig.dart';
import 'package:instameal/utils/theme.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool payLoader = false;
  bool isSubscriberd = false;
  int coins = 0;
  Map<String, dynamic> paymentIntentMonthly;
  Map<String, dynamic> paymentIntentYearly;
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final buttonController = Get.put(ButtonController());

    return Scaffold(
        backgroundColor: CustomTheme.bgColor2,
        body: SafeArea(
          child: Container(
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
              child: SingleChildScrollView(
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
                            icon: const FaIcon(
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
                      bulletPoints(context,
                          label: "More Than Just a Meal Plan."),
                      bulletPoints(
                        context,
                        label:
                            "With a InstaMeals subscription, it`s like getting a personal chef and dietitian all in one.",
                      ),
                      bulletPoints(context,
                          label: "The easiest way to eat healthy."),
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
                        label:
                            "Take our suggestions or choose exactly what you want",
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
                      space0(),

                      Obx((() => ListTile(
                            onTap: (() =>
                                buttonController.selectedPlan.value = 0),
                            tileColor:
                                (buttonController.selectedPlan.value == 0)
                                    ? CustomTheme.bgColor
                                    : CustomTheme.grey,
                            shape: customradius(),
                            leading: const FaIcon(
                              FontAwesomeIcons.bookmark,
                            ),
                            title: Text("9.99 USD",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: (buttonController
                                                  .selectedPlan.value ==
                                              0)
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                            subtitle: Text("Every Month",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: (buttonController
                                                  .selectedPlan.value ==
                                              0)
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                            trailing: Icon(
                              Icons.check_circle_outlined,
                              color: (buttonController.selectedPlan.value == 0)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ))),
                      space0(),
                      Obx(
                        (() => ListTile(
                              onTap: (() =>
                                  buttonController.selectedPlan.value = 1),
                              tileColor:
                                  (buttonController.selectedPlan.value == 1)
                                      ? CustomTheme.bgColor
                                      : CustomTheme.grey,
                              shape: customradius(),
                              leading: const FaIcon(
                                FontAwesomeIcons.bookmark,
                              ),
                              title: Text("99 USD",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: (buttonController
                                                    .selectedPlan.value ==
                                                1)
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                              subtitle: Text("Every 12 Month",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: (buttonController
                                                    .selectedPlan.value ==
                                                1)
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                              trailing: Icon(
                                Icons.check_circle_outlined,
                                color:
                                    (buttonController.selectedPlan.value == 1)
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            )),
                      ),
                      space0(),

                      InkWell(
                          onTap: () async {
                            // launchUrl(Uri.parse(
                            //     "https://buy.stripe.com/test_aEUdUPg3i2c6fAIdQQ"));
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (_) => CheckoutPage(),
                            // ));
                            // redirectToCheckout(context);
                            // redirectToCheckout(context);
                            // if (buttonController.selectedPlan.value == 0) {
                            //   launchUrl(Uri.parse(
                            //           "https://buy.stripe.com/test_aEUdUPg3i2c6fAIdQQ"))
                            //       .whenComplete(() {
                            //     box.erase();
                            //     // Fluttertoast.showToast(
                            //     //     msg: 'Successfully Logout');
                            //     Get.offAll(Login());
                            //   });
                            // } else {
                            //   launchUrl(Uri.parse(
                            //           "https://billing.stripe.com/p/login/test_cN2dSrf2ndLZ4YUeUU"))
                            //       .whenComplete(() {
                            //     box.erase();
                            //     // Fluttertoast.showToast(
                            //     //     msg: 'Successfully Logout');
                            //     Get.offAll(Login());
                            //   });
                            // }

                            //     .then((value) {
                            //   print("mioz");
                            //   print(value);
                            // }).whenComplete(() => print("moiaata"));
                            // fetchOffers();
                            makePayment(context);
                            // payLoader ? null : fetchOffers();
                            // try {
                            //   await Purchases.purchaseProduct('id_subs');
                            //   setState(() {
                            //     coins += 100;
                            //   });
                            // } catch (e) {
                            //   debugPrint(e.toString());
                            // }
                          },
                          child: customButton(context, Colors.white,
                              CustomTheme.bgColor, "Continue to Meal Plan")),
                      space0(),
                      // Text(
                      //   "Your iTunes account will be charged within 24 hours of the end of your trial period ending and within 24 hours of the end of the current term for each renewal, cancellation must happen at least 24 hours before the end of the period. Subscriptions may be managed and auto-renewal turned off by going to your iTunes Account Settings after purchase. Any unused portion of a free trial period will be forfeited if you purchase a subscription prior to that trial period ending",
                      //   style: Theme.of(context).textTheme.bodySmall.copyWith(
                      //         color: CustomTheme.bgColor,
                      //       ),
                      // ),
                      space0(),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(
                              "https://instamealplans.com/terms-conditions/"));
                        },
                        child: Text(
                          "By continuing, I agree to Terms and Conditions",
                          style: Theme.of(context).textTheme.bodySmall.copyWith(
                              color: CustomTheme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      space1(),
                    ]),
              )),
        ));
  }

  Future<void> makePayment(context) async {
    final buttonController = Get.put(ButtonController());

    // await launchUrl(
    //     Uri.parse('https://buy.stripe.com/test_9AQ5ojaIYbMG1JScMN'));
    print(buttonController.selectedPlan.value.toString());
    try {
      paymentIntentMonthly = await createPaymentIntent('9.99', 'USD');
      paymentIntentYearly = await createPaymentIntent('99', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: (buttonController.selectedPlan.value == 0)
              ? paymentIntentMonthly['client_secret']
              : paymentIntentYearly['client_secret'],
          allowsDelayedPaymentMethods: true,
          // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
          // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
          style: ThemeMode.dark,
          merchantDisplayName: 'Instameal',
        ),
      )
          .then((value) {
        print("moiz");
        // print(Stripe.instance.isApplePaySupported);
      });

      ///now finally display payment sheeet
      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomTheme.bgColor),
                          onPressed: () {
                            updatePayment(context);

                            Navigator.pop(context);
                          },
                          child: Text("Enjoy",
                              style: Theme.of(context).textTheme.headline6))
                    ],
                  ),
                ));
        print("succesful");
        paymentIntentMonthly = null;
        paymentIntentYearly = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        // 'trial_end': '1669680000',
        // 'trial_start': '1670889600'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': auth,
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  updatePayment(context) async {
    print("user id");
    print(box.read('userid').toString());
    // DateTime now = DateTime.now();
    final UniversalController universalController =
        Get.put(UniversalController());
    DateTime now =
        DateTime.parse(universalController.currentDate.value.toString());
    DateTime formatNow = DateTime.parse(DateFormat('yyyy-MM-dd').format(now));
    DateTime trialDate = now.add(Duration(days: 14));
    DateTime formatTrial =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(trialDate));

    final buttonController = Get.put(ButtonController());
    String url;
    // var payload;
    var response;
    if (buttonController.selectedPlan.value == 0) {
      DateTime subend = now.add(Duration(days: 30));
      DateTime formatSubEnd =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(subend));
      url =
          "${Constants.baseUrl}payment/SubStart/$formatNow/Subend/${formatSubEnd.toString()}/Membership/Monthly/Trial/${formatTrial.toString()}/PayStatus/Paid/Uid/${box.read('userid').toString()}";
      response = await Network.put(url: url).catchError(
        () {
          Fluttertoast.showToast(msg: "Server is not responding");
        },
      );
    } else if (buttonController.selectedPlan.value == 1) {
      DateTime subend = now.add(Duration(days: 365));
      DateTime formatSubEnd =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(subend));
      url =
          "${Constants.baseUrl}payment/SubStart/$formatNow/Subend/${formatSubEnd.toString()}/Membership/Yearly/Trial/${formatTrial.toString()}/PayStatus/Paid/Uid/${box.read('userid').toString()}";

      response = await Network.put(url: url).catchError(
        () {
          Fluttertoast.showToast(msg: "Server is not responding");
        },
      );
    }

    print(response);
    if (response != null && response.contains("true")) {
      Fluttertoast.showToast(msg: "Successfully Subscribed");
      Constants.navigatepushreplac(context, Login());
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();
    if (offerings.isEmpty) {
      Fluttertoast.showToast(msg: 'No package');
      print("no package");
    } else {
      final packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((element) => element)
          .toList();
      BottomSheet(
        onClosing: (() {}),
        builder: (context) => Paywall(offering: offerings),
      );
    }
  }
}
