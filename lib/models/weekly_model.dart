class WeeklyModel {
  bool success;
  List<Data> data;
  String error;

  WeeklyModel({this.success, this.data, this.error});

  WeeklyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int recipeid;
  String day;
  int weekNumber;
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
  String categName;
  String planName;

  Data(
      {this.recipeid,
      this.day,
      this.weekNumber,
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
      this.categName,
      this.planName});

  Data.fromJson(Map<String, dynamic> json) {
    recipeid = json['recipeid'];
    day = json['day'];
    weekNumber = json['weekNumber'];
    categoryId = json['categoryId'];
    planId = json['planId'];
    recipeName = json['recipeName'];
    whatYouNeed = json['whatYouNeed'];
    direction = json['direction'];
    nutritPerServe = json['nutritPerServe'];
    imagesUrl = json['imagesUrl'];
    serving = json['serving'];
    prepTime = json['prepTime'];
    cookTime = json['cookTime'];
    keys = json['keys'];
    categName = json['categName'];
    planName = json['planName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeid'] = this.recipeid;
    data['day'] = this.day;
    data['weekNumber'] = this.weekNumber;
    data['categoryId'] = this.categoryId;
    data['planId'] = this.planId;
    data['recipeName'] = this.recipeName;
    data['whatYouNeed'] = this.whatYouNeed;
    data['direction'] = this.direction;
    data['nutritPerServe'] = this.nutritPerServe;
    data['imagesUrl'] = this.imagesUrl;
    data['serving'] = this.serving;
    data['prepTime'] = this.prepTime;
    data['cookTime'] = this.cookTime;
    data['keys'] = this.keys;
    data['categName'] = this.categName;
    data['planName'] = this.planName;
    return data;
  }
}
