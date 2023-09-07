import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:zerocart/app/modules/outfit_room/controllers/outfit_room_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:http/http.dart' as http;

import '../../../../notification.dart';

class HomeController extends CommonMethods {
  final count = 0.obs;
  final current = 0.obs;
  final name = ''.obs;
  final walletAmount = ''.obs;
  final notificationCount = ''.obs;
  String? customerId;

  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;

  bool isLocationDialog = true;
  final height = MediaQuery.of(Get.context!).viewPadding.top.obs;

  GetLatLong? getLatLong;
  UserData? userDataLocal;

  GetBanner? getBanner;
  List<Banners>? listOfBanner;
  List<dynamic> bannerImageList = [];

  DashboardDetailModel? dashboardDetailModel;

  RecentProduct? recentProductsModel;
  List<HomeProducts> recentProductsList = [];

  RecentProduct? topTrendingProductsModel;
  List<HomeProducts> topTrendingProductsList = [];

  RecentProduct? topTrendingProducts2Model;
  List<HomeProducts> topTrendingProductsList2 = [];

  GetProductListForHome? getProductListDefaultForHomeModel;
  List<ProductList> productListDefault = [];

  Map<String, dynamic> queryParametersForRecentProductApi = {};

  Map<String, dynamic> bodyParamsForTopTrendingProductApi = {};

  Map<String, dynamic> bodyParamsForUpdateFcmIdApi = {};

  //final isShimmer = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    notificationGet();
    setEmpty();
    await MyCommonMethods.setString(
        key: ApiKeyConstant.isSlider, value: ApiKeyConstant.isSlider);
    onReload();
    inAsyncCall.value = true;
    try {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
      customerId =
          await MyCommonMethods.getString(key: ApiKeyConstant.customerId);
      if (getLatLong != null) {
        await callingApi();
      } else {
        isLocationDialog = false;
        locationAlertDialog();
        inAsyncCall.value = false;
      }
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
    }
    inAsyncCall.value = false;
/*


    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      getLatLong = await MyLocation.getUserLatLong(context: Get.context!);
      customerId = await MyCommonMethods.getString(key: ApiKeyConstant.customerId);
      if (getLatLong != null) {
        await homeControllerOnInIt();
      } else {
        isLocationDialog = false;
        locationAlertDialog();
        inAsyncCall.value = false;
      }
    } else {
      MyCommonMethods.showSnackBar(
          message: "Check your internet connection!", context: Get.context!);
      inAsyncCall.value = false;
    }
    onConnectivityChange();*/
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

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  void setEmpty() {
    userDataLocal = null;
    recentProductsModel = null;
    topTrendingProductsModel = null;
    topTrendingProducts2Model = null;
    listOfBanner = null;
    getBanner = null;
    listOfBanner?.clear();
    bannerImageList.clear();
    recentProductsList.clear();
    topTrendingProductsList.clear();
    topTrendingProductsList2.clear();
    productListDefault.clear();
  }

  Future<void> callingApi() async {
    await getUserProfileApi();
    await getUserData();
    await getNotificationCount();
    await getBannerApiCalling();
    await getDefaultProductListApi();
    await getRecentProduct();
    await getTopTrendingProduct();
    await getTopTrendingProduct2();
    updateFcmIdApiCalling();
  }

  getUserProfileApi() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetUserDataApi,
        token: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        userData = UserData.fromJson(jsonDecode(response.body));
        if (userData != null) {
          await CommonMethods.setUserData(userData: userData);
        }
      }
    }
  }

  Future<void> updateFcmIdApiCalling() async {
    String? fcmId = await MyFirebaseSignIn.getUserFcmId(context: Get.context!);
    if (fcmId != null && fcmId != "") {
      bodyParamsForUpdateFcmIdApi = {ApiKeyConstant.fcmId: fcmId};
      http.Response? response = await CommonApis.updateFcmIdApi(
          bodyParams: bodyParamsForUpdateFcmIdApi);
      responseCode = response?.statusCode ?? 0;
      if (response != null) {}
    }
    increment();
  }

  Future<void> getBannerApiCalling() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetBannerApi,
        token: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getBanner = GetBanner.fromJson(jsonDecode(response.body));
        if (getBanner != null) {
          listOfBanner = getBanner?.banner;
          listOfBanner?.forEach((element) {
            bannerImageList.add(NetworkImage(
              CommonMethods.imageUrl(url: element.bannerImage.toString()),
            ));
          });
        }
      }
    }
    increment();
  }

  Future<void> getNotificationCount() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointDashboardDetailApi,
        token: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        dashboardDetailModel =
            DashboardDetailModel.fromJson(jsonDecode(response.body));
        if (dashboardDetailModel != null) {
          if (dashboardDetailModel!.notificationCount != null &&
              dashboardDetailModel!.notificationCount!.isNotEmpty) {
            notificationCount.value = dashboardDetailModel!.notificationCount!;
          }
        }
      }
    }
    increment();
  }

  Future<void> getRecentProduct() async {
    queryParametersForRecentProductApi = {'cId': customerId.toString()};
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParametersForRecentProductApi,
        authorization: authorization,
        baseUri: '172.188.16.156:8000',
        endPointUri: ApiConstUri.endPointGetRecentProductApi);
    //responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        recentProductsModel = RecentProduct.fromJson(jsonDecode(response.body));
        recentProductsModel = await CommonApis.getRecentProductApi(
            queryParameters: queryParametersForRecentProductApi);
        if (recentProductsModel != null) {
          if (recentProductsModel?.products != null &&
              recentProductsModel!.products!.isNotEmpty) {
            recentProductsList = recentProductsModel?.products ?? [];
          }
        }
      }
    }
    increment();
  }

  Future<void> getTopTrendingProduct() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: {'cId': customerId.toString()},
        authorization: authorization,
        baseUri: '172.188.16.156:8000',
        endPointUri: ApiConstUri.endPointGetTopTrendingProductApi);
    //responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        topTrendingProductsModel =
            RecentProduct.fromJson(jsonDecode(response.body));
        if (topTrendingProductsModel != null) {
          if (topTrendingProductsModel?.products != null &&
              topTrendingProductsModel!.products!.isNotEmpty) {
            topTrendingProductsList = topTrendingProductsModel?.products ?? [];
          }
        }
      }
    }
    increment();
  }

  Future<void> getTopTrendingProduct2() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: {'cId': customerId.toString()},
        authorization: authorization,
        baseUri: '172.188.16.156:8000',
        endPointUri: ApiConstUri.endPointGetTopTrendingProductApi2);
    //responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        topTrendingProducts2Model =
            RecentProduct.fromJson(jsonDecode(response.body));
        if (topTrendingProducts2Model != null) {
          if (topTrendingProducts2Model?.products != null &&
              topTrendingProducts2Model!.products!.isNotEmpty) {
            topTrendingProductsList2 =
                topTrendingProducts2Model?.products ?? [];
          }
        }
      }
    }
    increment();
  }

  Future<void> getDefaultProductListApi() async {
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!,
        url: ApiConstUri.endPointGetDefaultProductListApi);
    //responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getProductListDefaultForHomeModel =
            GetProductListForHome.fromJson(jsonDecode(response.body));
        if (getProductListDefaultForHomeModel != null) {
          if (getProductListDefaultForHomeModel?.productList != null &&
              getProductListDefaultForHomeModel!.productList!.isNotEmpty) {
            productListDefault =
                getProductListDefaultForHomeModel?.productList ?? [];
          }
        }
      }
    }
    increment();
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
        if (getBanner == null) {
          await onInit();
        }
      } else {}
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
    name.value =
        await MyCommonMethods.getString(key: UserDataKeyConstant.fullName) ??
            "";
    walletAmount.value = await MyCommonMethods.getString(
            key: UserDataKeyConstant.walletAmount) ??
        "0.00";
  }

  Future<void> clickOnCard({required String productId}) async {
    await Get.toNamed(Routes.PRODUCT_DETAIL, arguments: productId);
    onInit();
  }

  Future<void> clickOnCustomizeButton({required BuildContext context}) async {
    await Get.delete<OutfitRoomController>();
    Get.lazyPut<OutfitRoomController>(
      () => OutfitRoomController(),
    );
    Get.toNamed(Routes.OUTFIT_ROOM, arguments: 0.0);
  }

  Future<void> clickOnNotification() async {
    await Get.toNamed(Routes.NOTIFICATION);
    await onInit();
  }

  Future<void> clickOnWalletCard() async {
    await Get.toNamed(Routes.ZEROCART_WALLET);
    await onInit();
  }

  Future<void> clickOnSearchField({required bool isSearch}) async {
    await Get.toNamed(Routes.SEARCH_ITEM, arguments: isSearch);
    await onInit();
  }

  onRefresh() async {
    await onInit();
  }

  void notificationGet() {
    ///gives you the message on which user taps and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        NotificationServiceForAndroid().sendNotification(
            title: message.notification!.title!,
            body: message.notification!.body!);
      }
    });

    ///foreground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        NotificationServiceForAndroid().sendNotification(
            title: message.notification!.title!,
            body: message.notification!.body!);
      }
    });

    ///When the app is in background but opened and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationServiceForAndroid().sendNotification(
          title: message.notification!.title!,
          body: message.notification!.body!);
    });
  }
}
