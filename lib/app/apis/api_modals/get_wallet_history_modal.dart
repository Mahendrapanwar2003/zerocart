class GetWalletHistoryModel {
  String? message;
  List<WalletHistory>? walletHistory;

  GetWalletHistoryModel({this.message, this.walletHistory});

  GetWalletHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['walletHistory'] != null) {
      walletHistory = <WalletHistory>[];
      json['walletHistory'].forEach((v) {
        walletHistory!.add( WalletHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (walletHistory != null) {
      data['walletHistory'] =
          walletHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletHistory {
  String? wltId;
  String? uUID;
  String? customerId;
  String? couponId;
  String? orderId;
  String? transId;
  String? transType;
  String? actionType;
  String? inAmt;
  String? outAmt;
  String? alltrans;
  String? balance;
  String? createdDate;

  WalletHistory(
      {this.wltId,
        this.uUID,
        this.customerId,
        this.couponId,
        this.orderId,
        this.transId,
        this.transType,
        this.actionType,
        this.inAmt,
        this.outAmt,
        this.alltrans,
        this.balance,
        this.createdDate});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    wltId = json['wltId'];
    uUID = json['UUID'];
    customerId = json['customerId'];
    couponId = json['couponId'];
    orderId = json['orderId'];
    transId = json['transId'];
    transType = json['transType'];
    actionType = json['actionType'];
    inAmt = json['inAmt'];
    outAmt = json['outAmt'];
    alltrans = json['alltrans'];
    balance = json['Balance'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['wltId'] = wltId;
    data['UUID'] = uUID;
    data['customerId'] = customerId;
    data['couponId'] = couponId;
    data['orderId'] = orderId;
    data['transId'] = transId;
    data['transType'] = transType;
    data['actionType'] = actionType;
    data['inAmt'] = inAmt;
    data['outAmt'] = outAmt;
    data['alltrans'] = alltrans;
    data['Balance'] = balance;
    data['createdDate'] = createdDate;
    return data;
  }
}