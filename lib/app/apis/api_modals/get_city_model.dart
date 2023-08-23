class CityModel {
  String? message;
  List<Cities>? cities;

  CityModel({this.message, this.cities});

  CityModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add( Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? id;
  String? name;
  String? stateId;
  String? stateCode;
  String? countryId;
  String? countryCode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? flag;
  String? wikiDataId;

  Cities(
      {this.id,
        this.name,
        this.stateId,
        this.stateCode,
        this.countryId,
        this.countryCode,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.flag,
        this.wikiDataId});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    stateCode = json['state_code'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
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
    data['state_id'] = stateId;
    data['state_code'] = stateCode;
    data['country_id'] = countryId;
    data['country_code'] = countryCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['flag'] = flag;
    data['wikiDataId'] = wikiDataId;
    return data;
  }
}