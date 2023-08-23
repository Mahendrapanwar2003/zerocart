class GetConnectionDetail {
  String? message;
  List<ConnectionData>? connectionData;

  GetConnectionDetail({this.message, this.connectionData});

  GetConnectionDetail.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['connectionData'] != null) {
      connectionData = <ConnectionData>[];
      json['connectionData'].forEach((v) {
        connectionData!.add( ConnectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (connectionData != null) {
      data['connectionData'] =
          connectionData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConnectionData {
  String? messageId;
  String? connectionId;
  String? uuid;
  String? senderId;
  String? reciverId;
  String? messageSendBy;
  String? message;
  String? messageFile;
  String? createdDate;
  String? qaName;

  ConnectionData(
      {this.messageId,
        this.connectionId,
        this.uuid,
        this.senderId,
        this.reciverId,
        this.messageSendBy,
        this.message,
        this.messageFile,
        this.createdDate,
        this.qaName});

  ConnectionData.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    connectionId = json['connectionId'];
    uuid = json['uuid'];
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    messageSendBy = json['messageSendBy'];
    message = json['message'];
    messageFile = json['messageFile'];
    createdDate = json['createdDate'];
    qaName = json['qaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['messageId'] = messageId;
    data['connectionId'] = connectionId;
    data['uuid'] = uuid;
    data['senderId'] = senderId;
    data['reciverId'] = reciverId;
    data['messageSendBy'] = messageSendBy;
    data['message'] = message;
    data['messageFile'] = messageFile;
    data['createdDate'] = createdDate;
    data['qaName'] = qaName;
    return data;
  }
}