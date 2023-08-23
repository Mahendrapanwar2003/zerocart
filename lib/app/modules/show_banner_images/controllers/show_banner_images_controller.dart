import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowBannerImagesController extends GetxController {

  final count = 0.obs;
  final pageController = PageController();
  List<ImageProvider> bannerImagesList=Get.arguments;
  late final easyEmbeddedImageProvider = MultiImageProvider(bannerImagesList);

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

  clickOnBackButton() {
    Get.back();
  }
}
