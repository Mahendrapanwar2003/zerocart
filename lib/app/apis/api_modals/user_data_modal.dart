class UserData {
  String? message;
  Customer? customer;

  UserData({this.message, this.customer});

    UserData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    customer = json['customer'] != null
        ?  Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? customerId;
  String? uuid;
  String? fullName;
  String? email;
  String? mobile;
  String? countryCode;
  String? isMobileVerified;
  String? password;
  String? deviceType;
  String? fcmId;
  String? otp;
  String? profilePicture;
  String? dob;
  String? securityEmail;
  String? securityPhone;
  String? securityPhoneCountryCode;
  String? walletAmount;
  String? loginType;
  String? isRegister;
  String? isActive;
  String? isDelete;
  String? createdDate;
  String? updatedDate;
  String? token;
  String? totalEmpty;
  String? totalComplete;
  String? progress;
  String? categoryPreferences;
  String? brandPreferences;
  String? genderPreferences;
  String? countryId;
  String? stateId;
  String? countryName;
  String? stateName;
  String? cityName;
  String? customerPreferenceId;
  String? categoryPreferenceName;
  String? brandPreferenceName;


  Customer(
      {this.customerId,
        this.uuid,
        this.fullName,
        this.email,
        this.mobile,
        this.countryCode,
        this.isMobileVerified,
        this.password,
        this.deviceType,
        this.fcmId,
        this.otp,
        this.profilePicture,
        this.dob,
        this.securityEmail,
        this.securityPhone,
        this.securityPhoneCountryCode,
        this.walletAmount,
        this.loginType,
        this.isRegister,
        this.isActive,
        this.isDelete,
        this.createdDate,
        this.updatedDate,
        this.token,
        this.totalEmpty,
        this.totalComplete,
        this.progress,
        this.categoryPreferences,
        this.brandPreferences,
        this.genderPreferences,
        this.countryId,
        this.stateId,
        this.countryName,
        this.stateName,
        this.cityName,
        this.customerPreferenceId,
        this.brandPreferenceName,
        this.categoryPreferenceName,
      });

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    uuid = json['uuid'];
    fullName = json['fullName'];
    email = json['email'];
    mobile = json['mobile'];
    countryCode = json['countryCode'];
    isMobileVerified = json['isMobileVerified'];
    password = json['password'];
    deviceType = json['deviceType'];
    fcmId = json['fcmId'];
    otp = json['otp'];
    profilePicture = json['profilePicture'];
    dob = json['dob'];
    securityEmail = json['securityEmail'];
    securityPhone = json['securityPhone'];
    securityPhoneCountryCode = json['securityPhoneCountryCode'];
    walletAmount = json['walletAmount'];
    loginType = json['loginType'];
    isRegister = json['isRegister'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    token = json['token'];
    totalEmpty = json['totalEmpty'];
    totalComplete = json['totalComplete'];
    progress = json['progress'];
    categoryPreferences = json['categoryPreferences'];
    brandPreferences = json['brandPreferences'];
    genderPreferences = json['genderPreferences'];
    countryId = json['countryId'];
    stateId = json['stateId'];
    countryName = json['countryName'];
    stateName = json['stateName'];
    cityName = json['cityName'];
    customerPreferenceId = json['customerPreferenceId'];
    categoryPreferenceName = json['categoryPreferenceName'];
    brandPreferenceName = json['brandPreferenceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['customerId'] = customerId;
    data['uuid'] = uuid;
    data['fullName'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['countryCode'] = countryCode;
    data['isMobileVerified'] = isMobileVerified;
    data['password'] = password;
    data['deviceType'] = deviceType;
    data['fcmId'] = fcmId;
    data['otp'] = otp;
    data['profilePicture'] = profilePicture;
    data['dob'] = dob;
    data['securityEmail'] = securityEmail;
    data['securityPhone'] = securityPhone;
    data['securityPhoneCountryCode'] = securityPhoneCountryCode;
    data['walletAmount'] = walletAmount;
    data['loginType'] = loginType;
    data['isRegister'] = isRegister;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['token'] = token;
    data['totalEmpty'] = totalEmpty;
    data['totalComplete'] = totalComplete;
    data['progress'] = progress;
    data['categoryPreferences'] = categoryPreferences;
    data['brandPreferences'] = brandPreferences;
    data['genderPreferences'] = genderPreferences;
    data['countryId'] = countryId;
    data['stateId'] = stateId;
    data['countryName'] = countryName;
    data['stateName'] = stateName;
    data['cityName'] = cityName;
    data['customerPreferenceId'] = customerPreferenceId;
    data['brandPreferenceName'] = brandPreferenceName;
    data['categoryPreferenceName'] = categoryPreferenceName;
    return data;
  }
}
