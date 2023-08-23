class GetAllFashionCategoryListApiModel {
  String? message;
  List<FashionCategoryList>? fashionCategoryList;

  GetAllFashionCategoryListApiModel({this.message, this.fashionCategoryList});

  GetAllFashionCategoryListApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['fashionCategoryList'] != null) {
      fashionCategoryList = <FashionCategoryList>[];
      json['fashionCategoryList'].forEach((v) {
        fashionCategoryList!.add(FashionCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (fashionCategoryList != null) {
      data['fashionCategoryList'] =
          fashionCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FashionCategoryList {
  String? fashionCategoryId;
  String? categoryTypeId;
  String? uuid;
  String? name;

  FashionCategoryList(
      {this.fashionCategoryId, this.categoryTypeId, this.uuid, this.name});

  FashionCategoryList.fromJson(Map<String, dynamic> json) {
    fashionCategoryId = json['fashionCategoryId'];
    categoryTypeId = json['categoryTypeId'];
    uuid = json['uuid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fashionCategoryId'] = fashionCategoryId;
    data['categoryTypeId'] = categoryTypeId;
    data['uuid'] = uuid;
    data['name'] = name;
    return data;
  }
}
