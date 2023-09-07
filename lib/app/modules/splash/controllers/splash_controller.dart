import 'dart:async';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_firebase/my_firebase.dart';

class SplashController extends GetxController {
  final absorbing=false.obs;

  final isGoogleRegistrationButtonClicked = false.obs;

  Map<String, dynamic>? userFirebaseData;

  Map<String, dynamic> bodyParamsForSignInWithGoogleApi = {};

  final userData = Rxn<UserData?>();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> signInWithGoogleApiCalling() async {
    bodyParamsForSignInWithGoogleApi = {
      ApiKeyConstant.fullName: userFirebaseData!["name"],
      ApiKeyConstant.email: userFirebaseData!["email"],
      ApiKeyConstant.loginType: "Google",
    };
    userData.value = await CommonApis.signInWithGoogle(bodyParams: bodyParamsForSignInWithGoogleApi);
    if (userData.value != null) {
      await MyCommonMethods.setString(
          key: ApiKeyConstant.uuid, value: userData.value!.customer!.uuid!);
      if (userData.value?.customer?.isRegister == "1") {
        await MyCommonMethods.setString(key:ApiKeyConstant.token,value: userData.value!.customer!.token!);
        await MyCommonMethods.setString(key: ApiKeyConstant.customerId, value: userData.value?.customer?.customerId.toString() ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedCity, value: userData.value?.customer?.cityName ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: userData.value?.customer?.stateName ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: userData.value?.customer?.countryId ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: userData.value?.customer?.stateId ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.fullName, value: userData.value?.customer?.fullName ?? "");
        await MyCommonMethods.setString(key: UserDataKeyConstant.walletAmount, value: userData.value?.customer?.walletAmount ?? "");
        Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
      } else {
        Get.toNamed(Routes.REGISTRATION, arguments: userFirebaseData);
      }
    }
  }

  void clickOnLoginButton() {
    absorbing.value= CommonMethods.changeTheAbsorbingValueTrue();
    Get.toNamed(Routes.LOGIN);
    absorbing.value= CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnRegisterWithGoogleButton() async {
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    isGoogleRegistrationButtonClicked.value = true;
    userFirebaseData = await MyFirebaseSignIn.signInWithGoogle(context: Get.context!);
    if (userFirebaseData != null) {
      await signInWithGoogleApiCalling();
    }
    isGoogleRegistrationButtonClicked.value = false;
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();
  }

}
