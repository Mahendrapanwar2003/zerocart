class GetRecentProductApiModel {
  String? message;
  List<RecentSearchList>? recentSearchList;

  GetRecentProductApiModel({this.message, this.recentSearchList});

  GetRecentProductApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['recentSearchList'] != null) {
      recentSearchList = <RecentSearchList>[];
      json['recentSearchList'].forEach((v) {
        recentSearchList!.add(RecentSearchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (recentSearchList != null) {
      data['recentSearchList'] =
          recentSearchList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentSearchList {
  String? srchId;
  String? productId;
  String? inventoryId;
  String? productName;
  String? thumbnailImage;
  String? price;

  RecentSearchList(
      {this.srchId,
        this.productId,
        this.inventoryId,
        this.productName,
        this.thumbnailImage,
        this.price});

  RecentSearchList.fromJson(Map<String, dynamic> json) {
    srchId = json['srchId'];
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['srchId'] = srchId;
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['price'] = price;
    return data;
  }
}
