import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/validator/form_validator.dart';
import '../../../common_methods/common_methods.dart';
import '../../../constant/zconstant.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.absorbing.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GestureDetector(
            onTap: ()=>MyCommonMethods.unFocsKeyBoard(),
            child: Form(
              key: controller.key,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Zconstant.margin),
                    child: SizedBox(
                      height: CommonMethods.getSize(context: context),
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(child: Padding(
                            padding:  EdgeInsets.only(top: 10.h),
                            child: CommonWidgets.zeroCartImage(),
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resetPasswordTextView(),
                              SizedBox(height: 3.h),
                              passwordTextFieldView(),
                              SizedBox(height: 2.h),
                              confirmPasswordTextFieldView(),
                            ],
                          ),
                          Column(
                            children: [
                              Center(child: logInButtonView()),
                              SizedBox(height: Zconstant.margin16),
                              Center(
                                child: backButtonView(),
                              ),
                              SizedBox(height: Zconstant.margin),
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
      ),
    );
  }

  Widget resetPasswordTextView() => Text(
        'Reset Your Password',
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 24.px),
      );

  Widget passwordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.passwordVisible.value,
        controller: controller.passwordController,
        validator: (value) => FormValidator.isPasswordValid(value: value),
        labelText: 'New Password',
        hintText: '..........',
        icon: IconButton(
            icon: Icon(
                controller.passwordVisible.value
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(Get.context!)
                    .colorScheme
                    .onSurface
                    .withOpacity(.4)),
            splashRadius: 20,
            onPressed: () => controller.clickOnPasswordEyeButton()),
        iconVisible: true,
      );

  Widget confirmPasswordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.confirmPasswordVisible.value,
        labelText: 'Confirm Password',
        validator: (value) =>  FormValidator.isConfirmPasswordValid(
            value: value, password: controller.passwordController.text),
        controller: controller.confirmPasswordController,
        hintText: '..........',
        icon: IconButton(
            icon: Icon(
              controller.confirmPasswordVisible.value
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4),
            ),
            splashRadius: 20,
            onPressed: () => controller.clickOnConfirmPasswordEyeButton()),
        iconVisible: true,
      );

  Widget logInButtonView(){
    return Obx(() {
      if (!controller.isLoginButtonClicked.value) {
        return CommonWidgets.myElevatedButton(
            text: Text('Login', style: Theme.of(Get.context!).textTheme.button),
            // ignore: avoid_returning_null_for_void
            onPressed:!controller.isLoginButtonClicked.value?()=> controller.clickOnLoginButton():()=>null,
            height: 52.px,
            margin: EdgeInsets.zero);
      } else {
        return CommonWidgets.myElevatedButton(
            text: CommonWidgets.buttonProgressBarView(),
            // ignore: avoid_returning_null_for_void
            onPressed: ()=>null,
            height: 52.px,
            margin: EdgeInsets.zero);
      }
    });
  }

  Widget backButtonView() => CommonWidgets.myOutlinedButton(
      text: Text('Back', style: Theme.of(Get.context!).textTheme.subtitle1),
      onPressed: () => controller.clickOnBackButton(),
      height: 52.px,
      margin: EdgeInsets.zero);
}
