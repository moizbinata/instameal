// To parse this JSON data, do
//
//     final plansModel = plansModelFromJson(jsonString);

import 'dart:convert';

PlansModel plansModelFromJson(String str) =>
    PlansModel.fromJson(json.decode(str));

String plansModelToJson(PlansModel data) => json.encode(data.toJson());

class PlansModel {
  PlansModel({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  List<PModel> data;
  String error;

  factory PlansModel.fromJson(Map<String, dynamic> json) => PlansModel(
        success: json["success"],
        data: List<PModel>.from(json["data"].map((x) => PModel.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class PModel {
  PModel({
    this.planId,
    this.planName,
  });

  int planId;
  String planName;

  factory PModel.fromJson(Map<String, dynamic> json) => PModel(
        planId: json["planId"],
        planName: json["planName"],
      );

  Map<String, dynamic> toJson() => {
        "planId": planId,
        "planName": planName,
      };
}
