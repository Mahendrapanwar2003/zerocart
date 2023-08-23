import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/dashboard_detail_model.dart';
import 'package:zerocart/app/apis/api_modals/get%20_recent_product_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_banner_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_product_list_home_model.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/alert_dialog.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/modules/outfit_room/controllers/outfit_room_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class HomeController extends CommonMethods {
  final count = 0.obs;
  final current = 0.obs;
  final name = ''.obs;
  final walletAmount = ''.obs;
  final notificationCount = ''.obs;
  String? customerId;
  final inAsyncCall = false.obs;
  bool isLocationDialog = true;
  final height = MediaQuery.of(Get.context!).viewPadding.top.obs;

  GetLatLong? getLatLong;
  final userDataLocal = Rxn<UserData?>();

  final getBanner = Rxn<GetBanner?>();
  List<Banners>? listOfBanner;
  List<dynamic> bannerImageList = [];

  final getProductApiModel = Rxn<RecentProduct>();
  List<HomeProducts> recentProductsList=[];
  List<HomeProducts> topTrendingProductsList=[];
  List<HomeProducts> topTrendingProductsList2=[];

  final getProductListDefaultForHomeModel = Rxn<GetProductListForHome>();
  List<ProductList> productListDefault =[];

  Map<String, dynamic> queryParametersForRecentProductApi = {};

  Map<String, dynamic> bodyParamsForTopTrendingProductApi = {};

  Map<String, dynamic> bodyParamsForUpdateFcmIdApi = {};

  final isShimmer=false.obs;

  //TODO This Code Comment By Aman
  /*final getRecentProductApiModel=Rxn<GetRecentProductApiModel>();
  List<RecentSearchList>? recentSearchList ;

  final getTopTrendingProductApiModel=Rxn<TopTrendingApiModal>();
  List<TrendingList>? trendingList ;*/


  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value=true;
    if(await MyCommonMethods.internetConnectionCheckerMethod())
      {

        getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
        customerId = await MyCommonMethods.getString(key: ApiKeyConstant.customerId);
        if (getLatLong != null) {
          await homeControllerOnInIt();
        } else {
          isLocationDialog = false;
          locationAlertDialog();
          inAsyncCall.value=false;
        }
      }
    else
      {
        MyCommonMethods.showSnackBar(message: "Check your internet connection!", context: Get.context!);
        inAsyncCall.value=false;
      }
    onConnectivityChange();
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

  Future<void> homeControllerOnInIt({bool wantEmpty = true}) async {
      if (wantEmpty) {
        setEmpty();
      }
      await MyCommonMethods.setString(key: ApiKeyConstant.isSlider, value: ApiKeyConstant.isSlider);
      await callingApi();
  }

  void setEmpty() {
    userDataLocal.value = null;
    getProductApiModel.value = null;
    listOfBanner = null;
    getBanner.value = null;
    listOfBanner?.clear();
    bannerImageList.clear();
    recentProductsList.clear();
    topTrendingProductsList.clear();
    topTrendingProductsList2.clear();
  }

  Future<void> callingApi() async {
    isShimmer.value=true;
    await getUserProfileApiCalling();
    await getUserData();
    await getNotificationCount();
    await getBannerApiCalling();
    await getDefaultProductListApi();
    inAsyncCall.value=false;
    await getRecentProduct();
    await getTopTrendingProduct();
    await getTopTrendingProduct2();
    isShimmer.value=false;

    updateFcmIdApiCalling();
  }

  Future<void> updateFcmIdApiCalling() async {
    String? fcmId = await MyFirebaseSignIn.getUserFcmId(context: Get.context!);
    if (fcmId != null && fcmId != "") {
      bodyParamsForUpdateFcmIdApi = {ApiKeyConstant.fcmId: fcmId};
      await CommonApis.updateFcmIdApi(bodyParams: bodyParamsForUpdateFcmIdApi);
    }
  }

  Future<void> getBannerApiCalling() async {
    getBanner.value = await CommonApis.getBannerApi();
    if (getBanner.value != null) {
      listOfBanner = getBanner.value?.banner;
      listOfBanner?.forEach((element) {
        bannerImageList.add(NetworkImage(
          CommonMethods.imageUrl(url: element.bannerImage.toString()),
        ));
      });
    }
  }

  Future<void> getNotificationCount() async {
    DashboardDetailModel? dashboardDetailModel =
        await CommonApis.dashboardDetailApi();
    if (dashboardDetailModel != null) {
      if (dashboardDetailModel.notificationCount != null &&
          dashboardDetailModel.notificationCount!.isNotEmpty) {
        notificationCount.value = dashboardDetailModel.notificationCount!;
      }
    }
  }

  Future<void> getRecentProduct() async {
    queryParametersForRecentProductApi = {'cId': customerId.toString()};
    getProductApiModel.value = await CommonApis.getRecentProductApi(
        queryParameters: queryParametersForRecentProductApi);
    if (getProductApiModel.value != null) {
      if (getProductApiModel.value?.products != null &&
          getProductApiModel.value!.products!.isNotEmpty) {
        recentProductsList = getProductApiModel.value?.products??[];
      }
    }
  }

  Future<void> getTopTrendingProduct() async {
    getProductApiModel.value = await CommonApis.getTopTrendingProductApi(queryParameters: {'cId': customerId.toString()});
    if (getProductApiModel.value != null) {
      if (getProductApiModel.value?.products != null &&
          getProductApiModel.value!.products!.isNotEmpty) {
        topTrendingProductsList = getProductApiModel.value?.products??[];
      }
    }
  }

  Future<void> getTopTrendingProduct2() async {
    getProductApiModel.value = await CommonApis.getTopTrendingProductApi2(
        queryParameters: {'cId': customerId.toString()});
    if (getProductApiModel.value != null) {
      if (getProductApiModel.value?.products != null &&
          getProductApiModel.value!.products!.isNotEmpty) {
        topTrendingProductsList2 = getProductApiModel.value?.products??[];
      }
    }
  }

  Future<void> getDefaultProductListApi() async {
    getProductListDefaultForHomeModel.value = await CommonApis.getDefaultProductListApiForHome();
    if (getProductListDefaultForHomeModel.value != null) {
      if (getProductListDefaultForHomeModel.value?.productList  != null && getProductListDefaultForHomeModel.value!.productList !.isNotEmpty) {
        productListDefault = getProductListDefaultForHomeModel.value?.productList ?? [];
        print("productListDefault:::::::::::::::::::::::::::::::$productListDefault");
      }
    }
  }

  onWillPop() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CommonDialog.commonAlertDialogBox(
          leftButtonOnPressed: () {
            Get.back();
          },
          rightButtonOnPressed: () {
            exit(0);
          },
          title: 'Close App',
          content: "Are you sure you want to exit the application",
          leftButtonTitle: 'Cancel',
          rightButtonTitle: 'Exit',
          rightButtonTitleColor: MyColorsLight().error,
          leftButtonTitleColor: MyColorsLight().textGrayColor,
        );
      },
    );
  }

  Future<bool> onWillPopForAlertDialog() async {
    return isLocationDialog;
  }

  void onConnectivityChange() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (getBanner.value == null) {
          await onInit();
        }
      } else {

      }
    });
  }

  void locationAlertDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => onWillPopForAlertDialog(),
          child: MyAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => clickOnDialogGivePermissionButton(),
                child: givePermissionTextButtonView(),
              ),
            ],
            title: titleTextView(),
            content: contentTextView(),
          ),
        );
      },
    );
  }

  Widget titleTextView() => Text(
        "Permission",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 20.px),
      );

  Widget contentTextView() => Text(
        "Please Give Location Permission For Use This App!",
        style: Theme.of(Get.context!).textTheme.subtitle2,
      );

  Widget givePermissionTextButtonView() => Text(
        "Give Permission",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(color: MyColorsLight().success),
      );

  Future<void> clickOnDialogGivePermissionButton() async {
    Get.back();
    await onInit();
  }

  Future<void> getUserData() async {
    name.value = await MyCommonMethods.getString(key: UserDataKeyConstant.fullName) ?? "";
    walletAmount.value = await MyCommonMethods.getString(key: UserDataKeyConstant.walletAmount) ?? "0.00";
  }

  Future<void> clickOnCard({required String productId}) async {
    await Get.toNamed(Routes.PRODUCT_DETAIL, arguments: productId);
    onInit();
  }

  Future<void> clickOnCustomizeButton({required BuildContext context}) async {
    await Get.delete<OutfitRoomController>();
    Get.lazyPut<OutfitRoomController>(() => OutfitRoomController(),
    );
    Get.toNamed(Routes.OUTFIT_ROOM,arguments: 0.0);
  }

  Future<void> clickOnNotification() async {
    await Get.toNamed(Routes.NOTIFICATION);
    inAsyncCall.value=true;
    await homeControllerOnInIt();
  }

  Future<void> clickOnWalletCard() async {
    await Get.toNamed(Routes.ZEROCART_WALLET);
    inAsyncCall.value=true;
    await homeControllerOnInIt();
  }

  Future<void> clickOnSearchField({required bool isSearch}) async {
    await Get.toNamed(Routes.SEARCH_ITEM, arguments: isSearch);
    inAsyncCall.value=true;
    await homeControllerOnInIt();
  }
}
