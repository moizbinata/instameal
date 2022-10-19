import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instameal/views/subscription/payment_screen.dart';

import '../../components/components.dart';
import '../../controllers/buttonController.dart';
import '../../utils/sizeconfig.dart';
import '../../utils/theme.dart';
import 'package:http/http.dart' as http;

class TrialScreen extends StatelessWidget {
  TrialScreen({Key key}) : super(key: key);
  Map<String, dynamic> paymentIntent;

  @override
  Widget build(BuildContext context) {
    final buttonController = Get.put(ButtonController());

    return Scaffold(
        backgroundColor: CustomTheme.bgColor2,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: CustomTheme.bgColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Pay 0 USD today - 14 Day free trial.",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: CustomTheme.bgColor),
                    ),
                    bulletPoints(context,
                        label: "Every day solutions for healthy, home cooked."),
                    bulletPoints(
                      context,
                      label:
                          "Unlimited switching between all of our meal plans.",
                    ),
                    bulletPoints(context,
                        label: "Upto 50% savings per saving vs Blue Apron."),
                    bulletPoints(
                      context,
                      label: "Optionally send your shopping list to instacart.",
                    ),
                    Obx((() => ListTile(
                          onTap: (() =>
                              buttonController.selectedPlan.value = 0),
                          tileColor: (buttonController.selectedPlan == 0)
                              ? CustomTheme.bgColor
                              : CustomTheme.grey,
                          shape: customradius(),
                          leading: const FaIcon(
                            FontAwesomeIcons.bookmark,
                          ),
                          title: Text("3150 USD",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color: (buttonController.selectedPlan == 0)
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                          subtitle: Text("Every Month",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: (buttonController.selectedPlan == 0)
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                          trailing: Icon(
                            Icons.check_circle_outlined,
                            color: (buttonController.selectedPlan == 0)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ))),
                    Obx(
                      (() => ListTile(
                            onTap: (() =>
                                buttonController.selectedPlan.value = 1),
                            tileColor: (buttonController.selectedPlan == 1)
                                ? CustomTheme.bgColor
                                : CustomTheme.grey,
                            shape: customradius(),
                            leading: const FaIcon(
                              FontAwesomeIcons.bookmark,
                            ),
                            title: Text("6300 USD",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color:
                                          (buttonController.selectedPlan == 1)
                                              ? Colors.white
                                              : Colors.black,
                                    )),
                            subtitle: Text("Every 12 Month",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color:
                                          (buttonController.selectedPlan == 1)
                                              ? Colors.white
                                              : Colors.black,
                                    )),
                            trailing: Icon(
                              Icons.check_circle_outlined,
                              color: (buttonController.selectedPlan == 1)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )),
                    ),
                    InkWell(
                        onTap: () async {
                          await makePayment(context);
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
        ));
  }

  Future<void> makePayment(context) async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {
        print("moiz");
        print(Stripe.instance.isApplePaySupported);
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
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
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
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51LrfHXLDjGMiS5VVWaaQxctmXOqT7vAa0kEEIhq3cAEjynRrQ9ZNrYTZddG83XBNakq4drdtYVjDDN61dRuc1IaM00mQ2rKfDM',
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
}
