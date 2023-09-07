  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.absorbing.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GestureDetector(
            onTap: () => MyCommonMethods.unFocsKeyBoard(),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Zconstant.margin),
                  child: SizedBox(
                    height: CommonMethods.getSize(context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: CommonWidgets.zeroCartImage(),
                        )),
                        Column(
                          children: [
                            pinView(),
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                resendOtpTextButtonView(),
                                controller.timer.value
                                    ? resendTimeCountDown(
                                        seconds: 30,
                                        onFinished: () {
                                          controller.timer.value =
                                              !controller.timer.value;
                                        })
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            loginButtonView(),
                            SizedBox(height: Zconstant.margin16),
                            backButtonView(),
                            SizedBox(
                              height: Zconstant.margin,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*
  Widget pinView() => PinCodeTextField(
    autoUnfocus: true,
    controller: controller.pin,
    //validator: (value)=>Validation.Pin(pin: value),
    appContext: Get.context!,
    pinTheme: PinTheme(
      inactiveColor:Theme.of(Get.context!).brightness==Brightness.dark?Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.15): Theme.of(Get.context!).colorScheme.onSurface,
      inactiveFillColor: Theme.of(Get.context!).brightness==Brightness.dark?MyColorsDark().onSecondary:MyColorsLight().onSecondary,
      activeColor: Theme.of(Get.context!).brightness==Brightness.dark?Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.15):Theme.of(Get.context!).colorScheme.onSurface,
      activeFillColor:  Theme.of(Get.context!).brightness==Brightness.dark?MyColorsDark().onSecondary:MyColorsLight().onSecondary,
      selectedColor: Theme.of(Get.context!).colorScheme.primary,
      selectedFillColor: Theme.of(Get.context!).brightness==Brightness.dark?MyColorsDark().onSecondary:MyColorsLight().onSecondary,
      shape: PinCodeFieldShape.box,
      fieldWidth: 20.w,
      fieldHeight: 20.w,
      borderWidth: 0.50,
      borderRadius: BorderRadius.circular(8),
    ),
    enableActiveFill: true,
    textStyle: Theme.of(Get.context!).textTheme.headline2?.copyWith(
        color: Theme.of(Get.context!).colorScheme.onSurface),
    cursorColor: Theme.of(Get.context!).colorScheme.primary,
    keyboardType: TextInputType.number,
    length: 4,
    onChanged: (String value) => controller.currentText.value = value,
  );
*/

  Widget pinView() => PinCodeTextField(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        appContext: (Get.context!),
        length: 4,
        textStyle: Theme.of(Get.context!)
            .textTheme
            .headline2
            ?.copyWith(color: Theme.of(Get.context!).colorScheme.onSurface),
        cursorColor: Theme.of(Get.context!).colorScheme.primary,
        keyboardType: TextInputType.number,
        // readOnly: true,
        blinkWhenObscuring: true,
        autoDisposeControllers: false,
        animationType: AnimationType.none,
        pinTheme: PinTheme(
          inactiveColor: Theme.of(Get.context!).brightness == Brightness.dark
              ? Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.15)
              : Theme.of(Get.context!).colorScheme.onSurface,
          inactiveFillColor:
              Theme.of(Get.context!).brightness == Brightness.dark
                  ? MyColorsDark().onSecondary
                  : MyColorsLight().onSecondary,
          activeColor: Theme.of(Get.context!).brightness == Brightness.dark
              ? Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.15)
              : Theme.of(Get.context!).colorScheme.onSurface,
          activeFillColor: Theme.of(Get.context!).brightness == Brightness.dark
              ? MyColorsDark().onSecondary
              : MyColorsLight().onSecondary,
          selectedColor: Theme.of(Get.context!).colorScheme.primary,
          selectedFillColor:
              Theme.of(Get.context!).brightness == Brightness.dark
                  ? MyColorsDark().onSecondary
                  : MyColorsLight().onSecondary,
          shape: PinCodeFieldShape.box,
          fieldWidth: 20.w,
          fieldHeight: 20.w,
          borderWidth: 0.50,
          borderRadius: BorderRadius.circular(8),
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        errorAnimationController: controller.errorController,
        controller: controller.textEditingController,
        onChanged: (value) {
          //  controller.currentText.value = value;
        },
        beforeTextPaste: (text) {
          return true;
        },
      );

/*
  Widget resendOtpButtonView() => TextButton(
    child: Text("Resend OTP",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(fontSize: 16.px)),
    onPressed: () => controller.enableResend.value
        ? controller.clickOnResendOtpButton()
        : null,
  );
*/

  Widget resendOtpTextButtonView() {
    return controller.timer.value
        ? TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(Get.context!).colorScheme.background),
            onPressed: () {},
            child: resendOtpTextView(),
          )
        : TextButton(
            onPressed: () => controller.clickOnResendButton(),
            child: resendOtpTextView(),
          );
  }

  Widget resendOtpTextView() => Text(
        "Resend OTP",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(fontSize: 16.px)
      );

  static Widget resendTimeCountDown(
          {required double seconds, required Function onFinished}) =>
      Countdown(
        // controller: controller,
        seconds: seconds.toInt(),
        build: (_, double time) => Text(
          " in 00:${time.toInt()}",
          style: Theme.of(Get.context!)
              .textTheme
              .headline5
              ?.copyWith(fontSize: 14.px),
        ),
        interval: const Duration(milliseconds: 100),
        onFinished: onFinished,
      );

  Widget loginButtonView() {
    return Obx(() {
      if (!controller.isClickOnLoginButton.value) {
        return Center(
          child: CommonWidgets.myElevatedButton(
              text: Text(controller.buttonText,
                  style: Theme.of(Get.context!).textTheme.button),
              // ignore: avoid_returning_null_for_void
              onPressed: !controller.isClickOnLoginButton.value
                  ? () => controller.clickOnLoginButton()
                  : () => null,
              height: 52.px,
              margin: EdgeInsets.zero),
        );
      } else {
        return Center(
          child: CommonWidgets.myElevatedButton(
              text: CommonWidgets.buttonProgressBarView(),
              // ignore: avoid_returning_null_for_void
              onPressed: () => null,
              height: 52.px,
              margin: EdgeInsets.zero),
        );
      }
    });
  }

  Widget backButtonView() => Center(
        child: CommonWidgets.myOutlinedButton(
          height: 50.px,
          margin: EdgeInsets.zero,
          text: Text('Back', style: Theme.of(Get.context!).textTheme.subtitle1),
          onPressed: () => controller.clickOnBackButton(),
        ),
      );
}
