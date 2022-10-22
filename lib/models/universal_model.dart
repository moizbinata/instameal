class UniversalModel {
  bool success;
  List<Fav> fav;
  List<Festival> festival;
  List<Collection> collection;
  List<Dessert> dessert;
  String error;

  UniversalModel(
      {this.success,
      this.fav,
      this.festival,
      this.collection,
      this.dessert,
      this.error});

  UniversalModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['fav'] != null) {
      fav = <Fav>[];
      json['fav'].forEach((v) {
        fav.add(new Fav.fromJson(v));
      });
    }
    if (json['festival'] != null) {
      festival = <Festival>[];
      json['festival'].forEach((v) {
        festival.add(new Festival.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection.add(new Collection.fromJson(v));
      });
    }
    if (json['dessert'] != null) {
      dessert = <Dessert>[];
      json['dessert'].forEach((v) {
        dessert.add(new Dessert.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.fav != null) {
      data['fav'] = this.fav.map((v) => v.toJson()).toList();
    }
    if (this.festival != null) {
      data['festival'] = this.festival.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection.map((v) => v.toJson()).toList();
    }
    if (this.dessert != null) {
      data['dessert'] = this.dessert.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Fav {
  int userId;
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
  String categName;
  String planName;

  Fav(
      {this.userId,
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
      this.categName,
      this.planName});

  Fav.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    recipeId = json['RecipeId'];
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
    data['UserId'] = this.userId;
    data['RecipeId'] = this.recipeId;
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

class Festival {
  int recipeid;
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

  Festival(
      {this.recipeid,
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

  Festival.fromJson(Map<String, dynamic> json) {
    recipeid = json['recipeid'];
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

class Collection {
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
  String categName;
  String planName;

  Collection(
      {this.recipeId,
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

  Collection.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipeid'];
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
    data['recipeId'] = this.recipeId;
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

class Dessert {
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
  String categName;
  String planName;

  Dessert(
      {this.recipeId,
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

  Dessert.fromJson(Map<String, dynamic> json) {
    recipeId = json['RecipeId'];
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
    data['RecipeId'] = this.recipeId;
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
