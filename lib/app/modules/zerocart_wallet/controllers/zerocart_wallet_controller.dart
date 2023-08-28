import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_wallet_history_modal.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';

class ZerocartWalletController extends CommonMethods with GetTickerProviderStateMixin{
  final count = 0.obs;
  final absorbing = false.obs;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;
  bool isAnimation = false;

  int load = 0;
  int responseCode = 0;


  GetWalletHistoryModel? getWalletHistoryModel;
  List<WalletHistory> listOfWalletHistory = [];
  WalletHistory? walletHistoryModel;
  int offset = 0;
  String limit = "10";

  Timer? searchOnStoppedTyping;
  final addMoneyController = TextEditingController();
  late AnimationController rotationController;
  Map<String, dynamic> queryParametersForGetWalletApi = {};
  DateTime? dateTime;

  final isAddedMoney = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 30000), vsync: this);
    try {
      await getUserProfileApiCalling();
    } catch (e) {}
    try {
      await getCustomerWalletHistoryApiCalling();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
    isAnimation = true;
    rotationController.forward(from: 0.0); // it starts the animation
    await Future.delayed(const Duration(seconds: 1));
    rotationController.stop();
    isAnimation = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          offset = 0;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  Future<void> onRefresh() async {
    offset = 0;
    rotationController.dispose();
    rotationController.isDismissed;
    await onInit();
  }


  Future<void> onLoadMore() async {
    offset = offset + 10;
    try {
      await getCustomerWalletHistoryApiCalling();
      increment();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(message: "Something went wrong", context: Get.context!);
    }
  }

  Future<void> getCustomerWalletHistoryApiCalling() async {
    queryParametersForGetWalletApi.clear();
    queryParametersForGetWalletApi = {
      ApiKeyConstant.limit: limit,
      ApiKeyConstant.offset: offset.toString()
    };

    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    Map<String, String> authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        authorization: authorization,
        queryParameters: queryParametersForGetWalletApi,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetCustomerWalletHistoryApi);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getWalletHistoryModel =
            GetWalletHistoryModel.fromJson(jsonDecode(response.body));
        if (offset == 0) {
          listOfWalletHistory.clear();
        }
        if (getWalletHistoryModel != null) {
          if (getWalletHistoryModel?.walletHistory != null &&
              getWalletHistoryModel!.walletHistory!.isNotEmpty) {
            isLastPage.value = false;
            getWalletHistoryModel?.walletHistory?.forEach((element) {
              listOfWalletHistory.add(element);
            });
          } else {
            isLastPage.value = true;
          }
        }
      }
    }
  }

  void increment() => count.value++;

  clickOnBackIcon({required BuildContext context}) {
    inAsyncCall.value = true;
    if (!isAnimation) {
      Get.back();
    }
    inAsyncCall.value = false;
  }

  onWillPop() {
    clickOnBackIcon(context: Get.context!);
  }

  Future<void> clickOnRotateIcon() async {
    isAnimation = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    rotationController.forward(from: 0.0); // it starts the animation
    await getUserProfileApiCalling();
    await Future.delayed(const Duration(seconds: 2));
    rotationController.stop();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    isAnimation = false;
  }

  void clickOnArrowIcon() {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    if (addMoneyController.value.text.trim().toString().isNotEmpty) {
      openGateway(
          type: OpenGetWayType.addMoneyWallet,
          priceValue: int.parse(addMoneyController.value.text.trim().toString()),
          description: "Transection From Wallet",
          inAmt: true,
          cancelOrder: false);
    } else {
      MyCommonMethods.showSnackBar(
          message: "Please enter amount!", context: Get.context!);
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnParticularTransection({required int index}) {}
}
