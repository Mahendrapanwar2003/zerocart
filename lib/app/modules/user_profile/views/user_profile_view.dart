import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../custom/custom_appbar.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(context: context),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: const MyCustomContainer().myAppBar(
            isIcon: true,backIconOnPressed: () =>
                controller.clickOnBackIcon(context: context),
            text: 'User Profile'),
        body: Obx(() {
          if (controller.userData.isNotEmpty) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                CommonWidgets.mySizeBox(height: Zconstant.margin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userProfilePicView(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Zconstant.margin,
                    horizontal: Zconstant.margin,
                  ),
                  child: Column(
                    children: [
                      if (controller
                                  .userData[UserDataKeyConstant.fullName] !=
                              null &&
                          controller.userData[UserDataKeyConstant.fullName]
                              .toString()
                              .isNotEmpty)
                        userDetailView(
                            userInfoTitle: 'Name',
                            userInfoContent: controller
                                .userData[UserDataKeyConstant.fullName]),
                      if (controller.userData[UserDataKeyConstant.email] !=
                              null &&
                          controller.userData[UserDataKeyConstant.email]
                              .toString()
                              .isNotEmpty)
                        userDetailView(
                            userInfoTitle: 'Email Address',
                            userInfoContent: controller
                                .userData[UserDataKeyConstant.email]),
                      if (controller.userData[UserDataKeyConstant.mobile] !=
                              null &&
                          controller.userData[UserDataKeyConstant.mobile]
                              .toString()
                              .isNotEmpty)
                        userDetailView(
                            userInfoTitle: 'Phone Number',
                            userInfoContent:controller
                                .userData[UserDataKeyConstant.mobile]),
                      if (controller.userData[UserDataKeyConstant.dob] !=
                              null &&
                          controller.userData[UserDataKeyConstant.dob]
                              .toString()
                              .isNotEmpty)
                        userDetailView(
                            userInfoTitle: 'Date Of Birth',
                            userInfoContent: "${controller.getDayOfMonthSuffix(controller.dateTime!.day)}-${controller.getMonthOfYearSuffix(controller.dateTime!.month)}-${controller.dateTime?.year}"),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            );
          } else {
            return CommonWidgets.progressBarView();
          }
        }),
      ),
    );
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

  Widget userProfileTextView() => Text(
        "User Profile",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget userProfilePicView() => SizedBox(
    height: 158.px,
    child: Container(
      width: 158.px,
      height: 138.px,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5.px ,color: MyColorsLight().borderColor),
        borderRadius: BorderRadius.circular(80.px),
        image: DecorationImage(
          image: (controller.userData[UserDataKeyConstant.profilePicture] !=
                      null &&
                  controller.userData[UserDataKeyConstant.profilePicture]
                      .toString()
                      .isNotEmpty
              ? NetworkImage(CommonMethods.imageUrl(url: controller.userData[UserDataKeyConstant.profilePicture]))
              : CommonWidgets.defaultProfilePicture()) as ImageProvider,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );

  Widget infoTitlesTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.caption,

      );

  Widget infoContentTextVIew({required String text}) => Text(
        text,
        textAlign: TextAlign.right,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget userDetailView(
          {required String userInfoTitle, required String userInfoContent}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 1.25.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            infoTitlesTextView(text: userInfoTitle),
            SizedBox(
              width: Zconstant.margin16,
            ),
            Expanded(
              child: infoContentTextVIew(text: userInfoContent),
            )
          ],
        ),
      );
}
