// To parse this JSON data, do
//
//     final weeklyModel = weeklyModelFromJson(jsonString);

import 'dart:convert';

WeeklyModel weeklyModelFromJson(String str) =>
    WeeklyModel.fromJson(json.decode(str));

String weeklyModelToJson(WeeklyModel data) => json.encode(data.toJson());

class WeeklyModel {
  WeeklyModel({
    this.success,
    this.breakfast,
    this.lunch,
    this.snack,
    this.dinner,
    this.error,
  });

  bool success;
  List<List<Breakfast>> breakfast;
  List<List<Breakfast>> lunch;
  List<List<Breakfast>> snack;
  List<List<Breakfast>> dinner;
  String error;

  factory WeeklyModel.fromJson(Map<String, dynamic> json) => WeeklyModel(
        success: json["success"],
        breakfast: List<List<Breakfast>>.from(json["breakfast"].map(
            (x) => List<Breakfast>.from(x.map((x) => Breakfast.fromJson(x))))),
        lunch: List<List<Breakfast>>.from(json["lunch"].map(
            (x) => List<Breakfast>.from(x.map((x) => Breakfast.fromJson(x))))),
        snack: List<List<Breakfast>>.from(json["snack"].map(
            (x) => List<Breakfast>.from(x.map((x) => Breakfast.fromJson(x))))),
        dinner: List<List<Breakfast>>.from(json["dinner"].map(
            (x) => List<Breakfast>.from(x.map((x) => Breakfast.fromJson(x))))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "breakfast": List<dynamic>.from(
            breakfast.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "lunch": List<dynamic>.from(
            lunch.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "snack": List<dynamic>.from(
            snack.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "dinner": List<dynamic>.from(
            dinner.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "error": error,
      };
}

class Breakfast {
  Breakfast({
    this.recipeid,
    this.day,
    this.weeknumber,
    this.categoryId,
    this.planId,
    this.recipeName,
    this.whatYouNeed,
    this.direction,
    this.nutritPerServe,
    this.imagesUrl,
    this.serving,
    this.prepTime,
    this.cookTime,
    this.keys,
    this.categname,
    this.planname,
  });

  int recipeid;
  int day;
  int weeknumber;
  int categoryId;
  int planId;
  String recipeName;
  String whatYouNeed;
  String direction;
  String nutritPerServe;
  String imagesUrl;
  int serving;
  String prepTime;
  String cookTime;
  String keys;
  String categname;
  String planname;

  factory Breakfast.fromJson(Map<String, dynamic> json) => Breakfast(
        recipeid: json["recipeid"],
        day: json["day"],
        weeknumber: json["weeknumber"],
        categoryId: json["categoryId"],
        planId: json["planId"],
        recipeName: json["recipeName"],
        whatYouNeed: json["whatYouNeed"],
        direction: json["direction"],
        nutritPerServe: json["nutritPerServe"],
        imagesUrl: json["imagesUrl"],
        serving: json["serving"],
        prepTime: json["prepTime"],
        cookTime: json["cookTime"],
        keys: json["keys"],
        categname: json["categname"],
        planname: json["planname"],
      );

  Map<String, dynamic> toJson() => {
        "recipeid": recipeid,
        "day": day,
        "weeknumber": weeknumber,
        "categoryId": categoryId,
        "planId": planId,
        "recipeName": recipeName,
        "whatYouNeed": whatYouNeed,
        "direction": direction,
        "nutritPerServe": nutritPerServe,
        "imagesUrl": imagesUrl,
        "serving": serving,
        "prepTime": prepTime,
        "cookTime": cookTime,
        "keys": keys,
        "categname": categname,
        "planname": planname,
      };
}
