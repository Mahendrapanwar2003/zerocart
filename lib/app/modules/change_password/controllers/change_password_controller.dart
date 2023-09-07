import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:http/http.dart' as http;

import '../../../../my_common_method/my_common_method.dart';

class ChangePasswordController extends GetxController {
  final key = GlobalKey<FormState>();
  final absorbing=false.obs;
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final currentPasswordVisible = false.obs;
  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final isContinueButtonClicked= false.obs;
  Map<String, dynamic> bodyParams = {};
  Map<String, dynamic> responseMap = {};


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


  Future<void> changePasswordApiCalling({required BuildContext context}) async {
    bodyParams = {
      ApiKeyConstant.oldPassword:
      currentPasswordController.text.trim().toString(),
      ApiKeyConstant.newPassword: passwordController.text.trim().toString(),
    };
    http.Response? response =
    await CommonApis.changePasswordApi(bodyParams: bodyParams);
    if (response != null) {
      responseMap = jsonDecode(response.body);
      absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();
      isContinueButtonClicked.value=false;
      // ignore: use_build_context_synchronously
      clickOnBackIcon(context: context);
    }
    else
    {
      absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();
      isContinueButtonClicked.value=false;
    }

  }

  void clickOnBackIcon({required BuildContext context}) async {
    Get.back();
  }

  onWillPop({required BuildContext context}) async {
    clickOnBackIcon(context: context);
  }

  void clickOnCurrentPasswordEyeButton() {
    currentPasswordVisible.value = !currentPasswordVisible.value;
  }

  void clickOnPasswordEyeButton() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> clickOnConfirmPasswordEyeButton() async {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  Future<void> clickOnContinueButton({required BuildContext context}) async {
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    if (key.currentState!.validate()) {
      isContinueButtonClicked.value=true;
      await changePasswordApiCalling(context: context);
    }
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();
  }



}
