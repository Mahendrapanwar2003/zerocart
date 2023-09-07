import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/modules/profile_menu/views/profile_completion_view.dart';
import 'package:zerocart/model_progress_bar/model_progress_bar.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../custom/custom_appbar.dart';
import '../controllers/profile_menu_controller.dart';

class ProfileMenuView extends GetView<ProfileMenuController> {
  const ProfileMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const MyCustomContainer().myAppBar(text: 'Profile Menu'),
          body: Obx(
            () {
              if (CommonMethods.isConnect.value) {
                return CommonWidgets.commonRefreshIndicator(
                  onRefresh: () => controller.onRefresh(),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: const ProfileCompletionView(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Zconstant.margin),
                            child: CommonWidgets.profileMenuDash(),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.profileMenuItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: .2.h,
                                          horizontal: Zconstant.margin),
                                      onTap: () => controller
                                          .clickOnArrowIconView(index: index),
                                      title: Text(
                                        controller.profileMenuItems[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      trailing: arrowIconView(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Zconstant.margin),
                                      child: CommonWidgets.profileMenuDash(),
                                    ),
                                  ],
                                );
                              }),
                          SizedBox(height: Zconstant.margin),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Zconstant.margin),
                              child: logoutButton()),
                          SizedBox(height: Zconstant.margin),
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return CommonWidgets.commonNoInternetImage(
                  onRefresh: () => controller.onRefresh(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget profileMenuDashView() => Container(
        height: 1,
        margin: EdgeInsets.symmetric(horizontal: 7.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.secondary,
        ),
      );

  Widget arrowIconView() => Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(Get.context!).textTheme.subtitle1?.color,
        size: 18.px,
      );

  Widget logoutButton() => CommonWidgets.myOutlinedButton(
        radius: 5.px,
        text: Text('LOGOUT',
            style: Theme.of(Get.context!)
                .textTheme
                .subtitle1
                ?.copyWith(fontSize: 14.px)),
        onPressed: () => controller.clickOnLogoutButton(),
        height: 42.px,
        margin: EdgeInsets.zero,
      );
}
