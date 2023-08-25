class GetApplyCouponModal {
  String? message;
  Result? result;

  GetApplyCouponModal({this.message, this.result});

  GetApplyCouponModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
    json['result'] != null ?  Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? resStatus;
  String? resMessage;
  String? couponId;
  String? couponCode;
  String? totalPrice;
  String? couponDisPrice;
  String? discount;

  Result(
      {this.resStatus,
        this.resMessage,
        this.couponId,
        this.couponCode,
        this.totalPrice,
        this.couponDisPrice,
        this.discount});

  Result.fromJson(Map<String, dynamic> json) {
    resStatus = json['resStatus'];
    resMessage = json['resMessage'];
    couponId = json['couponId'];
    couponCode = json['couponCode'];
    totalPrice = json['totalPrice'];
    couponDisPrice = json['couponDisPrice'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['resStatus'] = resStatus;
    data['resMessage'] = resMessage;
    data['couponId'] = couponId;
    data['couponCode'] = couponCode;
    data['totalPrice'] = totalPrice;
    data['couponDisPrice'] = couponDisPrice;
    data['discount'] = discount;
    return data;
  }
}
