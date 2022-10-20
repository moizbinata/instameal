import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../models/weekly_model.dart';
import '../utils/constants.dart';
import '../utils/network.dart';

class WeeklyService {
  // static var client = http.Client();

  static Future<WeeklyModel> fetchWeekly() async {
    String url = "${Constants.baseUrl}weekly";
    // var payload = {"userid": box.read("userid").toString()};
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      return WeeklyModel.fromJson(jsonString);
    } else {
      return null;
    }
  }
}
