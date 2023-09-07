import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/model_progress_bar/model_progress_bar.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../custom/custom_appbar.dart';
import '../controllers/privacy_security_controller.dart';

class PrivacySecurityView extends GetView<PrivacySecurityController> {
  const PrivacySecurityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: WillPopScope(
          onWillPop: () => controller.onWillPop(context: context),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const MyCustomContainer().myAppBar(
                isIcon: true,
                backIconOnPressed: () =>
                    controller.clickOnBackIcon(context: context),
                text: 'Privacy & Security'),
            body: Obx(() {
              if (CommonMethods.isConnect.value) {
                if (controller.userDataMap.isNotEmpty) {
                  return CommonWidgets.commonRefreshIndicator(
                    onRefresh: () => controller.onRefresh(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: Zconstant.margin,
                            left: Zconstant.margin,
                            right: Zconstant.margin,
                          ),
                          child: Column(
                            children: [
                              if (controller.userDataMap[
                                          UserDataKeyConstant.lastUpdate] !=
                                      null &&
                                  controller.userDataMap[
                                          UserDataKeyConstant.lastUpdate]
                                      .toString()
                                      .isNotEmpty)
                                userDetailView(
                                    userInfoTitle: 'Last Updated',
                                    userInfoContent: controller
                                        .timeAgo(controller.dateTime!)),
                              if (controller.userDataMap[
                                          UserDataKeyConstant.securityEmail] !=
                                      null &&
                                  controller.userDataMap[
                                          UserDataKeyConstant.securityEmail]
                                      .toString()
                                      .isNotEmpty)
                                userDetailView(
                                    userInfoTitle: 'Security Email',
                                    userInfoContent: controller.userDataMap[
                                        UserDataKeyConstant.securityEmail]),
                              if (controller.userDataMap[UserDataKeyConstant
                                          .securityPhoneCountryCode] !=
                                      null &&
                                  controller.userDataMap[UserDataKeyConstant
                                          .securityPhoneCountryCode]
                                      .toString()
                                      .isNotEmpty)
                                userDetailView(
                                    userInfoTitle: 'Security Phone',
                                    userInfoContent: controller.checkString(
                                        myString: controller.userDataMap[
                                            UserDataKeyConstant
                                                .securityPhone])),
                            ],
                          ),
                        ),
                        listOfButtonView(),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  );
                } else {
                  return CommonWidgets.commonNoDataFoundImage(
                    onRefresh: () => controller.onRefresh(),
                  );
                }
              } else {
                return CommonWidgets.commonNoInternetImage(
                  onRefresh: () => controller.onRefresh(),
                );
              }
            }),
          ),
        ),
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

  Widget privacySecurityTextView() => Text(
        "Privacy & Security",
        style: Theme.of(Get.context!).textTheme.subtitle1,
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

  Widget listOfButtonView() => ListView.builder(
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textButtonView(index: index, context: context),
          ],
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.buttonContent.length,
        padding: EdgeInsets.zero,
      );

  Widget textButtonView({required int index, required BuildContext context}) =>
      ListTile(
        onTap: () =>
            controller.clickOnButton(buttonIndex: index, context: context),
        contentPadding:
            EdgeInsets.symmetric(horizontal: Zconstant.margin, vertical: 0),
        leading: buttonTextView(index: index),
        trailing: arrowIconView(),
        visualDensity: VisualDensity(vertical: -3.px),
      );

  Widget buttonTextView({required int index}) => Text(
        '${controller.buttonContent[index]}',
        style: Theme.of(Get.context!).textTheme.caption,
      );

  Widget arrowIconView() => Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(Get.context!).textTheme.caption?.color,
        size: 18.px,
      );
}
