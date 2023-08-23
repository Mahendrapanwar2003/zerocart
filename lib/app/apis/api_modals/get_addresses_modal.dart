class GetCustomerAddresses {
  String? message;
  List<Addresses>? addresses;

  GetCustomerAddresses({this.message, this.addresses});

  GetCustomerAddresses.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add( Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String? addressId;
  String? uuid;
  String? customerId;
  String? name;
  String? phone;
  String? countryCode;
  String? pinCode;
  String? state;
  String? city;
  String? houseNo;
  String? colony;
  String? addressType;
  String? latitude;
  String? longitude;
  String? isDefaultAddress;
  String? isMyLocation;
  String? isDelete;
  String? createdDate;

  Addresses(
      {this.addressId,
        this.uuid,
        this.customerId,
        this.name,
        this.phone,
        this.countryCode,
        this.pinCode,
        this.state,
        this.city,
        this.houseNo,
        this.colony,
        this.addressType,
        this.latitude,
        this.longitude,
        this.isDefaultAddress,
        this.isMyLocation,
        this.isDelete,
        this.createdDate});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    uuid = json['uuid'];
    customerId = json['customerId'];
    name = json['name'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    pinCode = json['pinCode'];
    state = json['state'];
    city = json['city'];
    houseNo = json['houseNo'];
    colony = json['colony'];
    addressType = json['addressType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefaultAddress = json['isDefaultAddress'];
    isMyLocation = json['isMyLocation'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['addressId'] = addressId;
    data['uuid'] = uuid;
    data['customerId'] = customerId;
    data['name'] = name;
    data['phone'] = phone;
    data['countryCode'] = countryCode;
    data['pinCode'] = pinCode;
    data['state'] = state;
    data['city'] = city;
    data['houseNo'] = houseNo;
    data['colony'] = colony;
    data['addressType'] = addressType;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isDefaultAddress'] = isDefaultAddress;
    data['isMyLocation'] = isMyLocation;
    data['isDelete'] = isDelete;
    data['createdDate'] = createdDate;
    return data;
  }
}
