class GetAllBrandListApiModel {
  String? message;
  List<BrandList>? brandList;

  GetAllBrandListApiModel({this.message, this.brandList});

  GetAllBrandListApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['brandList'] != null) {
      brandList = <BrandList>[];
      json['brandList'].forEach((v) {
        brandList!.add(BrandList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (brandList != null) {
      data['brandList'] = brandList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandList {
  String? brandId;
  String? uuid;
  String? brandName;

  BrandList({this.brandId, this.uuid, this.brandName});

  BrandList.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    uuid = json['uuid'];
    brandName = json['brandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brandId'] = brandId;
    data['uuid'] = uuid;
    data['brandName'] = brandName;
    return data;
  }
}
