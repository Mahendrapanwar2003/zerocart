/*class RecentProduct {
  String? message;
  List<HomeProducts>? products;

  RecentProduct({this.message, this.products});

  RecentProduct.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['products'] != null) {
      products = <HomeProducts>[];
      json['products'].forEach((v) {
        products!.add(HomeProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeProducts {
  String? uuid;
  int? productId;
  String? productUuid;
  String? productName;
  String? thumbnailImage;
  String? brandChartImg;
  int? brandId;
  String? brandName;
  double? productPrice;
  double? offerPrice;
  int? isOffer;

  HomeProducts(
      {this.uuid,
        this.productId,
        this.productUuid,
        this.productName,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandId,
        this.brandName,
        this.productPrice,
        this.offerPrice,
        this.isOffer});

  HomeProducts.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productId = json['productId'];
    productUuid = json['productUuid'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    productPrice = json['productPrice'];
    offerPrice = json['offerPrice'];
    isOffer = json['isOffer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['productId'] = this.productId;
    data['productUuid'] = this.productUuid;
    data['productName'] = this.productName;
    data['thumbnailImage'] = this.thumbnailImage;
    data['brandChartImg'] = this.brandChartImg;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['productPrice'] = this.productPrice;
    data['offerPrice'] = this.offerPrice;
    data['isOffer'] = this.isOffer;
    return data;
  }
}*/


class RecentProduct {
  String? message;
  List<HomeProducts>? products;

  RecentProduct({this.message, this.products});

  RecentProduct.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['products'] != null) {
      products = <HomeProducts>[];
      json['products'].forEach((v) {
        products!.add(HomeProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeProducts {
  String? uuid;
  int? productId;
  String? productUuid;
  String? productName;
  String? thumbnailImage;
  String? brandChartImg;
  int? brandId;
  String? brandName;
  double? productPrice;
  double? offerPrice;
  int? isOffer;

  HomeProducts(
      {this.uuid,
        this.productId,
        this.productUuid,
        this.productName,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandId,
        this.brandName,
        this.productPrice,
        this.offerPrice,
        this.isOffer});

  HomeProducts.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productId = json['productId'];
    productUuid = json['productUuid'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    productPrice = json['productPrice'];
    offerPrice = json['offerPrice'];
    isOffer = json['isOffer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['productUuid'] = productUuid;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['brandChartImg'] = brandChartImg;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['productPrice'] = productPrice;
    data['offerPrice'] = offerPrice;
    data['isOffer'] = isOffer;
    return data;
  }
}