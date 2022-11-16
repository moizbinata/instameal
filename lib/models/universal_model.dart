// To parse this JSON data, do
//
//     final universalModel = universalModelFromJson(jsonString);

import 'dart:convert';

UniversalModel universalModelFromJson(String str) =>
    UniversalModel.fromJson(json.decode(str));

String universalModelToJson(UniversalModel data) => json.encode(data.toJson());

class UniversalModel {
  UniversalModel({
    this.success,
    this.fav,
    this.festival,
    this.collection,
    this.dessert,
    this.error,
  });

  bool success;
  List<List<Collection>> fav;
  List<List<Collection>> festival;
  List<List<Collection>> collection;
  List<List<Collection>> dessert;
  String error;

  factory UniversalModel.fromJson(Map<String, dynamic> json) => UniversalModel(
        success: json["success"],
        fav: List<List<Collection>>.from(json["fav"].map((x) =>
            List<Collection>.from(x.map((x) => Collection.fromJson(x))))),
        festival: List<List<Collection>>.from(json["festival"].map((x) =>
            List<Collection>.from(x.map((x) => Collection.fromJson(x))))),
        collection: List<List<Collection>>.from(json["collection"].map((x) =>
            List<Collection>.from(x.map((x) => Collection.fromJson(x))))),
        dessert: List<List<Collection>>.from(json["dessert"].map((x) =>
            List<Collection>.from(x.map((x) => Collection.fromJson(x))))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "fav": List<dynamic>.from(
            fav.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "festival": List<dynamic>.from(
            festival.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "collection": List<dynamic>.from(collection
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "dessert": List<dynamic>.from(
            dessert.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "error": error,
      };
}

class Collection {
  Collection({
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
    this.categName,
    this.planName,
    this.userid,
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
  String categName;
  String planName;
  int userid;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
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
        categName: json["categName"],
        planName: json["planName"],
        userid: json["userid"] == null ? null : json["userid"],
      );

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
        "categName": categName,
        "planName": planName,
        "userid": userid == null ? null : userid,
      };
}
