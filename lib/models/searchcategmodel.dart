// To parse this JSON data, do
//
//     final searchCategModel = searchCategModelFromJson(jsonString);

import 'dart:convert';

SearchCategModel searchCategModelFromJson(String str) =>
    SearchCategModel.fromJson(json.decode(str));

String searchCategModelToJson(SearchCategModel data) =>
    json.encode(data.toJson());

class SearchCategModel {
  SearchCategModel({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  List<SCategModel> data;
  String error;

  factory SearchCategModel.fromJson(Map<String, dynamic> json) =>
      SearchCategModel(
        success: json["success"],
        data: List<SCategModel>.from(
            json["data"].map((x) => SCategModel.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class SCategModel {
  SCategModel({
    this.searchcategid,
    this.searchcategname,
    this.scategimg,
  });

  int searchcategid;
  String searchcategname;
  String scategimg;

  factory SCategModel.fromJson(Map<String, dynamic> json) => SCategModel(
        searchcategid: json["searchcategid"],
        searchcategname: json["searchcategname"],
        scategimg: json["scategimg"],
      );

  Map<String, dynamic> toJson() => {
        "searchcategid": searchcategid,
        "searchcategname": searchcategname,
        "scategimg": scategimg,
      };
}
