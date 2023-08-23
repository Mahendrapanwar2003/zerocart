class GetProductListForHome {
  String? message;
  List<ProductList>? productList;

  GetProductListForHome({this.message, this.productList});

  GetProductListForHome.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
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

class ProductList {
  String? srNo;
  String? productId;
  String? inventoryId;
  String? brandId;
  String? uUID;
  String? productName;
  String? thumbnailImage;
  String? brandChartImg;
  String? brandName;
  String? categoryTypeName;
  String? fashionCatName;
  String? subCategoryName;
  String? productPrice;
  String? percentageDis;
  String? offerPrice;
  String? isOffer;

  ProductList(
      {this.srNo,
        this.productId,
        this.inventoryId,
        this.brandId,
        this.uUID,
        this.productName,
        this.thumbnailImage,
        this.brandChartImg,
        this.brandName,
        this.categoryTypeName,
        this.fashionCatName,
        this.subCategoryName,
        this.productPrice,
        this.percentageDis,
        this.offerPrice,
        this.isOffer});

  ProductList.fromJson(Map<String, dynamic> json) {
    srNo = json['srNo'];
    productId = json['productId'];
    inventoryId = json['inventoryId'];
    brandId = json['brandId'];
    uUID = json['UUID'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    brandChartImg = json['brandChartImg'];
    brandName = json['brandName'];
    categoryTypeName = json['categoryTypeName'];
    fashionCatName = json['fashionCatName'];
    subCategoryName = json['subCategoryName'];
    productPrice = json['productPrice'];
    percentageDis = json['percentageDis'];
    offerPrice = json['offerPrice'];
    isOffer = json['isOffer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['srNo'] = srNo;
    data['productId'] = productId;
    data['inventoryId'] = inventoryId;
    data['brandId'] = brandId;
    data['UUID'] = uUID;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['brandChartImg'] = brandChartImg;
    data['brandName'] = brandName;
    data['categoryTypeName'] = categoryTypeName;
    data['fashionCatName'] = fashionCatName;
    data['subCategoryName'] = subCategoryName;
    data['productPrice'] = productPrice;
    data['percentageDis'] = percentageDis;
    data['offerPrice'] = offerPrice;
    data['isOffer'] = isOffer;
    return data;
  }
}