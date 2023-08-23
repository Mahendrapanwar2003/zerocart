import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../controllers/slider_controller.dart';

class SliderView extends GetView<SliderController> {
  const SliderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              PageView.builder(
                controller: controller.controller,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                onPageChanged: (int index) => controller.indexChange(index),
                itemBuilder: ((context, index) => pageViewBuilder(index: index)),
              ),
              Column(
                children: [
                  const Expanded(child: SizedBox.shrink()),
                  Column(
                    children: [
                      pageDots(),
                      SizedBox(height: 2.5.h),
                      nextOrLoginButtonView(),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),);
  }


  Widget pageViewBuilder({required int index}) =>Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: backGroundImage(index: index),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      color: MyColorsDark().secondary.withOpacity(0.4),
      child: Center(
        child: Column(
          children: [
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:Zconstant.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  onBoardingTitle(),
                  SizedBox(height: .8.h),
                  dashView(),
                  SizedBox(height: 1.h),
                  onBoardingText(),
                  SizedBox(height: 14.h),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget nextOrLoginButtonView() =>CommonWidgets.myElevatedButton(
      text: Text(
        style: Theme.of(Get.context!).textTheme.button,
        controller.currentIndex.value == 2
            ? "Welcome"
            : "Next",
      ),
      onPressed: () =>
          controller.clickOnNextOrLoginButton(),
      height: 50.px,
      borderRadius: 10.px);

  ImageProvider backGroundImage({required int index}) =>AssetImage(controller.images[index]);

  Widget onBoardingTitle() {
    return Text(
      "Customize Your Wardrobe",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Theme.of(Get.context!).textTheme.headline2?.copyWith(fontSize: 16.px,color: MyColorsLight().secondary),
    );
  }

  Widget dashView() =>Container(
    height: 1.px,
    width: 20.w,
    decoration: BoxDecoration(color: MyColorsLight().secondary),
  );

  Widget pageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
            (index) => buildDot(index),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10.px,
      width: 10.px,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: controller.currentIndex.value == index
          ? BoxDecoration(
        gradient: CommonWidgets.commonLinearGradientView(),
        shape: BoxShape.circle,
      )
          : BoxDecoration(
        color: MyColorsLight().secondary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget onBoardingText() {
    return Text(
        "Make your own clothes based on your choice of colour, texture, material and many others.",
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(color: MyColorsLight().secondary)
    );
  }

}
