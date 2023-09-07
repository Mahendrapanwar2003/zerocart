import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_progress_bar.dart';
import 'package:zerocart/app/modules/profile_menu/controllers/profile_menu_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class ProfileCompletionView extends GetView<ProfileMenuController> {
  const ProfileCompletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
          top: Zconstant.margin-8.px,
          bottom: 10.w,
          left: Zconstant.margin-10.px,
          right: Zconstant.margin-10.px
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.px),
            color: Theme.of(context).brightness==Brightness.light?MyColorsLight().backGround:MyColorsLight().secondary.withOpacity(.9),
          ),
          padding: EdgeInsets.symmetric(
            vertical: Zconstant.margin-4.px,
            horizontal: Zconstant.margin-4.px,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  profileCompilationTextView(),
                  howManyPercentProfileCompleteTextView(),
                ],
              ),
              SizedBox(height: 1.25.h),
              gradientProgressBarView(),
              SizedBox(height: 2.25.h),
              updateProfileButtonView(context:context),
            ],
          ),
        ),
      );
    });
  }

  LinearGradient commonLinearGradientView() => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [
      Theme.of(Get.context!).primaryColor,
      Theme.of(Get.context!).colorScheme.primary,
    ],
  );

  Widget updateProfileTextView() =>Text(
    "UPDATE PROFILE",
    style: Theme.of(Get.context!).textTheme.button?.copyWith(fontSize: 12.px,),
  );

  Widget profileCompilationTextView() =>   Text(
    "Profile Completion",
    style: Theme.of(Get.context!).textTheme.bodyText1?.copyWith(fontSize: 14.px,color: MyColorsLight().onText),
  );

  Widget howManyPercentProfileCompleteTextView() =>Text(
    "${controller.progress.value}%",
    style: Theme.of(Get.context!).textTheme.bodyText1?.copyWith(fontSize: 14.px,color: MyColorsLight().onText),
  );

  Widget gradientProgressBarView() => GradientProgressBar(
    percent: int.parse(controller.progress.value),
    gradient: commonLinearGradientView(),
    backgroundColor: MyColorsLight().onText.withOpacity(.10),
  );

  Widget updateProfileButtonView({required BuildContext context}) =>CommonWidgets.myElevatedButton(
      text: updateProfileTextView(),
      onPressed: () =>controller.clickOnUpdateProfileButton(context:context),
      height: 26.px,
      width: 45.w,
  borderRadius: 5.px);
}
