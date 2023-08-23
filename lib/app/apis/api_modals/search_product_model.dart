import 'get_product_list_api_model.dart';

class SearchProductModel {
  String? message;
  List<Products>? productList;

  SearchProductModel({this.message, this.productList});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['productList'] != null) {
      productList = <Products>[];
      json['productList'].forEach((v) {
        productList!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (productList != null) {
      data['productList'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*
class ProductList {
  String? uuid;
  String? productId;
  String? productUuid;
  String? productName;
  String? thumbnailImage;
  String? brandChartImg;
  String? brandId;
  String? brandName;
  String? productPrice;
  String? percentageDis;
  String? offerPrice;
  String? isOffer;

  ProductList(
      {this.uuid,
        this.productId,
        this.productUuid,
        this.productName,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandId,
        this.brandName,
        this.productPrice,
        this.percentageDis,
        this.offerPrice,
        this.isOffer});

  ProductList.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productId = json['productId'];
    productUuid = json['productUuid'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    productPrice = json['productPrice'];
    percentageDis = json['percentageDis'];
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
    data['percentageDis'] = percentageDis;
    data['offerPrice'] = offerPrice;
    data['isOffer'] = isOffer;
    return data;
  }
}*/
