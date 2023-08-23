import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/modules/home/controllers/home_controller.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../common_widgets/alert_dialog.dart';

class ProfileMenuController extends GetxController {

  final count = 0.obs;
  final progress="0".obs;
  List<String> profileMenuItems = [
    'User Profile',
    'Privacy & Security',
    'My Orders',
    'My Address',
    'Measurements',
    'ZeroCart Wallet',
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    progress.value=await MyCommonMethods.getString(key: UserDataKeyConstant.progress) ?? "0";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> clickOnUpdateProfileButton({required BuildContext context}) async {
    await Get.toNamed(Routes.EDIT_PROFILE);
    progress.value=await MyCommonMethods.getString(key: UserDataKeyConstant.progress) ?? "0";
    await updateUserNameInAppBar();
  }

  Future<void> updateUserNameInAppBar() async {
    HomeController homeController=Get.find();
    homeController.name.value=await MyCommonMethods.getString(key: UserDataKeyConstant.fullName) ??"";
  }

  Future<void> clickOnArrowIconView({required int index}) async {
    if (index == 0) {
     Get.toNamed(Routes.USER_PROFILE);
    } else if (index == 1) {
      Get.toNamed(Routes.PRIVACY_SECURITY);
    } else if (index == 2) {
       Get.toNamed(Routes.MY_ORDERS);
    } else if (index == 3) {
      Get.toNamed(Routes.ADDRESS);
    } else if (index == 4) {
      Get.toNamed(Routes.MEASUREMENTS);
    } else {
      Get.toNamed(Routes.ZEROCART_WALLET);
    }
  }

  void clickOnLogoutButton() {
    showAlertDialog();
  }

  void showAlertDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: ()=>clickOnCancelButton(),
              child: cancelTextButtonView(),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: ()=>clickOnDialogLogOutButton(),
              child: logOutTextButtonView(),
            ),
          ],
          title: titleTextView(),
          content: contentTextView(),
        );
      },
    );
  }

  Widget titleTextView() => Text(
    "Logout",
    style: Theme.of(Get.context!)
        .textTheme
        .subtitle1
        ?.copyWith(fontSize: 20.px),
  );

  Widget contentTextView() => Text(
    "Are you sure you want to logout? This action will clear your cart and wishlist!",
    style: Theme.of(Get.context!).textTheme.subtitle2,
  );

  Widget cancelTextButtonView() => Text(
        "Cancel",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(color: MyColorsLight().textGrayColor),
      );

  Widget logOutTextButtonView() => Text(
    "Logout",
    style: Theme.of(Get.context!)
        .textTheme
        .subtitle2
        ?.copyWith(color: MyColorsLight().error),
  );

  void clickOnCancelButton() {
    Get.back();
  }

  Future<void> clickOnDialogLogOutButton() async {
    await MyCommonMethods.setString(key:ApiKeyConstant.token,value:"");
    await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value:'' );
    await MyCommonMethods.setString(key: ApiKeyConstant.stateId, value: '');
    await MyCommonMethods.setString(key: UserDataKeyConstant.selectedCity, value:'');
    await MyCommonMethods.setString(key: ApiKeyConstant.cityId, value: '');
    selectedIndex.value = 0;
    Get.deleteAll();
    Get.offAllNamed(Routes.SPLASH);
  }

}
