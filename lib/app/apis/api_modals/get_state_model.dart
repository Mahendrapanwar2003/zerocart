class StateModel {
  String? message;
  List<States>? states;
  List<States> statesSearch = [];

  StateModel({this.message, this.states});

  StateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add( States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  String? id;
  String? name;
  String? countryId;
  String? countryCode;
  String? fipsCode;
  String? iso2;
  String? type;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? flag;
  String? wikiDataId;

  States(
      {this.id,
        this.name,
        this.countryId,
        this.countryCode,
        this.fipsCode,
        this.iso2,
        this.type,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.flag,
        this.wikiDataId});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
    fipsCode = json['fips_code'];
    iso2 = json['iso2'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wikiDataId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    data['country_code'] = countryCode;
    data['fips_code'] = fipsCode;
    data['iso2'] = iso2;
    data['type'] = type;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['flag'] = flag;
    data['wikiDataId'] = wikiDataId;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    // TODO: instance convert Modal Data
    return toJson().toString();
  }
}