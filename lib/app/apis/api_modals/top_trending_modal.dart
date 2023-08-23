class TopTrendingApiModal {
  String? message;
  List<TrendingList>? trendingList;

  TopTrendingApiModal({this.message, this.trendingList});

  TopTrendingApiModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['trendingList'] != null) {
      trendingList = <TrendingList>[];
      json['trendingList'].forEach((v) {
        trendingList!.add(TrendingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (trendingList != null) {
      data['trendingList'] = trendingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrendingList {
  String? searchCount;
  String? srchId;
  String? productId;
  String? inventoryId;
  String? productName;
  String? thumbnailImage;
  String? price;

  TrendingList(
      {this.searchCount,
        this.srchId,
        this.productId,
        this.inventoryId,
        this.productName,
        this.thumbnailImage,
        this.price});

  TrendingList.fromJson(Map<String, dynamic> json) {
    searchCount = json['searchCount'];
    srchId = json['srchId'];
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searchCount'] = searchCount;
    data['srchId'] = srchId;
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['price'] = price;
    return data;
  }
}
