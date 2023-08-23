import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/validator/form_validator.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AbsorbPointer(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            wellComeBackTextView(),
                            SizedBox(height: 2.h),
                            Form(
                                autovalidateMode: AutovalidateMode.disabled,
                                key: controller.keyNumber,
                                child: mobileNumberTextFieldView()),
                            SizedBox(height: 2.h),
                            Form(
                                autovalidateMode: AutovalidateMode.disabled,
                                key: controller.keyPassword,
                                child: passwordTextFieldView()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                sendOTPButtonView(),
                                forgotPasswordButtonView(),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Center(child: logInButtonView()),
                            SizedBox(
                              height: Zconstant.margin16,
                            ),
                            Center(child: logInWithGoogleButtonView()),
                            SizedBox(
                              height: Zconstant.margin,
                            ),
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
      );
    });
  }

  Widget wellComeBackTextView() => Text('Welcome  Back !',
      style: Theme.of(Get.context!)
          .textTheme
          .subtitle1
          ?.copyWith(fontSize: 24.px));

  Widget mobileNumberTextFieldView() => CommonWidgets.myTextField(
      controller: controller.mobileNumberController,
      inputType: TextInputType.number,
      labelText: 'Mobile Number',
      onChanged: (value) {},
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      autofocus: true,
      hintText: '1234567890',
      maxLength: 10,
      validator: (value) => FormValidator.isLoginNumberValid(value: value),
      iconVisible: false);

  Widget passwordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.passwordVisible.value,
        labelText: 'Password',
        autofocus: true,
        validator: (value) => FormValidator.isLoginPasswordValid(value: value),
        controller: controller.passwordController,
        hintText: 'Example@123',
        icon: IconButton(
            icon: Icon(
              controller.passwordVisible.value
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4),
            ),
            splashRadius: 20,
            onPressed: () => controller.clickOnEyeButton()),
        iconVisible: true,
      );



  Widget sendOTPButtonView() => TextButton(
        child: Text('Send OTP',
            style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
                color: Theme.of(Get.context!)
                    .colorScheme
                    .onSurface
                    .withOpacity(.4))),
        onPressed: () => controller.clickOnSendOtpButton(),
      );

  Widget forgotPasswordButtonView() => TextButton(
        child: Text('Forgot Password?',
            style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
                color: Theme.of(Get.context!)
                    .colorScheme
                    .onSurface
                    .withOpacity(.4))),
        onPressed: () => controller.clickOnForgotPasswordButton(),
      );

  Widget logInButtonView() {
    return Obx(() {
      if (!controller.isLoginButtonClicked.value) {
        return CommonWidgets.myElevatedButton(
            text: Text('Login', style: Theme.of(Get.context!).textTheme.button),
            // ignore: avoid_returning_null_for_void
            onPressed: !controller.isLoginButtonClicked.value
                ? () => controller.clickOnLoginButton()
                // ignore: avoid_returning_null_for_void
                : () => null,
            height: 52.px,
            margin: EdgeInsets.zero);
      } else {
        return CommonWidgets.myElevatedButton(
          text: CommonWidgets.buttonProgressBarView(),
          // ignore: avoid_returning_null_for_void
          onPressed: () => null,
          height: 52.px,
          margin: EdgeInsets.zero,
        );
      }
    });
  }

  Widget logInWithGoogleButtonView() {
    return Obx(() {
      if (!controller.isGoogleLoginButtonClicked.value) {
        return CommonWidgets.myOutlinedButton(
            text: Text('Login With Google',
                style: Theme.of(Get.context!).textTheme.subtitle1),
            // ignore: avoid_returning_null_for_void
            onPressed: !controller.isLoginButtonClicked.value
                ? () => controller.clickOnLoginWithGoogleButton()
                // ignore: avoid_returning_null_for_void
                : () => null,
            height: 52.px,
            margin: EdgeInsets.zero);
      } else {
        return CommonWidgets.myOutlinedButton(
            text: CommonWidgets.buttonProgressBarView(),
            // ignore: avoid_returning_null_for_void
            onPressed: () => null,
            height: 52.px,
            margin: EdgeInsets.zero);
      }
    });
  }
}
