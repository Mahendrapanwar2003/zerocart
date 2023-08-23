import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_customer_measurement_api_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:http/http.dart' as http;

class MeasurementsController extends GetxController {
  final inAsyncCall = false.obs;

  final count = 0.obs;

  double chest = 48.2;
  double arm = 48.2;
  double shoulder = 48.2;
  double waist = 48.2;
  double neck = 48.2;
  double height = 50;
  double weight = 50;
  double bMI = 0.0;

  double chestBackUp = 0.0;
  double armBackUp = 0.0;
  double shoulderBackUp = 0.0;
  double waistBackUp = 0.0;
  double neckBackUp = 0.0;
  double heightBackUp = 0.0;
  double weightBackUp = 0.0;
  double bMIBackUp = 0.0;

  Map<String, dynamic> bodyParamsForUpdateApi = {};

  GetCustomerMeasurementApiModel? getCustomerMeasurementApiModel;
  Measurement? measurement;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCustomerMeasurementApi();
  }

  Future<void> createOrder() async {}

  void clickOnBackIcon({required BuildContext context}) {
    Get.back();
  }

  void increment() {
    count.value++;
  }

  void clickOnAddIconView({required int index}) {
    increment();
    if (index == 0) {
      chest += 0.1;
    }
    if (index == 1) {
      arm += 0.1;
    }
    if (index == 2) {
      shoulder += 0.1;
    }
    if (index == 3) {
      waist += 0.1;
    }
    if (index == 4) {
      neck += 0.1;
    }
    if (index == 5) {
      height += 1;
      calculateBMI(
        measurementHeight: height.toString(),
        measurementWeight: weight.toString(),
      );
    }
    if (index == 6) {
      weight += 1;
      calculateBMI(
        measurementHeight: height.toString(),
        measurementWeight: weight.toString(),
      );
    }
  }

  void clickOnSubtractIconView({required int index}) {
    increment();
    if (index == 0) {
      chest -= 0.1;
    }
    if (index == 1) {
      arm -= 0.1;
    }
    if (index == 2) {
      shoulder -= 0.1;
    }
    if (index == 3) {
      waist -= 0.1;
    }
    if (index == 4) {
      neck -= 0.1;
    }
    if (index == 5) {
      height -= 1;
      calculateBMI(
        measurementHeight: height.toString(),
        measurementWeight: weight.toString(),
      );
    }
    if (index == 6) {
      weight -= 1;
      calculateBMI(
        measurementHeight: height.toString(),
        measurementWeight: weight.toString(),
      );
    }
  }

  void clickOnResetButton({required int index}) {
    increment();
    if (index == 0) {
      chest = chestBackUp;
    }
    if (index == 1) {
      arm = armBackUp;
    }
    if (index == 2) {
      shoulder = shoulderBackUp;
    }
    if (index == 3) {
      waist = waistBackUp;
    }
    if (index == 4) {
      neck = neckBackUp;
    }
    if (index == 5) {
      height = heightBackUp;
      calculateBMI(
        measurementHeight: height.toString(),
        measurementWeight: weight.toString(),
      );
    }
    if (index == 6) {
      weight = weightBackUp;
      calculateBMI(
        measurementHeight: height.toString(),
        measurementWeight: weight.toString(),
      );
    }
  }

  void clickOnAddVrScanTextViewButton() {}

  clickOnConfirmButton() async {
    Map<String, double> measurement = {
      "Chest": chest.toDouble(),
      "Arm": arm.toDouble(),
      "Shoulder": shoulder.toDouble(),
      "Waist": waist.toDouble(),
      "Neck": neck.toDouble(),
      "Height": height.toDouble(),
      "Weight": weight.toDouble(),
      "BMI": bMI.toDouble(),
    };
    await MyCommonMethods.setString(key: 'measurement', value: json.encode(measurement));
    bodyParamsForUpdateApi = {
      ApiKeyConstant.measurement: json.encode(measurement),
    };
    inAsyncCall.value = true;
    http.Response? response =
        await CommonApis.updateUserProfile(bodyParams: bodyParamsForUpdateApi);
    if (response != null) {
      Get.back();
      inAsyncCall.value = false;
    }
    inAsyncCall.value = false;
  }

  void calculateBMI(
      {required String measurementHeight, required String measurementWeight}) {
    double height = double.parse(measurementHeight.toString()) / 100;
    double weight = double.parse(measurementWeight.toString());
    double heightSquare = height * height;
    bMI = weight / heightSquare;
  }

  Future<void> getCustomerMeasurementApi() async {
    inAsyncCall.value = true;
    getCustomerMeasurementApiModel =
        await CommonApis.getCustomerMeasurementApi();
    if (getCustomerMeasurementApiModel != null) {
      if (getCustomerMeasurementApiModel!.measurement != null) {
        measurement = getCustomerMeasurementApiModel!.measurement!;
        if (measurement != null) {
          if (measurement!.chest != null &&
              measurement!.arm != null &&
              measurement!.shoulder != null &&
              measurement!.waist != null &&
              measurement!.neck != null &&
              measurement!.height != null &&
              measurement!.weight != null &&
              measurement!.bMI != null) {
            chest = measurement!.chest!.toDouble();
            arm = measurement!.arm!.toDouble();
            shoulder = measurement!.shoulder!.toDouble();
            waist = measurement!.waist!.toDouble();
            neck = measurement!.neck!.toDouble();
            height = measurement!.height!.toDouble();
            weight = measurement!.weight!.toDouble();
            bMI = measurement!.bMI!.toDouble();
            chestBackUp = measurement!.chest!.toDouble();
            armBackUp = measurement!.arm!.toDouble();
            shoulderBackUp = measurement!.shoulder!.toDouble();
            waistBackUp = measurement!.waist!.toDouble();
            neckBackUp = measurement!.neck!.toDouble();
            heightBackUp = measurement!.height!.toDouble();
            weightBackUp = measurement!.weight!.toDouble();
            bMIBackUp = measurement!.bMI!.toDouble();
          }
        }
      }
      inAsyncCall.value = false;
    }
    inAsyncCall.value = false;
  }
}
