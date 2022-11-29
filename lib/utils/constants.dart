import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../views/subscription/trial_screen.dart';

class Constants {
  // static final baseUrl = "http://192.168.18.168:3000/";
  // static final baseImageUrl = "http://192.168.18.168:3000/assets/";
  static final baseUrl = "https://paaocenter.com/";
  static final baseImageUrl = "https://paaocenter.com/assets/";
  static Future navigatepush(context, screen) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
        isIos: true,
        duration: Duration(milliseconds: 400),
      ),
    );
  }

  static Future navigatepushreplac(context, screen) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
        isIos: true,
        duration: Duration(milliseconds: 400),
      ),
    );
  }
}
