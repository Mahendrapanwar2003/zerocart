class GetNotificationApiModel {
  String? message;
  List<NotificationList>? notificationList;

  GetNotificationApiModel({this.message, this.notificationList});

  GetNotificationApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['notificationList'] != null) {
      notificationList = <NotificationList>[];
      json['notificationList'].forEach((v) {
        notificationList!.add(NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (notificationList != null) {
      data['notificationList'] =
          notificationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  String? notifyId;
  String? customerId;
  String? dPtnrId;
  String? notificationFor;
  String? notificationType;
  String? notificationText;
  String? isRead;
  String? pageRedirect;
  String? notificationJSONData;
  String? createdDate;

  NotificationList(
      {this.notifyId,
        this.customerId,
        this.dPtnrId,
        this.notificationFor,
        this.notificationType,
        this.notificationText,
        this.isRead,
        this.pageRedirect,
        this.notificationJSONData,
        this.createdDate});

  NotificationList.fromJson(Map<String, dynamic> json) {
    notifyId = json['notifyId'];
    customerId = json['customerId'];
    dPtnrId = json['dPtnrId'];
    notificationFor = json['notificationFor'];
    notificationType = json['notificationType'];
    notificationText = json['notificationText'];
    isRead = json['isRead'];
    pageRedirect = json['pageRedirect'];
    notificationJSONData = json['notificationJSONData'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notifyId'] = notifyId;
    data['customerId'] = customerId;
    data['dPtnrId'] = dPtnrId;
    data['notificationFor'] = notificationFor;
    data['notificationType'] = notificationType;
    data['notificationText'] = notificationText;
    data['isRead'] = isRead;
    data['pageRedirect'] = pageRedirect;
    data['notificationJSONData'] = notificationJSONData;
    data['createdDate'] = createdDate;
    return data;
  }
}
