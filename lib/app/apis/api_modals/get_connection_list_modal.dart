class GetConnectionListModal {
  String? message;
  List<Connections>? connections;

  GetConnectionListModal({this.message, this.connections});

  GetConnectionListModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['connections'] != null) {
      connections = <Connections>[];
      json['connections'].forEach((v) {
        connections!.add( Connections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (connections != null) {
      data['connections'] = connections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Connections {
  String? connectionId;
  String? uuid;
  String? qaId;
  String? customerId;
  String? prscrpId;
  String? connectionStatus;
  String? createdDate;
  String? qaName;
  String? qaImage;

  Connections(
      {this.connectionId,
        this.uuid,
        this.qaId,
        this.customerId,
        this.prscrpId,
        this.connectionStatus,
        this.createdDate,
        this.qaName,
        this.qaImage});

  Connections.fromJson(Map<String, dynamic> json) {
    connectionId = json['connectionId'];
    uuid = json['uuid'];
    qaId = json['qaId'];
    customerId = json['customerId'];
    prscrpId = json['prscrpId'];
    connectionStatus = json['connectionStatus'];
    createdDate = json['createdDate'];
    qaName = json['qaName'];
    qaImage = json['qaImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['connectionId'] = connectionId;
    data['uuid'] = uuid;
    data['qaId'] = qaId;
    data['customerId'] = customerId;
    data['prscrpId'] = prscrpId;
    data['connectionStatus'] = connectionStatus;
    data['createdDate'] = createdDate;
    data['qaName'] = qaName;
    data['qaImage'] = qaImage;
    return data;
  }
}