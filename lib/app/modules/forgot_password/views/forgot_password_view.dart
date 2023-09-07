import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/validator/form_validator.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../common_methods/common_methods.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

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
                      child: Column(
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
                              wellComeBackTextView(),
                              SizedBox(height: 1.h),
                              resetPasswordTextView(),
                              SizedBox(height: 3.h),
                              mobileNumberTextFieldView(),
                            ],
                          ),
                          Column(
                            children: [
                              Center(child: sendOtpButtonView()),
                              SizedBox(height: Zconstant.margin16),
                              Center(child: backButtonView(),),
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

  Widget wellComeBackTextView() => Text(
        'Welcome  Back !',
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget resetPasswordTextView() => Text(
        "Please enter your mobile number to reset your password",
        style: Theme.of(Get.context!).textTheme.caption,
      );

  Widget mobileNumberTextFieldView() => CommonWidgets.myTextField(
      controller: controller.mobileNumberController,
      inputType: TextInputType.number,
      labelText: 'Mobile Number',
      onChanged: (value) {},
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      hintText: '1234567890',
      maxLength: 10,
      validator: (value) => FormValidator.isLoginNumberValid(value: value),
      iconVisible: false);

  Widget sendOtpButtonView() {
    return Obx(() {
      if (!controller.isClickOnSendOtpButton.value) {
        return CommonWidgets.myElevatedButton(
            text: Text('Send OTP', style: Theme.of(Get.context!).textTheme.button),
            // ignore: avoid_returning_null_for_void
            onPressed:!controller.isClickOnSendOtpButton.value?()=> controller.clickOnSendOtpButton():()=>null,
            height: 52.px,
            margin: EdgeInsets.zero

        );
      } else {
        return CommonWidgets.myElevatedButton(
            text: CommonWidgets.buttonProgressBarView(),
            // ignore: avoid_returning_null_for_void
            onPressed: ()=>null,
            height: 52.px,
            margin: EdgeInsets.zero

        );
      }
    });

  }

  Widget backButtonView() => CommonWidgets.myOutlinedButton(
      text: Text('Back',style: Theme.of(Get.context!).textTheme.subtitle1),
      onPressed: () => controller.clickOnBackButton(),
      height: 52.px,
    margin: EdgeInsets.zero
      );
}
