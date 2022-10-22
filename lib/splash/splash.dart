import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instameal/utils/theme.dart';
import 'package:instameal/views/intro/intro.dart';
import 'package:instameal/views/login.dart';
import '../components/components.dart';
import '../utils/sizeconfig.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomTheme.bgColor,
        body: Container(
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
                // Container(
                //   width: SizeConfig.screenWidth * 0.5,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(100)),
                //   child: Image.asset('assets/images/logo.png',
                //       width: SizeConfig.screenWidth * 0.2),
                // ),
                Image.asset(
                  "assets/images/splash.png",
                  width: SizeConfig.heightMultiplier * 20,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomeIntro()));
                      // Get.to(() => const HomeIntro());
                    },
                    child: customButton(context, CustomTheme.bgColor,
                        Colors.white, "Get Started")),
              ],
            ),
          ),
        ));
  }
}
