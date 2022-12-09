import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../components/components.dart';
import '../../controllers/buttonController.dart';
import '../../utils/constants.dart';
import '../../utils/network.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import 'package:http/http.dart' as http;
import '../login.dart';

class TrialScreen extends StatefulWidget {
  TrialScreen({Key key}) : super(key: key);

  @override
  State<TrialScreen> createState() => _TrialScreenState();
}

class _TrialScreenState extends State<TrialScreen> {
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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
                height: SizeConfig.screenHeight,
                padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
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
                      Icon(isSubscriberd ? Icons.paid : Icons.lock),
                      Text(coins.toString()),
                      Text(
                        "Signup and enjoy free 14 days more",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: CustomTheme.bgColor),
                      ),
                      bulletPoints(context,
                          label: "More Than Just a Meal Plan."),
                      bulletPoints(
                        context,
                        label:
                            "With a InstaMeals subscription, it`s like getting a personal chef and dietitian all in one.",
                      ),
                      bulletPoints(context,
                          label: "Upto 50% savings per saving vs Blue Apron."),
                      bulletPoints(
                        context,
                        label:
                            "Optionally send your shopping list to instacart.",
                      ),
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
                            title: Text("20 USD",
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
                              title: Text("198 USD",
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
                      InkWell(
                          onTap: () async {
                            payLoader ? null : fetchOffers();
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
                      Text(
                        "Your iTunes account will be charged within 24 hours of the end of your trial period ending and within 24 hours of the end of the current term for each renewal, cancellation must happen at least 24 hours before the end of the period. Subscriptions may be managed and auto-renewal turned off by going to your iTunes Account Settings after purchase. Any unused portion of a free trial period will be forfeited if you purchase a subscription prior to that trial period ending",
                        style: Theme.of(context).textTheme.bodySmall.copyWith(
                              color: CustomTheme.bgColor,
                            ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "By continuing, I agree to Terms and Conditions",
                          style: Theme.of(context).textTheme.bodySmall.copyWith(
                              color: CustomTheme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                    ])),
          ),
        ));
  }

  fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();
    if (offerings.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No plans found')));
    } else {
      final packages = offerings
          .map((e) => e.availablePackages)
          .expand((element) => element)
          .toList();
      Fluttertoast.showToast(
          msg: "Upgrade your plan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> makePayment(context) async {
    final buttonController = Get.put(ButtonController());

    // await launchUrl(
    //     Uri.parse('https://buy.stripe.com/test_9AQ5ojaIYbMG1JScMN'));
    print(buttonController.selectedPlan.value.toString());
    try {
      paymentIntentMonthly = await createPaymentIntent('20', 'USD');
      paymentIntentYearly = await createPaymentIntent('198', 'USD');
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
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Enjoy",
                              style: Theme.of(context).textTheme.headline6))
                    ],
                  ),
                ));
        print("succesful");
        updatePayment(context);
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
          'Authorization':
              'Bearer sk_test_51M5RsSAWiGvBL24rh6iQCT9UiPDQi4QSbAYRSrgPSZCGS5O5SQivNZmD7BlmJtR3tmaaODMhogmvVYiSlMErL1GO00LE6F5ubi',
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
    DateTime now = DateTime.now();
    DateTime formatNow = DateTime.parse(DateFormat('yyyy-MM-dd').format(now));
    DateTime trialDate = DateTime.now().add(Duration(days: 14));
    DateTime formatTrial =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(trialDate));

    final buttonController = Get.put(ButtonController());
    String url;
    // var payload;
    var response;
    if (buttonController.selectedPlan.value == 0) {
      DateTime subend = DateTime.now().add(Duration(days: 44));
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
      DateTime subend = DateTime.now().add(Duration(days: 379));
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
}

class PurchaseApi {
  static const _apiKey = '';
  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await PurchasesConfiguration(_apiKey);
  }

  static Future<List<Offering>> fetchOffers() async {
    final offerings = await Purchases.getOfferings();
    final current = offerings.current;
    return current == null ? [] : [current];
  }
}
