// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:instameal/components/components.dart';
// import 'package:instameal/views/subscription/trial_screen.dart';
// import 'package:http/http.dart' as http;

// import '../../utils/sizeconfig.dart';
// import '../../utils/theme.dart';

// class PayScreen extends StatelessWidget {
//   PayScreen({Key key}) : super(key: key);
//   Map<String, dynamic> paymentIntent;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: CustomTheme.bgColor2,
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const FaIcon(
//               FontAwesomeIcons.chevronLeft,
//               color: CustomTheme.bgColor,
//             ),
//           ),
//         ),
//         body: Padding(
//             padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text("Card Form"),
//                   // CardFormField(
//                   //   controller: CardFormEditController(),
//                   // ),
//                   InkWell(
//                       onTap: () async {
//                         await makePayment(context);
//                         // to(() => Subscribe());
//                       },
//                       child: customButton(context, Colors.white,
//                           CustomTheme.bgColor, "Continue to Meal Plan")),
//                 ])));
//   }

//   Future<void> makePayment(context) async {
//     try {
//       paymentIntent = await createPaymentIntent('10', 'USD');
//       //Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   paymentIntentClientSecret: paymentIntent['client_secret'],
//                   // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
//                   // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
//                   style: ThemeMode.dark,
//                   merchantDisplayName: 'Adnan'))
//           .then((value) {});

//       ///now finally display payment sheeet
//       displayPaymentSheet(context);
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }

//   displayPaymentSheet(context) async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) {
//         showDialog(
//             context: context,
//             builder: (_) => AlertDialog(
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: const [
//                           Icon(
//                             Icons.check_circle,
//                             color: Colors.green,
//                           ),
//                           Text("Payment Successfull"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ));
//         // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

//         paymentIntent = null;
//       }).onError((error, stackTrace) {
//         print('Error is:--->$error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Error is:---> $e');
//       showDialog(
//           context: context,
//           builder: (_) => const AlertDialog(
//                 content: Text("Cancelled "),
//               ));
//     } catch (e) {
//       print('$e');
//     }
//   }

//   //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };

//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51LrfHXLDjGMiS5VVWaaQxctmXOqT7vAa0kEEIhq3cAEjynRrQ9ZNrYTZddG83XBNakq4drdtYVjDDN61dRuc1IaM00mQ2rKfDM',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       // ignore: avoid_print
//       print('Payment Intent Body->>> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       // ignore: avoid_print
//       print('err charging user: ${err.toString()}');
//     }
//   }

//   calculateAmount(String amount) {
//     final calculatedAmout = (int.parse(amount)) * 100;
//     return calculatedAmout.toString();
//   }

// }
