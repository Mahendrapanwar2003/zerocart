import 'package:zerocart/app/apis/api_modals/get_cart_details_model.dart';

class GetWishlistModal {
  String? message;
  List<WishList>? wishList;

  GetWishlistModal({this.message, this.wishList});

  GetWishlistModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['wishList'] != null) {
      wishList = <WishList>[];
      json['wishList'].forEach((v) {
        wishList!.add( WishList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (wishList != null) {
      data['wishList'] = wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishList {
  String? wishlistId;
  String? uuid;
  String? productId;
  String? inventoryId;
  String? customerId;
  String? createdDate;
  String? brandId;
  String? brandName;
  String? productName;
  String? thumbnailImage;
  String? inStock;
  String? isVariant;
  String? isColor;
  String? inCart;
  String? colorName;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? percentageDis;
  String? offerPrice;
  List<VarientList>? varientList;

  WishList(
      {this.wishlistId,
        this.uuid,
        this.productId,
        this.inventoryId,
        this.customerId,
        this.createdDate,
        this.brandId,
        this.brandName,
        this.productName,
        this.thumbnailImage,
        this.inStock,
        this.isVariant,
        this.isColor,
        this.colorName,
        this.availability,
        this.sellPrice,
        this.isOffer,
        this.percentageDis,
        this.offerPrice,
        this.varientList,
        this.inCart});

  WishList.fromJson(Map<String, dynamic> json) {
    wishlistId = json['wishlistId'];
    uuid = json['uuid'];
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    customerId = json['customerId'];
    createdDate = json['createdDate'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    inStock = json['inStock'];
    isVariant = json['isVariant'];
    isColor = json['isColor'];
    inCart=json['inCart'];
    colorName = json['colorName'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    percentageDis = json['percentageDis'];
    offerPrice = json['offerPrice'];
    if (json['varientList'] != null) {
      varientList = <VarientList>[];
      json['varientList'].forEach((v) {
        varientList!.add( VarientList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['wishlistId'] = wishlistId;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['customerId'] = customerId;
    data['createdDate'] = createdDate;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['inStock'] = inStock;
    data['inCart'] = inCart;
    data['isVariant'] = isVariant;
    data['isColor'] = isColor;
    data['colorName'] = colorName;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['percentageDis'] = percentageDis;
    data['offerPrice'] = offerPrice;
    if (varientList != null) {
      data['varientList'] = varientList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

