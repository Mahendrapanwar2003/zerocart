import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';

class MyCommonMethods {

  static String apiKey = " AIzaSyA3JjnDKRhyeLmqrgOAy7j3hDexhpvSEgk";


  static void unFocsKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<bool> internetConnectionCheckerMethod() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  static void showSnackBar({required String message,
    required BuildContext context,
    EdgeInsetsGeometry? margin,
    Duration? duration}) {
    var snackBar = SnackBar(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
      margin: margin ?? EdgeInsets.only(left: 4.w, right: 3.w, bottom: 10.h),
      behavior: SnackBarBehavior.floating,
      duration: duration ?? const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String getDeviceType() {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "IOS";
    } else {
      return "";
    }
  }

  static Future<String?> getString({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  static Future<bool> setString(
      {required String key, required String value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }


  static Future<bool?> getBool({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  static Future<bool> setBool(
      {required String key, required bool value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }

  static void networkConnectionShowSnackBar({required BuildContext context}) {
    showSnackBar(message: "Check Your Internet Connection", context: context);
  }

  static void serverDownShowSnackBar({required BuildContext context}) {
    showSnackBar(message: "Server Down", context: context);
  }
}
