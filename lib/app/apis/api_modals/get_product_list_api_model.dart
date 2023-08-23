class GetProductListApiModel {
  String? message;
  List<Products>? products;
  CategoryData? categoryData;

  GetProductListApiModel({this.message, this.products, this.categoryData});

  GetProductListApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    categoryData = json['categoryData'] != null
        ? CategoryData.fromJson(json['categoryData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (categoryData != null) {
      data['categoryData'] = categoryData!.toJson();
    }
    return data;
  }
}

class Products {
  String? uuid;
  String? productId;
  String? productUuid;
  String? isColor;
  String? productName;
  String? thumbnailImage;
  String? brandChartImg;
  String? brandId;
  String? brandName;
  String? review;
  List<ColorsList>? colorsList;

  Products(
      {this.uuid,
        this.productId,
        this.productUuid,
        this.isColor,
        this.productName,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandId,
        this.brandName,
        this.review,
        this.colorsList});

  Products.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productId = json['productId'];
    productUuid = json['productUuid'];
    isColor = json['isColor'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    review = json['review'];
    if (json['ColorsList'] != null) {
      colorsList = <ColorsList>[];
      json['ColorsList'].forEach((v) {
        colorsList!.add(ColorsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['productUuid'] = productUuid;
    data['isColor'] = isColor;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['brandChartImg'] = brandChartImg;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['review'] = review;
    if (colorsList != null) {
      data['ColorsList'] = colorsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorsList {
  String? colorName;
  String? colorCode;
  String? isOffer;
  String? productPrice;
  String? percentageDis;
  String? offerPrice;
  String? variantAbbreviation;

  ColorsList(
      {this.colorName,
        this.colorCode,
        this.isOffer,
        this.productPrice,
        this.percentageDis,
        this.offerPrice,
        this.variantAbbreviation});

  ColorsList.fromJson(Map<String, dynamic> json) {
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    isOffer = json['isOffer'];
    productPrice = json['productPrice'];
    percentageDis = json['percentageDis'];
    offerPrice = json['offerPrice'];
    variantAbbreviation = json['variantAbbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['isOffer'] = isOffer;
    data['productPrice'] = productPrice;
    data['percentageDis'] = percentageDis;
    data['offerPrice'] = offerPrice;
    data['variantAbbreviation'] = variantAbbreviation;
    return data;
  }
}

class CategoryData {
  String? categoryId;
  String? categoryName;
  String? isChatOption;
  String? categoryImage;

  CategoryData(
      {this.categoryId,
        this.categoryName,
        this.isChatOption,
        this.categoryImage});

  CategoryData.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    isChatOption = json['isChatOption'];
    categoryImage = json['categoryImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['isChatOption'] = isChatOption;
    data['categoryImage'] = categoryImage;
    return data;
  }
}
