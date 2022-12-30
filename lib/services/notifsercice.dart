import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:instameal/models/notifmodel.dart';
import 'package:instameal/models/videomodel.dart';

import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/network.dart';

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
