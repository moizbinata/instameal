class ImagesModel {
  bool success;
  List<ImgData> data;
  String error;

  ImagesModel({this.success, this.data, this.error});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ImgData>[];
      json['data'].forEach((v) {
        data.add(new ImgData.fromJson(v));
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

class ImgData {
  int imageId;
  String imageUrl;
  String imageCateg;

  ImgData({this.imageId, this.imageUrl, this.imageCateg});

  ImgData.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imageUrl = json['imageUrl'];
    imageCateg = json['imageCateg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageUrl'] = this.imageUrl;
    data['imageCateg'] = this.imageCateg;
    return data;
  }
}
