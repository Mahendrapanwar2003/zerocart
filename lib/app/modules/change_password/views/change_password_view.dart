import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/validator/form_validator.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../common_methods/common_methods.dart';
import '../../../custom/custom_appbar.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AbsorbPointer(
          absorbing: controller.absorbing.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const MyCustomContainer().myAppBar(
              isIcon: true,
              backIconOnPressed: () =>
                  controller.clickOnBackIcon(context: context),
              text: 'Change Your Password',
            ),
            body: GestureDetector(
              onTap: () => MyCommonMethods.unFocsKeyBoard(),
              child: Form(
                key: controller.key,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Zconstant.margin),
                  child: SizedBox(
                    height: CommonMethods.getSize(context: context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Expanded(
                         child: Column(
                           children: [
                             SizedBox(height: Zconstant.margin),
                             currentPasswordTextFieldView(),
                             SizedBox(height: Zconstant.margin),
                             newPasswordTextFieldView(),
                             SizedBox(height: Zconstant.margin),
                             confirmPasswordTextFieldView(),
                           ],
                         ),
                       ),
                       Column(
                         children: [
                           Center(child: continueButtonView(context: context)),
                           SizedBox(height: Zconstant.margin),
                         ],
                       )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget backIconView({required BuildContext context}) => Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: () => controller.clickOnBackIcon(context: context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(Get.context!).textTheme.subtitle1?.color,
          ),
          splashRadius: 24.px,
          iconSize: 18.px,
        ),
      );

  Widget changeYourPasswordTextView() => Text(
        "Change Your Password",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget currentPasswordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.currentPasswordVisible.value,
        labelText: 'Old Password',
        inputType: TextInputType.text,
        hintText: '..........',
        controller: controller.currentPasswordController,
        validator: (value) => FormValidator.isPasswordValid(value: value),
        icon: IconButton(
            icon: Icon(
              controller.currentPasswordVisible.value
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4),
            ),
            splashRadius: 20,
            onPressed: () => controller.clickOnCurrentPasswordEyeButton()),
        iconVisible: true,
      );

  Widget newPasswordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.passwordVisible.value,
        controller: controller.passwordController,
        validator: (value) => FormValidator.isPasswordValid(value: value),
        inputType: TextInputType.text,
        labelText: 'New Password',
        hintText: '..........',
        icon: IconButton(
            icon: Icon(
              controller.passwordVisible.value
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4),
            ),
            splashRadius: 20,
            onPressed: () => controller.clickOnPasswordEyeButton()),
        iconVisible: true,
      );

  Widget confirmPasswordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.confirmPasswordVisible.value,
        controller: controller.confirmPasswordController,
        inputType: TextInputType.text,
        validator: (value) => FormValidator.isConfirmPasswordValid(
            value: value, password: controller.passwordController.text),
        labelText: 'Confirm Password',
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

  Widget continueButtonView({required BuildContext context}) {
    return Obx(() {
      if (!controller.isContinueButtonClicked.value) {
        return CommonWidgets.myElevatedButton(
            text: Text('Continue',
                style: Theme.of(Get.context!).textTheme.button),
            // ignore: avoid_returning_null_for_void
            onPressed: !controller.isContinueButtonClicked.value
                ? () => controller.clickOnContinueButton(context: context)
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
            margin: EdgeInsets.zero);
      }
    });
  }
}
