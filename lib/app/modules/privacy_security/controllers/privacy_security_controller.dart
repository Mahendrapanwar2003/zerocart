import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/alert_dialog.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:http/http.dart' as http;

import '../../../../my_common_method/my_common_method.dart';


class PrivacySecurityController extends CommonMethods {
  List buttonContent = [
    "Change Password",
    "Deactivate Account",
  ];

  int load=0;
  final inAsyncCall = false.obs;
  final userDataMap = {}.obs;

  DateTime? dateTime;
  String? mobile;
  int? differance;

  Map<String, dynamic> bodyParamsForSendOtpApi = {};
  Map<String, dynamic> sendOtpApiResponseMap = {};


  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value=true;
    await getUserData();
    inAsyncCall.value=false;
    onReload();
  }

  Future<void> getUserData() async {
    userDataMap.value = await CommonMethods.getUserData() ?? {};
    dateTime = DateTime.parse(userDataMap[UserDataKeyConstant.lastUpdate]);
    mobile = userDataMap[UserDataKeyConstant.mobile];
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

  Future<bool> sendOtpApiCalling({required String type}) async {
    bodyParamsForSendOtpApi = {
      ApiKeyConstant.mobile: mobile.toString(),
      ApiKeyConstant.countryCode: "+91",
      ApiKeyConstant.type: type,
    };
    http.Response? response =
    await CommonApis.sendOtpApi(bodyParams: bodyParamsForSendOtpApi);
    if (response != null) {
      sendOtpApiResponseMap = jsonDecode(response.body);
      return true;
    }
    else
    {
      return false;
    }
  }



  void clickOnBackIcon({required BuildContext context}) {
    inAsyncCall.value=true;
    Get.back();
    inAsyncCall.value=false;
  }

  onWillPop({required BuildContext context}) {
    clickOnBackIcon(context: context);
  }

  Future<void> clickOnButton(
      {required int buttonIndex, required BuildContext context}) async {
    inAsyncCall.value=true;
    if (buttonIndex == 0) {
      Get.toNamed(Routes.CHANGE_PASSWORD);
    } else {
      showAlertDialog();
    }
    inAsyncCall.value=false;

  }

  void showAlertDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => clickOnCancelButton(),
              child: cancelTextButtonView(),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => clickOnDialogDeleteButton(),
              child: deleteTextButtonView(),
            ),
          ],
          title: titleTextView(),
          content: contentTextView(),
        );
      },
    );
  }

  Widget titleTextView() => Text(
    "Delete Account",
    style: Theme.of(Get.context!)
        .textTheme
        .subtitle1
        ?.copyWith(fontSize: 20.px),
  );

  Widget contentTextView() => Text(
    "Are you sure you want to delete your account? This action cannot be undone and all your data will be lost.To confirm the deletion, we will send a one-time password (OTP) to your registered mobile number. Please enter the OTP in the prompt that follows to verify your identity and complete the account deletion process.",
    style: Theme.of(Get.context!).textTheme.subtitle2,
  );

  Widget cancelTextButtonView() => Text(
    "Cancel",
    style: Theme.of(Get.context!)
        .textTheme
        .subtitle2
        ?.copyWith(color: MyColorsLight().textGrayColor),
  );

  Widget deleteTextButtonView() => Text(
    "Delete",
    style: Theme.of(Get.context!)
        .textTheme
        .subtitle2
        ?.copyWith(color: MyColorsLight().error),
  );

  void clickOnCancelButton() {
    Get.back();
  }

  Future<void> clickOnDialogDeleteButton() async {
    Get.back();
    inAsyncCall.value=true;
    if(await sendOtpApiCalling(type: "deleteAccount"))
    {
      Get.toNamed(Routes.VERIFICATION, arguments: [
        4,
        "Delete",
        sendOtpApiResponseMap[ApiKeyConstant.otp],
        "deleteAccount",
        mobile
      ]);
    }
    inAsyncCall.value=false;

  }


  /* lastUpdate() {
    // "${controller.dateTime?.year}-${controller.dateTime?.month}-${controller.dateTime?.day}"
  }*/

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


  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  String checkString({required String myString}) {
    String search = '';
    for (int i = 0 ; i < 4 && i < myString.length ; i++){
      search += myString[i];
    }
    if(search == '+91 ')
    {
      return userDataMap[UserDataKeyConstant.securityPhone];
    }
    else
    {
      return "+91 ${userDataMap[UserDataKeyConstant.securityPhone]}";
    }
  }
}
