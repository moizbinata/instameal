// To parse this JSON data, do
//
//     final notifModel = notifModelFromJson(jsonString);

import 'dart:convert';

NotifModel notifModelFromJson(String str) =>
    NotifModel.fromJson(json.decode(str));

String notifModelToJson(NotifModel data) => json.encode(data.toJson());

class NotifModel {
  NotifModel({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  List<NotifMessageModel> data;
  String error;

  factory NotifModel.fromJson(Map<String, dynamic> json) => NotifModel(
        success: json["success"],
        data: List<NotifMessageModel>.from(
            json["data"].map((x) => NotifMessageModel.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class NotifMessageModel {
  NotifMessageModel({
    this.userid,
    this.notificationid,
    this.title,
    this.message,
    this.important,
  });

  int userid;
  int notificationid;
  String title;
  String message;
  int important;

  factory NotifMessageModel.fromJson(Map<String, dynamic> json) =>
      NotifMessageModel(
        userid: json["userid"],
        notificationid: json["notificationid"],
        title: json["title"],
        message: json["message"],
        important: json["important"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "notificationid": notificationid,
        "title": title,
        "message": message,
        "important": important,
      };
}
