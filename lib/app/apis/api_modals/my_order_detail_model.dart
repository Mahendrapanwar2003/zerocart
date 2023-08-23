class MyOrderDetailsModel {
  String? message;
  List<ProductDetails>? productDetails;

  MyOrderDetailsModel({this.message, this.productDetails});

  MyOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['productDetails'] != null) {
      productDetails = <ProductDetails>[];
      json['productDetails'].forEach((v) {
        productDetails!.add(ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (productDetails != null) {
      data['productDetails'] =
          productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  String? productId;
  String? inventoryId;
  String? brandId;
  String? uuid;
  String? productName;
  String? thumbnailImage;
  String? brandChartImg;
  String? brandName;
  String? productPrice;
  String? percentageDis;
  String? offerPrice;
  String? isOffer;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? productDescription;
  String? sellerDescription;
  String? rateAverage;
  String? totalReview;

  ProductDetails(
      {this.productId,
        this.inventoryId,
        this.brandId,
        this.uuid,
        this.productName,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandName,
        this.productPrice,
        this.percentageDis,
        this.offerPrice,
        this.isOffer,
        this.colorName,
        this.colorCode,
        this.variantName,
        this.variantAbbreviation,
        this.productDescription,
        this.sellerDescription,
        this.rateAverage,
        this.totalReview});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    brandId = json['brandId'];
    uuid = json['uuid'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandName = json['brandName'];
    productPrice = json['productPrice'];
    percentageDis = json['percentageDis'];
    offerPrice = json['offerPrice'];
    isOffer = json['isOffer'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    productDescription = json['productDescription'];
    sellerDescription = json['sellerDescription'];
    rateAverage = json['rateAverage'];
    totalReview = json['totalReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['brandId'] = brandId;
    data['uuid'] = uuid;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['brandChartImg'] = brandChartImg;
    data['brandName'] = brandName;
    data['productPrice'] = productPrice;
    data['percentageDis'] = percentageDis;
    data['offerPrice'] = offerPrice;
    data['isOffer'] = isOffer;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['productDescription'] = productDescription;
    data['sellerDescription'] = sellerDescription;
    data['rateAverage'] = rateAverage;
    data['totalReview'] = totalReview;
    return data;
  }
}