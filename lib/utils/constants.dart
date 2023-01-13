import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/navigation/bottom_navigator.dart';
import 'package:instameal/utils/network.dart';
import 'package:page_transition/page_transition.dart';

import '../models/loginmodel.dart';

class Constants {
  static final baseUrl = "https://instanode.otdownloads.com/";
  static final baseImageUrl = "https://instanode.otdownloads.com/assets/";
  static final baseVideoUrl =
      "https://instanode.otdownloads.com/assets/videos/";
  static final colorList = [
    Color(0xff9fd6e5),
    Color(0xfffdd47d),
    Color(0xff8b82d0),
    Color(0xffde9b12),
  ];
  static final categList = [
    "Breakfast",
    "Lunch",
    "Snacks",
    "Dinner",
  ];
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
