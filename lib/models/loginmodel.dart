// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  List<UserModel> data;
  String error;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: List<UserModel>.from(
            json["data"].map((x) => UserModel.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class UserModel {
  UserModel({
    this.userid,
    this.username,
    this.password,
    this.email,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.membershipType,
    this.trialStatus,
    this.paymentStatus,
  });

  int userid;
  String username;
  String password;
  String email;
  String subscriptionStart;
  String subscriptionEnd;
  String membershipType;
  String trialStatus;
  String paymentStatus;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userid: json["userid"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        subscriptionStart: json["subscriptionStart"],
        subscriptionEnd: json["subscriptionEnd"],
        membershipType: json["membershipType"],
        trialStatus: json["trialStatus"],
        paymentStatus: json["paymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "username": username,
        "password": password,
        "email": email,
        "subscriptionStart": subscriptionStart,
        "subscriptionEnd": subscriptionEnd,
        "membershipType": membershipType,
        "trialStatus": trialStatus,
        "paymentStatus": paymentStatus,
      };
}
