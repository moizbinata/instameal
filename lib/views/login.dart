import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/subscription/subscription.dart';
import 'package:instameal/views/subscription/trial_screen.dart';

import '../components/components.dart';
import '../controllers/universalController.dart';
import '../models/loginmodel.dart';
import '../utils/network.dart';
import '../utils/sizeconfig.dart';

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);
  //login
  TextEditingController usernameController =
      TextEditingController(text: 'decrs@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'abc123');
  //signup
  TextEditingController usernameController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final universalController = Get.put(UniversalController());

    return Scaffold(
      backgroundColor: CustomTheme.bgColor2,
      body: SafeArea(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 3),
          // height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              space2(),
              Image.asset(
                "assets/images/logo.png",
                height: SizeConfig.heightMultiplier * 13,
                fit: BoxFit.contain,
              ),
              space3(),
              DefaultTabController(
                length: 2,
                child: Column(children: [
                  Container(
                    child: TabBar(
                      indicatorColor: CustomTheme.bgColor,
                      tabs: [
                        Tab(
                          child: Text(
                            "Login",
                            style:
                                Theme.of(context).textTheme.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Sign-up",
                            style:
                                Theme.of(context).textTheme.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //Add this to give height
                    height: SizeConfig.screenHeight * 0.6,
                    child: TabBarView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customField(usernameController, "Email address",
                                icon: Icons.mail),
                            space1(),
                            customField(passwordController, "Password",
                                icon: Icons.lock),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: CustomTheme.bgColor),
                                )),
                            space1(),
                            InkWell(
                              onTap: () {
                                GetStorage box = GetStorage();
                                box.write('plantype', "Plant-Based");
                                box.write('planId', "3");
                                universalController.mart.value = 'shipt';
                                box.write('mart', 'shipt');
                                box.write('amazonfresh',
                                    'https://www.amazon.com/s?k=');
                                box.write('walmart',
                                    'https://www.walmart.com/search?q=');
                                box.write('instacart',
                                    'https://www.instacart.com/store/s?k=');
                                box.write('kroger',
                                    'https: //kroger.com/search?query=');
                                loginService(context);
                              },
                              child: customButton(context, Colors.white,
                                  CustomTheme.bgColor, "Login"),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customField(usernameController2, "Username",
                                icon: Icons.account_circle),
                            space0(),
                            customField(emailController, "Email",
                                icon: Icons.mail),
                            space0(),
                            customField(password1Controller, "Password",
                                icon: Icons.lock),
                            space0(),
                            customField(
                              password2Controller,
                              "Confirm Password",
                              icon: Icons.lock,
                            ),
                            space2(),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TrialScreen()));
                                },
                                child: customButton(
                                    context,
                                    Colors.white,
                                    CustomTheme.bgColor,
                                    "Continue to Meal Plan")),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // space3(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginService(context) async {
    GetStorage box = GetStorage();
    String url =
        "${Constants.baseUrl}login/Email/${usernameController.text.toString()}/Password/${passwordController.text.toString()}";
    // var payload = {"userid": box.read("userid").toString()};

    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    print(url);
    print(response.toString());
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      var loginModel = LoginModel.fromJson(jsonString);
      if (loginModel != null && loginModel.data.isNotEmpty) {
        Fluttertoast.showToast(msg: "Login Successfully");
        box.write('userid', loginModel.data[0].userid);
        box.write('username', loginModel.data[0].username);
        box.write('email', loginModel.data[0].email);
        box.write('subscriptionStart', loginModel.data[0].subscriptionStart);
        box.write('subscriptionEnd', loginModel.data[0].subscriptionEnd);
        box.write('membershipType', loginModel.data[0].membershipType);
        box.write('trialStatus', loginModel.data[0].trialStatus);
        box.write('paymentStatus', loginModel.data[0].paymentStatus);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigator(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Incorrect Credentials");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
