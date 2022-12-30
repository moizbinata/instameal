import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instameal/models/images_model.dart';

import 'package:instameal/models/searchcategmodel.dart';
import 'package:instameal/models/searchcategrecipemodel.dart';
import 'package:instameal/models/universal_model.dart';
import 'package:instameal/models/weekly_model.dart';
import 'package:instameal/utils/constants.dart';
import 'package:instameal/utils/network.dart';
import 'package:http/http.dart' as http;

class SCRServices {
  static Future<SearchCategRecipeModel> fetchSearchCategRecipe() async {
    var client = http.Client();
    String url = "${Constants.baseUrl}getsearchcategrecipe";
    print(url);
    var response = await client.get(
      Uri.parse(url),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
            "true", // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.body.toString());
      return SearchCategRecipeModel.fromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<SearchCategModel> fetchSearchCateg() async {
    var client = http.Client();
    String url = "${Constants.baseUrl}getsearchcateg";
    print(url);
    var response = await client.get(
      Uri.parse(url),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
            "true", // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );
    if (response != null) {
      var jsonString = jsonDecode(response.body.toString());
      return SearchCategModel.fromJson(jsonString);
    } else {
      return null;
    }
  }
}
