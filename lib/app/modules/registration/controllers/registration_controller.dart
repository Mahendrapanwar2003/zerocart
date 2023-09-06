import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_all_brand_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_all_fashion_category_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_city_model.dart';
import 'package:zerocart/app/apis/api_modals/get_state_model.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  Map<String, dynamic> userFirebaseData = Get.arguments;
  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final absorbing = false.obs;
  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final isSendOtpVisible = true.obs;
  final isStateSelectedValue = false.obs;
  final isCitySelectedValue = false.obs;
  final isSubmitButtonVisible = false.obs;
  final isSubmitButtonClicked = false.obs;
  final isSendOtpButtonClicked = false.obs;
  final isVisibleIcon = false.obs;
  final isCityTextFieldNotVisible = true.obs;
  String deviceType = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String countryId = "101";

  Map<String, dynamic> queryParametersState = {};
  final stateModel = Rxn<StateModel?>();
  List<States>? statesList;
  final selectedState = Rxn<States?>();
  String stateId = '';

  Map<String, dynamic> queryParametersCity = {};
  final cityModel = Rxn<CityModel?>();
  List<Cities>? citiesList;
  final selectedCity = Rxn<Cities?>();
  String cityId = '';

  final getAllBrandListApiModel = Rxn<GetAllBrandListApiModel?>();
  final getAllFashionCategoryListApiModel =
      Rxn<GetAllFashionCategoryListApiModel?>();
  List<BrandList>? brandList;
  List<FashionCategoryList>? fashionCategoryList;
  Map<String, dynamic> bodyParamsForSendOtp = {};
  Map<String, dynamic> sendOtpApiResponse = {};

  Map<String, dynamic> bodyParamsForSubmitApi = {};
  final userData = Rxn<UserData?>();

  //TODO This Code ADD By Aman
  final checkTypeOfProductsValue = '-1'.obs;
  final checkValue = true.obs;

  final isResponse = false.obs;

  List checkBoxTitle = [
    'Men',
    'Women',
    'Unisex',
  ];

  final selectedBrands = [].obs;
  List idBrand = [];
  List fashionCategoryId = [];
  final selectedFashionCategory = [].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    emailController.text = userFirebaseData["email"];
    deviceType = MyCommonMethods.getDeviceType();
    await getStateApiCalling();
    await getAllFashionCategoryListApiCalling();
    await getAllBrandListApiCalling();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sendOtpApiCalling({required String type}) async {
    String? uuid = await MyCommonMethods.getString(key: ApiKeyConstant.uuid);
    bodyParamsForSendOtp = {
      ApiKeyConstant.mobile: mobileNumberController.text.trim().toString(),
      ApiKeyConstant.countryCode: "+91",
      ApiKeyConstant.type: type,
      ApiKeyConstant.uuid: uuid,
    };
    http.Response? response =
        await CommonApis.sendOtpApi(bodyParams: bodyParamsForSendOtp);
    if (response != null) {
      sendOtpApiResponse = jsonDecode(response.body);
      Get.toNamed(Routes.VERIFICATION, arguments: [
        3,
        "Submit",
        sendOtpApiResponse[ApiKeyConstant.otp],
        "registration",
        mobileNumberController.text.toString().trim()
      ]);
    }
  }

  Future<void> registrationApiCalling() async {
    String? uuid = await MyCommonMethods.getString(key: ApiKeyConstant.uuid);
    String? fcmId = await MyFirebaseSignIn.getUserFcmId(context: Get.context!);
    String gender = "";
    if (checkTypeOfProductsValue.toString() == "0") {
      gender = "m";
    } else if (checkTypeOfProductsValue.toString() == "1") {
      gender = "f";
    } else if (checkTypeOfProductsValue.toString() == "2") {
      gender = "m,f";
    } else {
      gender = "";
    }
    bodyParamsForSubmitApi = {
      ApiKeyConstant.fullName: nameController.text.trim().toString(),
      ApiKeyConstant.uuid: uuid,
      ApiKeyConstant.password: passwordController.text.trim().toString(),
      ApiKeyConstant.deviceType: deviceType,
      ApiKeyConstant.fcmId: fcmId,
      ApiKeyConstant.countryId: countryId,
      ApiKeyConstant.stateId: stateId ?? "",
      ApiKeyConstant.cityId: cityId ?? "",
      ApiKeyConstant.genderPreferences: gender,
      ApiKeyConstant.brandPreferences:
          idBrand.isNotEmpty ? idBrand.join(',') : '',
      ApiKeyConstant.categoryPreferences:
          fashionCategoryId.isNotEmpty ? fashionCategoryId.join(',') : ''
    };
    userData.value =
        await CommonApis.registrationApi(bodyParams: bodyParamsForSubmitApi);
    if (userData.value != null) {
      MyCommonMethods.showSnackBar(
          message: "Registered Successfully", context: Get.context!);
      Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
    }
  }

  Future<void> getStateApiCalling() async {
    queryParametersState = {ApiKeyConstant.countryId: countryId};
    stateModel.value =
        await CommonApis.getStateApi(queryParameters: queryParametersState);
    if (stateModel.value != null) {
      statesList = stateModel.value?.states;
      //selectedState = statesList?.first;
    }
  }

  Future<void> getCityApiCalling({required String sId}) async {
    selectedCity.value = null;
    queryParametersCity = {ApiKeyConstant.stateId: sId};
    cityModel.value =
        await CommonApis.getCityApi(queryParameters: queryParametersCity);
    if (cityModel.value != null) {
      citiesList = cityModel.value?.cities;
    }
  }

  Future<void> getAllBrandListApiCalling() async {
    getAllBrandListApiModel.value = await CommonApis.getAllBrandListApi();
    if (getAllBrandListApiModel.value != null) {
      brandList = getAllBrandListApiModel.value?.brandList;
    }
    isResponse.value = true;
  }

  Future<void> getAllFashionCategoryListApiCalling() async {
    getAllFashionCategoryListApiModel.value =
        await CommonApis.getAllFashionCategoryListApi();
    if (getAllFashionCategoryListApiModel.value != null) {
      fashionCategoryList =
          getAllFashionCategoryListApiModel.value?.fashionCategoryList;
    }
  }

  void increment() => count.value++;

  void clickOnPasswordEyeButton() {
    passwordVisible.value = !passwordVisible.value;
  }

  void clickOnConfirmPasswordEyeButton() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  Future<void> clickOnSendOtpButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    isSendOtpButtonClicked.value = true;
    await sendOtpApiCalling(type: 'registration');
    isSendOtpButtonClicked.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnSubmitButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    dropDownValidationChecker();
    if (key.currentState!.validate() && !isStateSelectedValue.value && !isCitySelectedValue.value) {
      isSubmitButtonClicked.value = true;
      if (checkTypeOfProductsValue.toString()=="-1" &&
          idBrand.isEmpty &&
          fashionCategoryId.isEmpty) {
        await registrationApiCalling();
      } else if ((checkTypeOfProductsValue.toString()!="-1" &&
          idBrand.isNotEmpty &&
          fashionCategoryId.isNotEmpty)) {
        await registrationApiCalling();
      }else
        {
         MyCommonMethods.showSnackBar(message: "All field required", context: Get.context!);
        }
      isSubmitButtonClicked.value = false;
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void dropDownValidationChecker()  {
    if (selectedState.value == null && stateId == '') {
      isStateSelectedValue.value = true;
    } else {
      isStateSelectedValue.value = false;
    }

    if (selectedCity.value == null && cityId == '') {
      isCitySelectedValue.value = true;
    } else {
      isCitySelectedValue.value = false;
    }
  }


}
