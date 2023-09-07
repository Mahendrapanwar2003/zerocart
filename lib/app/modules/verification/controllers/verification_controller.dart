import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/modules/registration/controllers/registration_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../common_methods/common_methods.dart';
import '../../navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';

class VerificationController extends GetxController {
  final absorbing = false.obs;
  final key = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final isSubmitButtonVisible = true.obs;
  final timer = false.obs;

  String id = Get.arguments[0].toString();
  String buttonText = Get.arguments[1].toString();
  String otp = Get.arguments[2].toString();
  String type = Get.arguments[3].toString();
  String mobileNumber = Get.arguments[4].toString();
  final isClickOnLoginButton = false.obs;
  String deviceType = "";
  Map<String, dynamic> bodyParams = {};
  Map<String, dynamic> apiResponseMap = {};
  final userData = Rxn<UserData?>();

  Map<String, dynamic> responseDataOfSendOtp = {};
  String? fcmId;

  @override
  Future<void> onInit() async {
    super.onInit();
    deviceType = MyCommonMethods.getDeviceType();
    textEditingController.text = otp;
    fcmId = await FirebaseMessaging.instance.getToken();
    MyCommonMethods.setString(key: ApiKeyConstant.fcmId, value: fcmId ?? "");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  void clickOnScreen() {
    MyCommonMethods.unFocsKeyBoard();
  }

  void clickOnBackButton() {
    MyCommonMethods.unFocsKeyBoard();
    Get.back();
  }

  Future<void> clickOnLoginButton() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    isClickOnLoginButton.value = true;
    await matchOtpApiCalling();
    isClickOnLoginButton.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> matchOtpApiCalling() async {
    print("FCMID$fcmId");
    bodyParams = {
      ApiKeyConstant.mobile: mobileNumber,
      ApiKeyConstant.otp: textEditingController.text.trim().toString(),
      ApiKeyConstant.type: type,
      ApiKeyConstant.deviceType: deviceType,
      ApiKeyConstant.fcmId:fcmId.toString()
    };
    http.Response? response =
        await CommonApis.matchOtpApi(bodyParams: bodyParams);
    if (response != null) {
      apiResponseMap = jsonDecode(response.body);
      await afterMatchOtpWorking(response: response);
      if (id != "4") {
        textEditingController.text = '';
      }
      timer.value = false;
    }
  }

  Future<void> afterMatchOtpWorking({required http.Response response}) async {
    if (id == "1") {
      userData.value = UserData.fromJson(jsonDecode(response.body));
      if (userData.value != null) {
        MyCommonMethods.setString(
            key: ApiKeyConstant.token, value: userData.value!.customer!.token!);
        Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
      }
    } else if (id == "2") {
      await MyCommonMethods.setString(key: ApiKeyConstant.uuid, value: apiResponseMap[ApiKeyConstant.uuid]);
      Get.offNamed(Routes.RESET_PASSWORD, arguments: apiResponseMap[ApiKeyConstant.uuid]);
    } else if (id == "3") {
      RegistrationController registrationController = Get.find();
      registrationController.isSubmitButtonVisible.value = true;
      registrationController.isSendOtpVisible.value = false;
      Get.back();
    } else if (id == "4") {
      await MyCommonMethods.setString(key: ApiKeyConstant.token, value: "");
      await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: '');
      await MyCommonMethods.setString(key: ApiKeyConstant.stateId, value: '');
      await MyCommonMethods.setString(key: UserDataKeyConstant.selectedCity, value: '');
      await MyCommonMethods.setString(key: ApiKeyConstant.cityId, value: '');
      selectedIndex.value = 0;
      Get.deleteAll();
      Get.offAllNamed(Routes.SPLASH);
    } else {
      /*  MyCommonControllers.findEditProfileController();
      EditProfileController editProfileController=Get.find();
      editProfileController.isSubmitButtonVisible.value=true;
      editProfileController.isSendOtpVisible.value=false;
      Get.back();*/
    }
  }

  clickOnResendButton() async {
    timer.value = !timer.value;
    await sendOtpApiCalling(type: type);
  }

  Future<void> sendOtpApiCalling({required String type}) async {
    textEditingController.text = "";
    String? uuid = await MyCommonMethods.getString(key: ApiKeyConstant.uuid);
    if (uuid != "" && uuid != null) {
      bodyParams = {
        ApiKeyConstant.mobile: mobileNumber,
        ApiKeyConstant.countryCode: "+91",
        ApiKeyConstant.type: type,
        ApiKeyConstant.uuid: uuid,
      };
    } else {
      bodyParams = {
        ApiKeyConstant.mobile: mobileNumber,
        ApiKeyConstant.countryCode: "+91",
        ApiKeyConstant.type: type,
      };
    }

    http.Response? response =
        await CommonApis.sendOtpApi(bodyParams: bodyParams);
    if (response != null) {
      apiResponseMap = jsonDecode(response.body);
      MyCommonMethods.showSnackBar(
          message: apiResponseMap[ApiKeyConstant.otp].toString(),
          context: Get.context!);
      textEditingController.text =
          apiResponseMap[ApiKeyConstant.otp].toString();
    }
  }

/*clickOnContinue({String? dPtnrUuid, String? type}) {
    Get.back();
    if (type == ZerocartApiKey.registration) {
      Get.toNamed(Routes.ADD_ADDRESS,
          parameters: {"dPtnrUuid": dPtnrUuid ?? ''});
    } else {
      Get.toNamed(Routes.RESET_PASSWORD,
          parameters: {"dPtnrUuid": dPtnrUuid ?? ''});
    }
  }*/
}
