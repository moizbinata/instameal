import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:instameal/models/notifmodel.dart';

import '../utils/constants.dart';
import '../utils/network.dart';

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
}
