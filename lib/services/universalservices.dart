import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/allrecipemodel.dart';
import 'package:instameal/models/images_model.dart';
import 'package:instameal/models/planmodel.dart';

import 'package:instameal/models/universal_model.dart';
import 'package:instameal/models/weekly_model.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/network.dart';

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

  static Future<ARecipeModels> fetchAllRecipes() async {
    String url = "${Constants.baseUrl}recipes";
    // var payload = {"userid": box.read("userid").toString()};
    var response = await Network.get(url: url).catchError(
      () {
        Fluttertoast.showToast(msg: "Server is not responding");
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.toString());
      return ARecipeModels.fromJson(jsonString);
    } else {
      return null;
    }
  }
}
