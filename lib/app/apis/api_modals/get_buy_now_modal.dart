import 'package:zerocart/app/apis/api_modals/get_cart_details_model.dart';

class GetProductByInventoryApiModal {
  String? message;
  ProductDetail? productDetail;
  AddressDetail? addressDetail;

  GetProductByInventoryApiModal(
      {this.message, this.productDetail, /*this.addressDetail*/});

  GetProductByInventoryApiModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    productDetail = json['productDetail'] != null
        ? ProductDetail.fromJson(json['productDetail'])
        : null;
    addressDetail = json['addressDetail'] != null
        ?  AddressDetail.fromJson(json['addressDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (productDetail != null) {
      data['productDetail'] = productDetail!.toJson();
    }
     if (addressDetail != null) {
       data['addressDetail'] = addressDetail!.toJson();
     }
    return data;
  }
}

class ProductDetail {
  String? productId;
  String? uuid;
  String? venderId;
  String? categoryId;
  String? subCategoryId;
  String? brandId;
  String? productName;
  String? categoryType;
  String? thumbnailImage;
  String? brandChartImg;
  String? inStock;
  String? createdDate;
  String? inventoryId;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? brandName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;
  String? percentageDis;
  String? deliveryCharge;

  ProductDetail(
      {this.productId,
        this.uuid,
        this.venderId,
        this.categoryId,
        this.subCategoryId,
        this.brandId,
        this.productName,
        this.categoryType,
        this.thumbnailImage,
        this.brandChartImg,
        this.inStock,
        this.createdDate,
        this.inventoryId,
        this.colorName,
        this.colorCode,
        this.variantName,
        this.brandName,
        this.variantAbbreviation,
        this.availability,
        this.sellPrice,
        this.isOffer,
        this.offerPrice,
        this.percentageDis,
        this.deliveryCharge});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    uuid = json['uuid'];
    venderId = json['venderId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    brandId = json['brandId'];
    productName = json['productName'];
    categoryType = json['categoryType'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    inStock = json['inStock'];
    createdDate = json['createdDate'];
    inventoryId = json['inventoryId'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    brandName = json['brandName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
    percentageDis = json['percentageDis'];
    deliveryCharge = json['deliveryCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['uuid'] = uuid;
    data['venderId'] = venderId;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['brandId'] = brandId;
    data['productName'] = productName;
    data['categoryType'] = categoryType;
    data['thumbnailImage'] = thumbnailImage;
    data['brandChartImg'] = brandChartImg;
    data['inStock'] = inStock;
    data['createdDate'] = createdDate;
    data['inventoryId'] = inventoryId;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['brandName'] = brandName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    data['percentageDis'] = percentageDis;
    data['deliveryCharge'] = deliveryCharge;
    return data;
  }
}
