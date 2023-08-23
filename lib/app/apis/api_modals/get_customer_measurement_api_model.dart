class GetCustomerMeasurementApiModel {
  String? message;
  Measurement? measurement;

  GetCustomerMeasurementApiModel({this.message, this.measurement});

  GetCustomerMeasurementApiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    measurement = json['measurement'] != null
        ? Measurement.fromJson(json['measurement'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (measurement != null) {
      data['measurement'] = measurement!.toJson();
    }
    return data;
  }
}

class Measurement {
  dynamic chest;
  dynamic arm;
  dynamic shoulder;
  dynamic waist;
  dynamic neck;
  dynamic height;
  dynamic weight;
  dynamic bMI;

  Measurement(
      {this.chest,
        this.arm,
        this.shoulder,
        this.waist,
        this.neck,
        this.height,
        this.weight,
        this.bMI});

  Measurement.fromJson(Map<String, dynamic> json) {
    chest = json['Chest'];
    arm = json['Arm'];
    shoulder = json['Shoulder'];
    waist = json['Waist'];
    neck = json['Neck'];
    height = json['Height'];
    weight = json['Weight'];
    bMI = json['BMI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Chest'] = chest;
    data['Arm'] = arm;
    data['Shoulder'] = shoulder;
    data['Waist'] = waist;
    data['Neck'] = neck;
    data['Height'] = height;
    data['Weight'] = weight;
    data['BMI'] = bMI;
    return data;
  }
}
