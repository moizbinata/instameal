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
    this.recipeId,
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

  int recipeId;
  String recipeName;
  String whatYouNeed;
  String direction;
  String nutritPerServe;
  String imagesUrl;
  int serving;
  String prepTime;
  String cookTime;
  String keys;
  int categId;
  int planId;
  String items;
  String planName;
  String categName;

  factory AllRecipeModel.fromJson(Map<String, dynamic> json) => AllRecipeModel(
        recipeId: json["recipeId"],
        recipeName: json["recipeName"],
        whatYouNeed: json["whatYouNeed"],
        direction: json["direction"],
        nutritPerServe: json["nutritPerServe"],
        imagesUrl: json["imagesUrl"],
        serving: json["serving"],
        prepTime: json["prepTime"],
        cookTime: json["cookTime"],
        keys: json["keys"],
        categId: json["categId"],
        planId: json["planId"],
        items: json["items"],
        planName: json["planName"],
        categName: json["categName"],
      );

  Map<String, dynamic> toJson() => {
        "recipeId": recipeId,
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
