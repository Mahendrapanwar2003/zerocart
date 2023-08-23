class GetBanner {
  String? message;
  List<Banners>? banner;

  GetBanner({this.message, this.banner});

  GetBanner.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['banner'] != null) {
      banner = <Banners>[];
      json['banner'].forEach((v) {
        banner!.add( Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['message'] = message;
    if (banner != null) {
      data['banner'] = banner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? bannerId;
  String? uuid;
  String? bannerImage;
  String? isActive;
  String? createdDate;

  Banners(
      {this.bannerId,
        this.uuid,
        this.bannerImage,
        this.isActive,
        this.createdDate});

  Banners.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    uuid = json['uuid'];
    bannerImage = json['bannerImage'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bannerId'] = bannerId;
    data['uuid'] = uuid;
    data['bannerImage'] = bannerImage;
    data['isActive'] = isActive;
    data['createdDate'] = createdDate;
    return data;
  }
}