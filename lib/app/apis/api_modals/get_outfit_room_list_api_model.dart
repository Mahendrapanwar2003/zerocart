import 'package:zerocart/app/apis/api_modals/get_buy_now_modal.dart';

class GetOutfitRoomListApiModel {
  String? message;
  List<OutfitRoomList>? outfitRoomList;

  GetOutfitRoomListApiModel({this.message, this.outfitRoomList});

  GetOutfitRoomListApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['OutfitRoomList'] != null) {
      outfitRoomList = <OutfitRoomList>[];
      json['OutfitRoomList'].forEach((v) {
        outfitRoomList!.add(OutfitRoomList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (outfitRoomList != null) {
      data['OutfitRoomList'] =
          outfitRoomList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutfitRoomList {
  String? srNo;
  String? categoryTypeId;
  String? categoryTypeName;
  String? porductDetail;

  OutfitRoomList(
      {this.srNo,
        this.categoryTypeId,
        this.categoryTypeName,
        this.porductDetail});

  OutfitRoomList.fromJson(Map<String, dynamic> json) {
    srNo = json['srNo'];
    categoryTypeId = json['categoryTypeId'];
    categoryTypeName = json['categoryTypeName'];
    porductDetail = json['porductDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['srNo'] = srNo;
    data['categoryTypeId'] = categoryTypeId;
    data['categoryTypeName'] = categoryTypeName;
    data['porductDetail'] = porductDetail;
    return data;
  }
}
class PorductDetail {
  int? outfitRoomId;
  String? uuid;
  int? customerId;
  int? productId;
  String? productName;
  String? thumbnailImage;
  int? inventoryId;

  PorductDetail(
      {this.outfitRoomId,
      this.uuid,
      this.customerId,
      this.productId,
      this.productName,
      this.thumbnailImage,
      this.inventoryId});

  PorductDetail.fromJson(Map<String, dynamic> json) {
    outfitRoomId = json['outfitRoomId'];
    uuid = json['uuid'];
    customerId = json['customerId'];
    productId = json['productId'];
    productName = json['productName'];
    thumbnailImage = json['thumbnailImage'];
    inventoryId = json['inventoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outfitRoomId'] = outfitRoomId;
    data['uuid'] = uuid;
    data['customerId'] = customerId;
    data['productId'] = productId;
    data['productName'] = productName;
    data['thumbnailImage'] = thumbnailImage;
    data['inventoryId'] = inventoryId;
    return data;
  }
}
