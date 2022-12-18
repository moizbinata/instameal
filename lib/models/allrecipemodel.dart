// To parse this JSON data, do
//
//     final aRecipeModels = aRecipeModelsFromJson(jsonString);

import 'dart:convert';

ARecipeModels aRecipeModelsFromJson(String str) =>
    ARecipeModels.fromJson(json.decode(str));

String aRecipeModelsToJson(ARecipeModels data) => json.encode(data.toJson());

class ARecipeModels {
  ARecipeModels({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  List<AllRecipeModel> data;
  String error;

  factory ARecipeModels.fromJson(Map<String, dynamic> json) => ARecipeModels(
        success: json["success"],
        data: List<AllRecipeModel>.from(
            json["data"].map((x) => AllRecipeModel.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class AllRecipeModel {
  AllRecipeModel({
    this.recipeid,
    this.recipeName,
    this.whatYouNeed,
    this.direction,
    this.nutritPerServe,
    this.imagesUrl,
    this.serving,
    this.prepTime,
    this.cookTime,
    this.keys,
    this.categId,
    this.planId,
    this.items,
    this.planName,
    this.categName,
  });

  int recipeid;
  String recipeName;
  List<String> whatYouNeed;
  List<String> direction;
  List<String> nutritPerServe;
  String imagesUrl;
  int serving;
  String prepTime;
  String cookTime;
  List<String> keys;
  int categId;
  int planId;
  List<String> items;
  String planName;
  String categName;

  factory AllRecipeModel.fromJson(Map<String, dynamic> json) => AllRecipeModel(
        recipeid: json["recipeid"],
        recipeName: json["recipeName"],
        whatYouNeed: json["whatYouNeed"] != null
            ? json['whatYouNeed'].toString().split('***').toList()
            : [],
        direction: json["direction"] != null
            ? json['direction'].toString().split('***').toList()
            : [],
        nutritPerServe: json["nutritPerServe"] != null
            ? json['nutritPerServe'].toString().split('***').toList()
            : [],
        imagesUrl: json["imagesUrl"],
        serving: json["serving"],
        prepTime: json["prepTime"],
        cookTime: json["cookTime"],
        keys: json["keys"] != null
            ? json['keys'].toString().split('***').toList()
            : [],
        categId: json["categId"],
        planId: json["planId"],
        items: json["items"] != null
            ? json['items'].toString().split('***').toList()
            : [],
        planName: json["planName"],
        categName: json["categName"],
      );
  factory AllRecipeModel.fromMap(Map map) {
    return AllRecipeModel(
      recipeid: map["recipeid"],
      recipeName: map["recipeName"],
      whatYouNeed: map["whatYouNeed"] != null
          ? map['whatYouNeed'].toString().split('***').toList()
          : [],
      direction: map["direction"] != null
          ? map['direction'].toString().split('***').toList()
          : [],
      nutritPerServe: map["nutritPerServe"] != null
          ? map['nutritPerServe'].toString().split('***').toList()
          : [],
      imagesUrl: map["imagesUrl"],
      serving: map["serving"],
      prepTime: map["prepTime"],
      cookTime: map["cookTime"],
      keys: map["keys"] != null
          ? map['keys'].toString().split('***').toList()
          : [],
      categId: map["categId"],
      planId: map["planId"],
      items: map["items"] != null
          ? map['items'].toString().split('***').toList()
          : [],
      planName: map["planName"],
      categName: map["categName"],
    );
  }
  Map<String, dynamic> toJson() => {
        "recipeid": recipeid,
        "recipeName": recipeName,
        "whatYouNeed": whatYouNeed,
        "direction": direction,
        "nutritPerServe": nutritPerServe,
        "imagesUrl": imagesUrl,
        "serving": serving,
        "prepTime": prepTime,
        "cookTime": cookTime,
        "keys": keys,
        "categId": categId,
        "planId": planId,
        "items": items,
        "planName": planName,
        "categName": categName,
      };
}
