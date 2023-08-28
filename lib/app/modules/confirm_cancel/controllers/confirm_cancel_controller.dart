import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';

class ConfirmCancelController extends GetxController {
  //TODO: Implement ConfirmCancelController

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 3));
    Get.back();
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

  clickOnBackIcon() {
    Get.back();
  }

  clickOnKeepShopping() {
    selectedIndex.value = 2;
    Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
  }

  clickOnViewAllOrder() {
    Get.offNamed(Routes.MY_ORDERS);
  }

}
