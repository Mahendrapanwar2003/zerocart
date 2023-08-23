class GetCancelOrderReasonList {
  String? message;
  List<CancelReasonList>? cancelReasonList;

  GetCancelOrderReasonList({this.message, this.cancelReasonList});

  GetCancelOrderReasonList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['cancelReasonList'] != null) {
      cancelReasonList = <CancelReasonList>[];
      json['cancelReasonList'].forEach((v) {
        cancelReasonList!.add(CancelReasonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (cancelReasonList != null) {
      data['cancelReasonList'] =
          cancelReasonList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CancelReasonList {
  String? cnclRsnId;
  String? uuid;
  String? reason;
  String? createdDate;

  CancelReasonList({this.cnclRsnId, this.uuid, this.reason, this.createdDate});

  CancelReasonList.fromJson(Map<String, dynamic> json) {
    cnclRsnId = json['cnclRsnId'];
    uuid = json['uuid'];
    reason = json['reason'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cnclRsnId'] = cnclRsnId;
    data['uuid'] = uuid;
    data['reason'] = reason;
    data['createdDate'] = createdDate;
    return data;
  }
}