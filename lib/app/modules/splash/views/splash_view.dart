import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import '../../../constant/zconstant.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AbsorbPointer(
        absorbing: controller.absorbing.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: CommonWidgets.zeroCartBagImage()),
              Column(
                children: [
                  logInButtonView(),
                  SizedBox(height: Zconstant.margin16),
                  registerWithGoogleButtonView(),
                  SizedBox(height: Zconstant.margin,)
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget logInButtonView() => CommonWidgets.myElevatedButton(
      text: Text('Login', style: Theme.of(Get.context!).textTheme.button),
      onPressed: controller.clickOnLoginButton,
      height: 52.px,
      );

  Widget registerWithGoogleButtonView() {
    return Obx(() {
      if (!controller.isGoogleRegistrationButtonClicked.value) {
        return CommonWidgets.myOutlinedButton(
            text: Text('Register With Google',
                style: Theme.of(Get.context!).textTheme.subtitle1),
            // ignore: avoid_returning_null_for_void
            onPressed: !controller.isGoogleRegistrationButtonClicked.value
                ? () => controller.clickOnRegisterWithGoogleButton()
                // ignore: avoid_returning_null_for_void
                : () => null,
            height: 52.px,
            );
      } else {
        return CommonWidgets.myOutlinedButton(
            text: CommonWidgets.buttonProgressBarView(),
            // ignore: avoid_returning_null_for_void
            onPressed: () => null,
            height: 52.px,);
      }
    });
  }
}
