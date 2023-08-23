import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';

import '../controllers/show_banner_images_controller.dart';

class ShowBannerImagesView extends GetView<ShowBannerImagesController> {
  const ShowBannerImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: const MyCustomContainer().myAppBar(text: "Show Banner Images",isIcon: true,backIconOnPressed: ()=>controller.clickOnBackButton()),
      body: Center(
        child: controller.bannerImagesList.isEmpty
            ? CommonWidgets.progressBarView()
            : SizedBox(
                width: double.infinity,
                child: EasyImageViewPager(
                    doubleTapZoomable: true,
                    easyImageProvider: controller.easyEmbeddedImageProvider,
                    pageController: controller.pageController),
              ),
      ),
    );
  }
}
