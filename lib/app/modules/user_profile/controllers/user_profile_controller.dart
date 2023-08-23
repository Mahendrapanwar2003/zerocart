import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';

class UserProfileController extends GetxController {

  final count = 0.obs;
  final userData={}.obs;
  DateTime? dateTime;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void clickOnBackIcon({required BuildContext context}) async {
    Get.back();
  }

  onWillPop({required BuildContext context}) async {
    clickOnBackIcon(context: context);
  }

  Future<void> getUserData()
  async {
    userData.value=await CommonMethods.getUserData() ?? {};
    dateTime = DateTime.parse(userData[UserDataKeyConstant.lastUpdate]);
  }

  String getDayOfMonthSuffix(int dayNum) {
    if(!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }
    if(dayNum >= 10) {
      return '$dayNum';
    }else{
      return '0$dayNum';
    }
  }

  String getMonthOfYearSuffix(int monthNum) {
    if(!(monthNum >= 1 && monthNum <= 12)) {
      throw Exception('Invalid month of Year');
    }

    if(monthNum >= 10) {
      return '$monthNum';
    }

    switch(monthNum % 10) {
      case 1: return '0$monthNum';
      case 2: return '0$monthNum';
      case 3: return '0$monthNum';
      default: return '0$monthNum';
    }
  }
}
