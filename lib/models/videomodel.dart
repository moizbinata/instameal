// To parse this JSON data, do
//
//     final vModel = vModelFromJson(jsonString);

import 'dart:convert';

VModel vModelFromJson(String str) => VModel.fromJson(json.decode(str));

String vModelToJson(VModel data) => json.encode(data.toJson());

class VModel {
  VModel({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  List<VideoModel> data;
  String error;

  factory VModel.fromJson(Map<String, dynamic> json) => VModel(
        success: json["success"],
        data: List<VideoModel>.from(
            json["data"].map((x) => VideoModel.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class VideoModel {
  VideoModel({
    this.videoid,
    this.title,
    this.imageUrl,
    this.videoUrl,
    this.directions,
    this.ingredients,
  });

  int videoid;
  String title;
  String imageUrl;
  String videoUrl;
  List<String> directions;
  List<String> ingredients;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videoid: json["videoid"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        videoUrl: json["videoUrl"],
        directions: json["directions"] != null
            ? json['directions'].toString().split('***').toList()
            : [],
        ingredients: json["ingredients"] != null
            ? json['ingredients'].toString().split('***').toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        "videoid": videoid,
        "title": title,
        "imageUrl": imageUrl,
        "videoUrl": videoUrl,
      };
}
