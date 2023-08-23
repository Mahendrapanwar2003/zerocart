class DashboardDetailModel {
  String? message;
  String? notificationCount;

  DashboardDetailModel({this.message, this.notificationCount});

  DashboardDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    notificationCount = json['notificationCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['notificationCount'] = notificationCount;
    return data;
  }
}
