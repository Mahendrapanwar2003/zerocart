import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

import '../../../../my_common_method/my_common_method.dart';

class ResetPasswordController extends GetxController {
  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final absorbing = false.obs;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final isLoginButtonClicked = false.obs;
  final uuid = Get.arguments;
  Map<String, dynamic> bodyParamsForResetPassword = {};
  Map<String, dynamic> responseMap = {};

  @override
  void onInit() {
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

  void clickOnPasswordEyeButton() {
    passwordVisible.value = !passwordVisible.value;
  }

  void clickOnConfirmPasswordEyeButton() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  void clickOnBackButton() {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    Get.back();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnLoginButton() async {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    if (key.currentState!.validate()) {
      isLoginButtonClicked.value = true;
      await callingResetPasswordApi();
      isLoginButtonClicked.value = false;
    }

    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> callingResetPasswordApi() async {

    bodyParamsForResetPassword = {
      ApiKeyConstant.uuid: uuid,
      ApiKeyConstant.password: passwordController.text.trim().toString(),
    };

    http.Response? response =
        await CommonApis.resetPasswordApi(bodyParams: bodyParamsForResetPassword);
    if (response != null) {
      responseMap = jsonDecode(response.body);
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
