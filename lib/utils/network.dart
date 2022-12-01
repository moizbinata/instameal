import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  static var client = http.Client();

  static get({url, headers}) async {
    try {
      Map<String, String> apiHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if (headers != null) {
        apiHeaders.addAll(headers);
      }
      var response = await client
          .get(Uri.parse(url), headers: apiHeaders)
          .timeout(Duration(seconds: 50));
      // print("Response:>>>>>>>>>>>> ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
        // return json.decode(response.body);
      }
      if (response.statusCode < 200 ||
          response.statusCode > 400 ||
          json == null) {
        return response.body;
      }
    } catch (e) {
      debugPrint("GET: $e");
      return throw Exception(e);
    }

    // if(response.statusCode != 403) {
    //   return json.decode(response.body);
    // } else {
    //   return null;
    // }
  }

  static post({url, payload, headers}) async {
    try {
      Map<String, String> apiHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if (headers != null) {
        apiHeaders.addAll(headers);
      }
      var body = json.encode(payload);
      debugPrint(url);
      var response =
          await client.post(Uri.parse(url), body: body, headers: apiHeaders);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.body;
        // return json.decode(response.body);
      }
      if (response.statusCode == 201) {
        return "Username or Email already exist";
      } else if (response.statusCode < 200 ||
          response.statusCode > 400 ||
          json == null) {
        // return json.decode(response.body);
        return response.body;
        // return json.decode(response.body);
      }
    } catch (e) {
      debugPrint("POST: $e");
      return throw Exception(e);
    }
  }

  static put({url, payload, headers}) async {
    try {
      Map<String, String> apiHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if (headers != null) {
        apiHeaders.addAll(headers);
      }
      var body = json.encode(payload);
      debugPrint(url);
      var response = await client.put(Uri.parse(url), headers: apiHeaders);
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.body;
        // return json.decode(response.body);
      } else if (response.statusCode < 200 ||
          response.statusCode > 400 ||
          json == null) {
        // return json.decode(response.body);
        return response.body;
        // return json.decode(response.body);
      }
    } catch (e) {
      debugPrint("POST: $e");
      return throw Exception(e);
    }
  }
}
