import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/routes/app_pages.dart';

import '../../../../my_common_method/my_common_method.dart';

class MainSplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> colorTween;
  String? isSliderView;

  @override
  Future<void> onInit() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    colorTween = animationController.drive(
      ColorTween(
        begin: Theme.of(Get.context!).primaryColor,
        end: Theme.of(Get.context!).colorScheme.primary,
      ),
    );
    animationController.repeat();
    Timer(
      const Duration(seconds: 3),
      () => manageSession(),
    );
    super.onInit();
    isSliderView = await MyCommonMethods.getString(key: ApiKeyConstant.isSlider);
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  Future<void> manageSession() async {
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    if (token != "" && token != null) {
      Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
    } else {
      if (isSliderView != null && isSliderView != "") {
        Get.offAllNamed(Routes.SPLASH);
      } else {
       Get.offAllNamed(Routes.SLIDER);
      }
    }
  }


}
