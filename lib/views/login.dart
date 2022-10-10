import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/subscription/subscription.dart';

import '../components/components.dart';
import '../utils/sizeconfig.dart';

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);
  //login
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //signup
  TextEditingController usernameController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              space0(),
              Image.asset("assets/images/logo.png",
                  height: SizeConfig.heightMultiplier * 20),
              space0(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ))
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => BottomNavigator());
                                },
                                child: customButton(context, Colors.white,
                                    CustomTheme.bgColor, "Login")),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
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
                                )
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => Subscribe());
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
}
