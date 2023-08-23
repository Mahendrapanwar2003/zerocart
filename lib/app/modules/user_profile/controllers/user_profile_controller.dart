import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';

class UserProfileController extends CommonMethods {

  final count = 0.obs;
  int load=0;
  final inAsyncCall = false.obs;
  final userDataMap={}.obs;
  DateTime? dateTime;

  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value=true;
    await getUserData();
    inAsyncCall.value=false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onReload()
  {
    connectivity.onConnectivityChanged.listen((event) async {
      if ( await MyCommonMethods.internetConnectionCheckerMethod()) {
        if(load==0)
        {
          load=1;
          await onInit();
        }
      } else {
        load=0;
      }
    });
  }

  Future<void> onRefresh() async {
    await onInit();
  }


  void clickOnBackIcon({required BuildContext context}) async {
    inAsyncCall.value=true;
    Get.back();
    inAsyncCall.value=false;
  }

  onWillPop({required BuildContext context}) async {
    clickOnBackIcon(context: context);
  }

  Future<void> getUserData()
  async {
    userDataMap.value=await CommonMethods.getUserData() ?? {};
    dateTime = DateTime.parse(userDataMap[UserDataKeyConstant.lastUpdate]);
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
