// To parse this JSON data, do
//
//     final searchCategRecipeModel = searchCategRecipeModelFromJson(jsonString);

import 'dart:convert';

SearchCategRecipeModel searchCategRecipeModelFromJson(String str) =>
    SearchCategRecipeModel.fromJson(json.decode(str));

String searchCategRecipeModelToJson(SearchCategRecipeModel data) =>
    json.encode(data.toJson());

class SearchCategRecipeModel {
  SearchCategRecipeModel({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  List<SCRecipeModel> data;
  String error;

  factory SearchCategRecipeModel.fromJson(Map<String, dynamic> json) =>
      SearchCategRecipeModel(
        success: json["success"],
        data: List<SCRecipeModel>.from(
            json["data"].map((x) => SCRecipeModel.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class SCRecipeModel {
  SCRecipeModel({
    this.id,
    this.searchcategname,
    this.searchcategid,
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
    this.categName,
    this.planId,
    this.planName,
    this.items,
  });

  int id;
  String searchcategname;
  int searchcategid;
  int recipeId;
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
  String categName;
  int planId;
  String planName;
  String items;

  factory SCRecipeModel.fromJson(Map<String, dynamic> json) => SCRecipeModel(
        id: json["id"],
        searchcategname: json["searchcategname"],
        searchcategid: json["searchcategid"],
        recipeId: json["recipeId"],
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
        categName: json["categName"] ?? "",
        planId: json["planId"],
        planName: json["planName"] ?? "",
        items: json["items"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "searchcategname": searchcategname,
        "searchcategid": searchcategid,
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
        "categName": categName ?? "",
        "planId": planId,
        "planName": planName ?? "",
        "items": items,
      };
}
