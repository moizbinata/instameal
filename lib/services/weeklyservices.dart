import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/images_model.dart';

import 'package:instameal/models/weekly_model.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/network.dart';

class WeeklyService {
  // static var client = http.Client();
  static Future<WeeklyModel> fetchWeeklyRecipes(plan, week) async {
    String url = "${Constants.baseUrl}weeklyplanrecipe$plan&$week";
    print(url);
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response);
      print(response);
      return WeeklyModel.fromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<ImagesModel> fetchWeeklyImages() async {
    GetStorage box = GetStorage();
    String url = "${Constants.baseUrl}image${box.read('plantype').toString()}";
    print(url);
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      return ImagesModel.fromJson(jsonString);
    } else {
      return null;
    }
  }
}
