import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

import '../../../../my_common_method/my_common_method.dart';

class ForgotPasswordController extends GetxController {
  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final absorbing=false.obs;
  final mobileNumberController = TextEditingController();
  final isClickOnSendOtpButton = false.obs;
  Map<String, dynamic> bodyParams = {};
  Map<String, dynamic> responseDataOfSendOtp= {};


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> clickOnSendOtpButton() async {
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    if (key.currentState!.validate()) {
      isClickOnSendOtpButton.value=true;
      await sendOtpApiCalling(type: 'forgetPassword');
      isClickOnSendOtpButton.value=false;
    }
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> sendOtpApiCalling({required String type}) async {
    bodyParams = {
      ApiKeyConstant.mobile: mobileNumberController.text.trim().toString(),
      ApiKeyConstant.countryCode: "+91",
      ApiKeyConstant.type: type,
    };
    http.Response? response =
        await CommonApis.sendOtpApi(bodyParams: bodyParams);
    if (response != null) {
      responseDataOfSendOtp = jsonDecode(response.body);
      Get.toNamed(Routes.VERIFICATION, arguments: [
        2,
        "Submit",
        responseDataOfSendOtp[ApiKeyConstant.otp],
        "forgetPassword",
        mobileNumberController.text.trim().toString()
      ]);
    }
  }

  void clickOnBackButton() {
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    Get.back();
    absorbing.value= CommonMethods.changeTheAbsorbingValueFalse();
  }
}
