enum TypeOfProduct { SHOW_BOTH, SHOW_COLOR, SHOW_VARIANT, SHOW_IMAGES }

class GetProductDetailModel {
  String? message;
  ProductDetails? productDetails;

  GetProductDetailModel({this.message, this.productDetails});

  GetProductDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    productDetails = json['productDetails'] != null
        ? ProductDetails.fromJson(json['productDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (productDetails != null) {
      data['productDetails'] = productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  bool isColorAvailable = false;
  bool isVariantAvailable = false;
  String? inWishlist;
  String? inCart;
  String? inOutfitRoom;
  String? uuid;
  String? productId;
  String? productUuid;
  String? categoryId;
  String? subCategoryId;
  String? productName;
  String? sellerDescription;
  String? thumbnailImage;
  String? isColor;
  String? isVariant;
  String? venderId;
  String? vendorName;
  String? vendorType;
  String? inStock;
  String? brandChartImg;
  String? createdDate;
  String? categoryName;
  String? categoryImage;
  String? subCategoryName;
  String? brandId;
  String? brandName;
  String? totalReview;
  String? totalRating;
  List<InventoryArr>? inventoryArr;

  ProductDetails(
      {this.inWishlist,
      this.inCart,
      this.inOutfitRoom,
      this.uuid,
      this.productId,
      this.productUuid,
      this.categoryId,
      this.subCategoryId,
      this.productName,
      this.sellerDescription,
      this.thumbnailImage,
      this.isColor,
      this.isVariant,
      this.venderId,
      this.vendorName,
      this.vendorType,
      this.inStock,
      this.brandChartImg,
      this.createdDate,
      this.categoryName,
      this.categoryImage,
      this.subCategoryName,
      this.brandId,
      this.brandName,
      this.totalReview,
      this.totalRating,
      this.inventoryArr});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    isColorAvailable = json["isColor"] == "1";
    isVariantAvailable = json["isVariant"] == "1";
    inWishlist = json['inWishlist'];
    inCart = json['inCart'];
    inOutfitRoom = json['inOutfitRoom'];
    uuid = json['uuid'];
    productId = json['productId'];
    productUuid = json['productUuid'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    productName = json['productName'];
    sellerDescription = json['sellerDescription'];
    thumbnailImage = json['thumbnailImage'];
    isColor = json['isColor'];
    isVariant = json['isVariant'];
    venderId = json['venderId'];
    vendorName = json['vendorName'];
    vendorType = json['vendorType'];
    inStock = json['inStock'];
    brandChartImg = json['brandChartImg'];
    createdDate = json['createdDate'];
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
    subCategoryName = json['subCategoryName'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    totalReview = json['totalReview'];
    totalRating = json['totalRating'];
    if (json['inventoryArr'] != null) {
      inventoryArr = <InventoryArr>[];
      json['inventoryArr'].forEach((v) {
        inventoryArr!.add(InventoryArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inWishlist'] = inWishlist;
    data['inCart'] = inCart;
    data['inOutfitRoom'] = inOutfitRoom;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['productUuid'] = productUuid;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['productName'] = productName;
    data['sellerDescription'] = sellerDescription;
    data['thumbnailImage'] = thumbnailImage;
    data['isColor'] = isColor;
    data['isVariant'] = isVariant;
    data['venderId'] = venderId;
    data['vendorName'] = vendorName;
    data['vendorType'] = vendorType;
    data['inStock'] = inStock;
    data['brandChartImg'] = brandChartImg;
    data['createdDate'] = createdDate;
    data['categoryName'] = categoryName;
    data['categoryImage'] = categoryImage;
    data['subCategoryName'] = subCategoryName;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['totalReview'] = totalReview;
    data['totalRating'] = totalRating;
    if (inventoryArr != null) {
      data['inventoryArr'] = inventoryArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TypeOfProduct get checkProductType {
    if (isColorAvailable && isVariantAvailable) {
      return TypeOfProduct.SHOW_BOTH;
    } else if (isColorAvailable && isVariantAvailable == false) {
      return TypeOfProduct.SHOW_COLOR;
    } else if (isColorAvailable == false && isVariantAvailable) {
      return TypeOfProduct.SHOW_VARIANT;
    } else {
      return TypeOfProduct.SHOW_IMAGES;
    }
  }
}

class InventoryArr {
  String? inventoryId;
  String? uuid;
  String? productId;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;
  String? productDescription;
  String? percentageDis;
  String? isCustom;
  List<VarientList>? varientList;
  List<ProductImage>? productImage;

  InventoryArr(
      {this.inventoryId,
      this.uuid,
      this.productId,
      this.colorName,
      this.colorCode,
      this.variantName,
      this.variantAbbreviation,
      this.availability,
      this.sellPrice,
      this.isOffer,
      this.offerPrice,
      this.productDescription,
      this.percentageDis,
      this.isCustom,
      this.varientList,
      this.productImage});

  InventoryArr.fromJson(Map<String, dynamic> json) {
    inventoryId = json['inventoryId'];
    uuid = json['uuid'];
    productId = json['productId'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
    productDescription = json['productDescription'];
    percentageDis = json['percentageDis'];
    isCustom = json['isCustom'];
    if (json['varientList'] != null) {
      varientList = <VarientList>[];
      json['varientList'].forEach((v) {
        varientList!.add(VarientList.fromJson(v));
      });
    }
    if (json['productImage'] != null) {
      productImage = <ProductImage>[];
      json['productImage'].forEach((v) {
        productImage!.add(ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inventoryId'] = inventoryId;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    data['productDescription'] = productDescription;
    data['percentageDis'] = percentageDis;
    data['isCustom'] = isCustom;
    if (varientList != null) {
      data['varientList'] = varientList!.map((v) => v.toJson()).toList();
    }
    if (productImage != null) {
      data['productImage'] = productImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VarientList {
  String? inventoryId;
  String? uuid;
  String? productId;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;
  String? productDescription;
  String? customImage;
  String? isActive;
  String? isDelete;
  String? createdDate;
  String? updatedDate;
  String? isCustom;
  String? percentageDis;
  List<ProductImage>? productImage;

  VarientList(
      {this.inventoryId,
      this.uuid,
      this.productId,
      this.colorName,
      this.colorCode,
      this.variantName,
      this.variantAbbreviation,
      this.availability,
      this.sellPrice,
      this.isOffer,
      this.offerPrice,
      this.productDescription,
      this.customImage,
      this.isActive,
      this.isDelete,
      this.createdDate,
      this.updatedDate,
      this.isCustom,
      this.percentageDis,
      this.productImage});

  VarientList.fromJson(Map<String, dynamic> json) {
    inventoryId = json['inventoryId'];
    uuid = json['uuid'];
    productId = json['productId'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
    productDescription = json['productDescription'];
    customImage = json['customImage'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    isCustom = json['isCustom'];
    percentageDis = json['percentageDis'];
    if (json['productImage'] != null) {
      productImage = <ProductImage>[];
      json['productImage'].forEach((v) {
        productImage!.add(ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inventoryId'] = inventoryId;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    data['productDescription'] = productDescription;
    data['customImage'] = customImage;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['isCustom'] = isCustom;
    data['percentageDis'] = percentageDis;
    if (productImage != null) {
      data['productImage'] = productImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImage {
  String? productImageId;
  String? productImage;

  ProductImage({this.productImageId, this.productImage});

  ProductImage.fromJson(Map<String, dynamic> json) {
    productImageId = json['productImageId'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productImageId'] = productImageId;
    data['productImage'] = productImage;
    return data;
  }
}

/*
enum TypeOfProduct { SHOW_BOTH, SHOW_COLOR, SHOW_VARIANT, SHOW_IMAGES }

class GetProductDetailModel {
  String? message;
  ProductDetails? productDetails;

  GetProductDetailModel({this.message, this.productDetails});

  GetProductDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    productDetails = json['productDetails'] != null
        ? ProductDetails.fromJson(json['productDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (productDetails != null) {
      data['productDetails'] = productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  bool isColorAvailable = false;
  bool isVariantAvailable = false;
  String? inWishlist;
  String? inCart;
  String? uuid;
  String? productId;
  String? productUuid;
  String? categoryId;
  String? subCategoryId;
  String? productName;
  String? sellerDescription;
  String? thumbnailImage;
  String? isColor;
  String? isVariant;
  String? venderId;
  String? vendorName;
  String? vendorType;
  String? inStock;
  String? brandChartImg;
  String? createdDate;
  String? categoryName;
  String? categoryImage;
  String? subCategoryName;
  String? brandId;
  String? brandName;
  String? totalReview;
  String? totalRating;
  List<InventoryArr>? inventoryArr;

  ProductDetails(
      {this.inWishlist,
      this.inCart,
      this.uuid,
      this.productId,
      this.productUuid,
      this.categoryId,
      this.subCategoryId,
      this.productName,
      this.sellerDescription,
      this.thumbnailImage,
      this.isColor,
      this.isVariant,
      this.venderId,
      this.vendorName,
      this.vendorType,
      this.inStock,
      this.brandChartImg,
      this.createdDate,
      this.categoryName,
      this.categoryImage,
      this.subCategoryName,
      this.brandId,
      this.brandName,
      this.totalReview,
      this.totalRating,
      this.inventoryArr});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    isColorAvailable = json["isColor"] == "1";
    isVariantAvailable = json["isVariant"] == "1";
    inWishlist = json['inWishlist'];
    inCart = json['inCart'];
    uuid = json['uuid'];
    productId = json['productId'];
    productUuid = json['productUuid'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    productName = json['productName'];
    sellerDescription = json['sellerDescription'];
    thumbnailImage = json['thumbnailImage'];
    isColor = json['isColor'];
    isVariant = json['isVariant'];
    venderId = json['venderId'];
    vendorName = json['vendorName'];
    vendorType = json['vendorType'];
    inStock = json['inStock'];
    brandChartImg = json['brandChartImg'];
    createdDate = json['createdDate'];
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
    subCategoryName = json['subCategoryName'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    totalReview = json['totalReview'];
    totalRating = json['totalRating'];
    if (json['inventoryArr'] != null) {
      inventoryArr = <InventoryArr>[];
      json['inventoryArr'].forEach((v) {
        inventoryArr!.add(InventoryArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inWishlist'] = inWishlist;
    data['inCart'] = inCart;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['productUuid'] = productUuid;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['productName'] = productName;
    data['sellerDescription'] = sellerDescription;
    data['thumbnailImage'] = thumbnailImage;
    data['isColor'] = isColor;
    data['isVariant'] = isVariant;
    data['venderId'] = venderId;
    data['vendorName'] = vendorName;
    data['vendorType'] = vendorType;
    data['inStock'] = inStock;
    data['brandChartImg'] = brandChartImg;
    data['createdDate'] = createdDate;
    data['categoryName'] = categoryName;
    data['categoryImage'] = categoryImage;
    data['subCategoryName'] = subCategoryName;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['totalReview'] = totalReview;
    data['totalRating'] = totalRating;
    if (inventoryArr != null) {
      data['inventoryArr'] = inventoryArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TypeOfProduct get checkProductType {
    if (isColorAvailable && isVariantAvailable) {
      return TypeOfProduct.SHOW_BOTH;
    } else if (isColorAvailable && isVariantAvailable == false) {
      return TypeOfProduct.SHOW_COLOR;
    } else if (isColorAvailable == false && isVariantAvailable) {
      return TypeOfProduct.SHOW_VARIANT;
    } else {
      return TypeOfProduct.SHOW_IMAGES;
    }
  }
}

class InventoryArr {
  String? inventoryId;
  String? uuid;
  String? productId;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;
  String? productDescription;
  String? customImage;
  String? percentageDis;
  String? isCustom;
  List<ProductImage>? productImage;

  InventoryArr(
      {this.inventoryId,
      this.uuid,
      this.productId,
      this.colorName,
      this.colorCode,
      this.variantName,
      this.variantAbbreviation,
      this.availability,
      this.sellPrice,
      this.isOffer,
      this.offerPrice,
      this.productDescription,
      this.customImage,
      this.percentageDis,
      this.isCustom,
      this.productImage});

  InventoryArr.fromJson(Map<String, dynamic> json) {
    inventoryId = json['inventoryId'];
    uuid = json['uuid'];
    productId = json['productId'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
    productDescription = json['productDescription'];
    customImage = json['customImage'];
    percentageDis = json['percentageDis'];
    isCustom = json['isCustom'];
    if (json['productImage'] != null) {
      productImage = <ProductImage>[];
      json['productImage'].forEach((v) {
        productImage!.add(ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inventoryId'] = inventoryId;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    data['productDescription'] = productDescription;
    data['customImage'] = customImage;
    data['percentageDis'] = percentageDis;
    data['isCustom'] = isCustom;
    if (productImage != null) {
      data['productImage'] = productImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImage {
  String? productImageId;
  String? productImage;

  ProductImage({this.productImageId, this.productImage});

  ProductImage.fromJson(Map<String, dynamic> json) {
    productImageId = json['productImageId'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productImageId'] = productImageId;
    data['productImage'] = productImage;
    return data;
  }
}

class VariantAbbreviation {
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;

  VariantAbbreviation({
    this.variantName,
    this.variantAbbreviation,
    this.availability,
    this.sellPrice,
    this.isOffer,
    this.offerPrice,
  });

  VariantAbbreviation.fromJson(Map<String, dynamic> json) {
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    return data;
  }
}

*/

// ignore: constant_identifier_names
/*enum TypeOfProduct { SHOW_BOTH, SHOW_COLOR, SHOW_VARIANT, SHOW_IMAGES }

class GetProductDetailModel {
  String? message;
  ProductDetails? productDetails;

  GetProductDetailModel({this.message, this.productDetails});

  GetProductDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    productDetails = json['productDetails'] != null
        ? ProductDetails.fromJson(json['productDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (productDetails != null) {
      data['productDetails'] = productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  bool isColorAvailable = false;
  bool isVariantAvailable = false;
  String? uuid;
  String? productId;
  String? inCart;
  String? inWishlist;
  String? productUuid;
  String? categoryId;
  String? subCategoryId;
  String? productName;
  String? sellerDescription;
  String? thumbnailImage;
  String? isColor;
  String? isVariant;
  String? vendorId;
  String? vendorName;
  String? vendorType;
  String? inStock;
  String? brandChartImg;
  String? createdDate;
  String? categoryName;
  String? categoryImage;
  String? subCategoryName;
  String? brandName;
  String? totalReview;
  String? totalRatting;
  List<InventoryArr>? inventoryArr;

  ProductDetails({
    this.uuid,
    this.productId,
    this.inCart,
    this.inWishlist,
    this.productUuid,
    this.categoryId,
    this.subCategoryId,
    this.productName,
    this.sellerDescription,
    this.thumbnailImage,
    this.isColor,
    this.isVariant,
    this.vendorId,
    this.vendorName,
    this.vendorType,
    this.inStock,
    this.brandChartImg,
    this.createdDate,
    this.categoryName,
    this.categoryImage,
    this.subCategoryName,
    this.brandName,
    this.totalReview,
    this.totalRatting,
    this.inventoryArr,
  });

  ProductDetails.fromJson(Map<String, dynamic> json) {
    isColorAvailable = json["isColor"] == "1";
    isVariantAvailable = json["isVariant"] == "1";
    uuid = json['uuid'];
    productId = json['productId'];
    inCart = json['inCart'];
    inWishlist = json['inWishlist'];
    productUuid = json['productUuid'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    productName = json['productName'];
    sellerDescription = json['sellerDescription'];
    thumbnailImage = json['thumbnailImage'];
    isColor = json['isColor'];
    isVariant = json['isVariant'];
    vendorId = json['venderId'];
    vendorName = json['vendorName'];
    vendorType = json['vendorType'];
    inStock = json['inStock'];
    brandChartImg = json['brandChartImg'];
    createdDate = json['createdDate'];
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
    subCategoryName = json['subCategoryName'];
    brandName = json['brandName'];
    totalReview = json['totalReview'];
    totalRatting = json['totalRating'];

    if (json['inventoryArr'] != null) {
      inventoryArr = <InventoryArr>[];
      json['inventoryArr'].forEach((v) {
        inventoryArr!.add(InventoryArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['inCart'] = inCart;
    data['inWishlist'] = inWishlist;
    data['productUuid'] = productUuid;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['productName'] = productName;
    data['sellerDescription'] = sellerDescription;
    data['thumbnailImage'] = thumbnailImage;
    data['isColor'] = isColor;
    data['isVariant'] = isVariant;
    data['venderId'] = vendorId;
    data['vendorName'] = vendorName;
    data['vendorType'] = vendorType;
    data['inStock'] = inStock;
    data['brandChartImg'] = brandChartImg;
    data['createdDate'] = createdDate;
    data['categoryName'] = categoryName;
    data['categoryImage'] = categoryImage;
    data['subCategoryName'] = subCategoryName;
    data['brandName'] = brandName;
    data['totalReview'] = totalReview;
    data['totalRating'] = totalRatting;
    if (inventoryArr != null) {
      data['inventoryArr'] = inventoryArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TypeOfProduct get checkProductType {
    if (isColorAvailable && isVariantAvailable) {
      return TypeOfProduct.SHOW_BOTH;
    } else if (isColorAvailable && isVariantAvailable == false) {
      return TypeOfProduct.SHOW_COLOR;
    } else if (isColorAvailable == false && isVariantAvailable) {
      return TypeOfProduct.SHOW_VARIANT;
    } else {
      return TypeOfProduct.SHOW_IMAGES;
    }
  }
}

class InventoryArr {
  String? inventoryId;
  String? uuid;
  String? productId;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;
  String? productDescription;
  String? percentageDis;
  List<Varient>? varientList;
  List<ProductImage>? productImageList;

  InventoryArr(
      {this.inventoryId,
      this.uuid,
      this.productId,
      this.colorName,
      this.colorCode,
      this.variantName,
      this.variantAbbreviation,
      this.availability,
      this.sellPrice,
      this.isOffer,
      this.offerPrice,
      this.productDescription,
      this.percentageDis,
      this.varientList,
      this.productImageList});

  InventoryArr.fromJson(Map<String, dynamic> json) {
    inventoryId = json['inventoryId'];
    uuid = json['uuid'];
    productId = json['productId'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
    productDescription = json['productDescription'];
    percentageDis = json['percentageDis'];
    if (json['varientList'] != null) {
      varientList = <Varient>[];
      json['varientList'].forEach((v) {
        varientList!.add(Varient.fromJson(v));
      });
    } else if (json['productImage'] != null) {
      productImageList = <ProductImage>[];
      json['productImage'].forEach((v) {
        productImageList!.add(ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inventoryId'] = inventoryId;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    data['productDescription'] = productDescription;
    data['percentageDis'] = percentageDis;
    */ /*if(typeOfProduct == TypeOfProduct.SHOW_BOTH) {
      if (varientList != null) {
        data['varientList'] = varientList!.map((v) => v.toJson()).toList();
      }
    }
    else {
        if (productImageList != null) {
          data['productImage'] = productImageList!.map((v) => v.toJson()).toList();
        }
      }*/ /*

    return data;
  }
}

class Varient {
  String? inventoryId;
  String? uuid;
  String? productId;
  String? colorName;
  String? colorCode;
  String? variantName;
  String? variantAbbreviation;
  String? availability;
  String? sellPrice;
  String? isOffer;
  String? offerPrice;
  String? productDescription;
  String? isActive;
  String? isDelete;
  String? createdDate;
  String? updatedDate;
  String? isCustom;
  String? percentageDis;
  List<ProductImage>? productImage;

  Varient(
      {this.inventoryId,
      this.uuid,
      this.productId,
      this.colorName,
      this.colorCode,
      this.variantName,
      this.variantAbbreviation,
      this.availability,
      this.sellPrice,
      this.isOffer,
      this.offerPrice,
      this.productDescription,
      this.isActive,
      this.isDelete,
      this.createdDate,
      this.updatedDate,
      this.isCustom,
      this.percentageDis,
      this.productImage});

  Varient.fromJson(Map<String, dynamic> json) {
    inventoryId = json['inventoryId'];
    uuid = json['uuid'];
    productId = json['productId'];
    colorName = json['colorName'];
    colorCode = json['colorCode'];
    variantName = json['variantName'];
    variantAbbreviation = json['variantAbbreviation'];
    availability = json['availability'];
    sellPrice = json['sellPrice'];
    isOffer = json['isOffer'];
    offerPrice = json['offerPrice'];
    productDescription = json['productDescription'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    isCustom = json['isCustom'];
    percentageDis = json['percentageDis'];
    if (json['productImage'] != null) {
      productImage = <ProductImage>[];
      json['productImage'].forEach((v) {
        productImage!.add(ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inventoryId'] = inventoryId;
    data['uuid'] = uuid;
    data['productId'] = productId;
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    data['variantName'] = variantName;
    data['variantAbbreviation'] = variantAbbreviation;
    data['availability'] = availability;
    data['sellPrice'] = sellPrice;
    data['isOffer'] = isOffer;
    data['offerPrice'] = offerPrice;
    data['productDescription'] = productDescription;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['isCustom'] = isCustom;
    data['percentageDis'] = percentageDis;
    if (productImage != null) {
      data['productImage'] = productImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImage {
  String? productImageId;
  String? productImage;

  ProductImage({this.productImageId, this.productImage});

  ProductImage.fromJson(Map<String, dynamic> json) {
    productImageId = json['productImageId'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productImageId'] = productImageId;
    data['productImage'] = productImage;
    return data;
  }
}*/

/*

class InventoryImages {
  List<Color>? listOfColor;
  List<Variant>? listOfVariant;
  List<ProductImage>? listOfImages;
  bool isColor = false;
  bool isVariant = false;

  InventoryImages.fromJson(Map<String, dynamic> json) {
    isColor = json["isColor"] == 1;
    isVariant = json["isVariant"] == 1;
    if (isColor) {
      json['color'].forEach((v) {
        listOfColor?.add(Color.fromJson(v));
      });
    } else if (isVariant) {
      json['variant'].forEach((v) {
        listOfVariant?.add(Variant.fromJson(v));
      });
    } else {
      json['productImage'].forEach((v) {
        listOfImages?.add(ProductImage.fromJson(v));
      });
    }
  }

  TypeOfProduct get checkProductType {
    if (isColor && isVariant) {
      return TypeOfProduct.SHOW_BOTH;
    } else if (isColor && isVariant == false) {
      return TypeOfProduct.SHOW_COLOR;
    } else if (isColor == false && isVariant) {
      return TypeOfProduct.SHOW_VARIANT;
    } else {
      return TypeOfProduct.SHOW_IMAGES;
    }
  }
}

class Color {
  List<Variant>? listOfVariant;
  List<ProductImage>? listOfImages;

  Color.fromJson(Map<String, dynamic> json) {
    if (json["isVariant"] == 1) {
      json['variant'].forEach((v) {
        listOfVariant?.add(Variant.fromJson(v));
      });
    } else {
      json['productImage'].forEach((v) {
        listOfImages?.add(ProductImage.fromJson(v));
      });
    }
  }
}

class Variant {
  List<ProductImage>? listOfImages;

  Variant.fromJson(Map<String, dynamic> json) {
    json['productImage'].forEach((v) {
      listOfImages?.add(ProductImage.fromJson(v));
    });
  }
}
*/
