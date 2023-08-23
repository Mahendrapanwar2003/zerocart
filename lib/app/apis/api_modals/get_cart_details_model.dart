class GetCartDetailsModel {
  String? message;
  List<CartItemList>? cartItemList;
  AddressDetail? addressDetail;
  int? totalDeliveryCharge;

  GetCartDetailsModel(
      {this.message,
        this.cartItemList,
        this.addressDetail,
        this.totalDeliveryCharge});

  GetCartDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['cartItemList'] != null) {
      cartItemList = <CartItemList>[];
      json['cartItemList'].forEach((v) {
        cartItemList!.add( CartItemList.fromJson(v));
      });
    }
    addressDetail = json['addressDetail'] != null
        ?  AddressDetail.fromJson(json['addressDetail'])
        : null;
    totalDeliveryCharge = json['totalDeliveryCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (cartItemList != null) {
      data['cartItemList'] = cartItemList!.map((v) => v.toJson()).toList();
    }
    if (addressDetail != null) {
      data['addressDetail'] = addressDetail!.toJson();
    }
    data['totalDeliveryCharge'] = totalDeliveryCharge;
    return data;
  }
}

class CartItemList {
  String? cartId;
  String? uuid;
  String? customerId;
  String? userSelection;
  String? productId;
  String? inventoryId;
  String? cartQty;
  String? isChecked;
  String? isDeleted;
  String? createdDate;
  String? updatedDate;
  String? brandId;
  String? brandName;
  String? productName;
  String? thumbnailImage;
  String? inStock;
  String? isVariant;
  String? isColor;
  String? colorName;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? selectedSize;
  String? percentageDis;
  String? offerPrice;
  String? charges;
  String? vendorLatitude;
  String? vendorLongitude;
  List<VarientList>? varientList;
  int? totalDeliveryCharge;

  CartItemList(
      {this.cartId,
        this.uuid,
        this.customerId,
        this.userSelection,
        this.productId,
        this.inventoryId,
        this.cartQty,
        this.isChecked,
        this.isDeleted,
        this.createdDate,
        this.updatedDate,
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
        this.selectedSize,
        this.percentageDis,
        this.offerPrice,
        this.charges,
        this.vendorLatitude,
        this.vendorLongitude,
        this.varientList,
        this.totalDeliveryCharge});

  CartItemList.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    uuid = json['uuid'];
    customerId = json['customerId'];
    userSelection = json['userSelection'];
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    cartQty = json['cartQty'];
    isChecked = json['isChecked'];
    isDeleted = json['isDeleted'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    inStock = json['inStock'];
    isVariant = json['isVariant'];
    isColor = json['isColor'];
    colorName = json['colorName'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    selectedSize = json['selectedSize'];
    percentageDis = json['percentageDis'];
    offerPrice = json['offerPrice'];
    charges = json['charges'];
    vendorLatitude = json['vendorLatitude'];
    vendorLongitude = json['vendorLongitude'];
    if (json['varientList'] != null) {
      varientList = <VarientList>[];
      json['varientList'].forEach((v) {
        varientList!.add( VarientList.fromJson(v));
      });
    }
    totalDeliveryCharge = json['totalDeliveryCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['cartId'] = cartId;
    data['uuid'] = uuid;
    data['customerId'] = customerId;
    data['userSelection'] = userSelection;
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['cartQty'] = cartQty;
    data['isChecked'] = isChecked;
    data['isDeleted'] = isDeleted;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['inStock'] = inStock;
    data['isVariant'] = isVariant;
    data['isColor'] = isColor;
    data['colorName'] = colorName;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['percentageDis'] = percentageDis;
    data['selectedSize'] = selectedSize;
    data['offerPrice'] = offerPrice;
    data['charges'] = charges;
    data['vendorLatitude'] = vendorLatitude;
    data['vendorLongitude'] = vendorLongitude;
    if (varientList != null) {
      data['varientList'] = varientList!.map((v) => v.toJson()).toList();
    }
    data['totalDeliveryCharge'] = totalDeliveryCharge;
    return data;
  }
}

class VarientList {
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? inventoryId;

  VarientList(
      {this.variantName,
        this.variantAbbreviation,
        this.availability,
        this.inventoryId});

  VarientList.fromJson(Map<String, dynamic> json) {
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    inventoryId = json['inventoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['inventoryId'] = inventoryId;
    return data;
  }
}

class AddressDetail {
  String? name;
  String? phone;
  String? countryCode;
  String? pinCode;
  String? state;
  String? city;
  String? houseNo;
  String? colony;
  String? addressType;
  String? latitude;
  String? longitude;
  String? isDefaultAddress;

  AddressDetail(
      {this.name,
        this.phone,
        this.countryCode,
        this.pinCode,
        this.state,
        this.city,
        this.houseNo,
        this.colony,
        this.addressType,
        this.latitude,
        this.longitude,
        this.isDefaultAddress});

  AddressDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    pinCode = json['pinCode'];
    state = json['state'];
    city = json['city'];
    houseNo = json['houseNo'];
    colony = json['colony'];
    addressType = json['addressType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefaultAddress = json['isDefaultAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['countryCode'] = countryCode;
    data['pinCode'] = pinCode;
    data['state'] = state;
    data['city'] = city;
    data['houseNo'] = houseNo;
    data['colony'] = colony;
    data['addressType'] = addressType;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isDefaultAddress'] = isDefaultAddress;
    return data;
  }
}