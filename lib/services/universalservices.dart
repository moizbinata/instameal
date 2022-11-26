import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/images_model.dart';
import 'package:instameal/models/planmodel.dart';

import '../models/universal_model.dart';
import '../models/weekly_model.dart';
import '../utils/constants.dart';
import '../utils/network.dart';

class UniversalService {
  static Future<UniversalModel> fetchUniversal() async {
    String url = "${Constants.baseUrl}home";
    // var payload = {"userid": box.read("userid").toString()};
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      return UniversalModel.fromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<PlansModel> fetchPlans() async {
    String url = "${Constants.baseUrl}plans";
    // var payload = {"userid": box.read("userid").toString()};
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      return PlansModel.fromJson(jsonString);
    } else {
      return null;
    }
  }
}
