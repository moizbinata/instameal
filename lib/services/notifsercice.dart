import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/notifmodel.dart';
import 'package:instameal/models/videomodel.dart';

import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/network.dart';

import '../models/loginmodel.dart';

class NotifService {
  static Future<NotifModel> fetchNotif(id) async {
    String url = "${Constants.baseUrl}specificnotif$id";
    // var payload = {"userid": box.read("userid").toString()};
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      return NotifModel.fromJson(jsonString);
    } else {
      return null;
    }
  }

  Future<bool> checkExpiry() async {
    print("checking expiry status");
    GetStorage box = GetStorage();

    var email = box.read('email');
    String url = "${Constants.baseUrl}checkExpiry/Email/$email";

    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      var loginModel = LoginModel.fromJson(jsonString);
      if (loginModel.data[0].subscriptionStart != "NOID") {
        return false;
      } else {
        return true;
      }
    }
  }

  static Future<VModel> fetchVideos() async {
    String url = "${Constants.baseUrl}video";
    // var payload = {"userid": box.read("userid").toString()};
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      return VModel.fromJson(jsonString);
    } else {
      return null;
    }
  }
}
