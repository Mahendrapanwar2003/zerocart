import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/routes/app_pages.dart';

class SliderController extends GetxController {
  final currentIndex = 0.obs;
  late PageController controller;
  List images = [
    "assets/first_slider_image.jpg",
    "assets/second_slider_image.png",
    "assets/third_slider_image.jpg",
  ];

  @override
  void onInit() {
    super.onInit();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void indexChange(int index) {
    currentIndex.value = index;
  }

  void clickOnNextOrLoginButton() {
    if (currentIndex.value == 2) {
      Get.offNamed(Routes.SPLASH);
    }
    controller.nextPage(
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceIn,
    );
  }
}
