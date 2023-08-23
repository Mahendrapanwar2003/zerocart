import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_wallet_history_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';

class ZerocartWalletController extends CommonMethods with GetSingleTickerProviderStateMixin {
  final test=false.obs;
  final count = 0.obs;
  final absorbing = false.obs;
  final inAsyncCall= false.obs;
  final isWillPop=false.obs;
  final addMoneyController = TextEditingController();
  final getWalletHistoryModel = Rxn<GetWalletHistoryModel?>();
  final listOfWalletHistory = [];
  final walletHistoryModel = Rxn<WalletHistory?>();
  late AnimationController rotationController;
  int offset = 0;
  final isLoading=false.obs;
  Map<String, dynamic> queryParametersForGetWalletApi = {};
  DateTime? dateTime;
  final scrollController=ScrollController();
  Timer? searchOnStoppedTyping;

  final isAddedMoney = false.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value=CommonMethods.changeTheAbsorbingValueTrue();
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    response.value = false;
    isWillPop.value=true;
    rotationController = AnimationController(duration: const Duration(milliseconds: 30000), vsync: this);
    await getUserProfileApiCalling();
    await getCustomerWalletHistoryApiCalling();
    inAsyncCall.value=CommonMethods.changeTheAbsorbingValueFalse();
    response.value = true;
    rotationController.forward(from: 0.0); // it starts the animation
    await Future.delayed(const Duration(seconds: 1));
    rotationController.stop();
    isWillPop.value=false;
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();

    scrollController.addListener(
            () async {
              if(scrollController.position.isScrollingNotifier.value&&ScrollDirection.reverse==scrollController.position.userScrollDirection)
                {
                  isLoading.value=true;
                }
          if ( scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
           await getCustomerWalletHistoryApiCalling(wantEmpty: false);
            isLoading.value=false;
          }
        }
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void>  getCustomerWalletHistoryApiCalling({
    bool wantEmpty = true,
  }) async {
    if (wantEmpty) {
      getWalletHistoryModel.value = null;
      offset=0;
    }
    queryParametersForGetWalletApi = {
      ApiKeyConstant.limit: 10.toString(),
      ApiKeyConstant.offset: offset.toString()
    };
    // offset = offset + 10;
    getWalletHistoryModel.value = await CommonApis.getCustomerWalletHistoryApi(
        queryParameters: queryParametersForGetWalletApi);
    if (getWalletHistoryModel.value != null) {
      if (getWalletHistoryModel.value?.walletHistory != null &&
          getWalletHistoryModel.value!.walletHistory!.isNotEmpty) {
        if(wantEmpty)
          {
            listOfWalletHistory.clear();
          }
         getWalletHistoryModel.value?.walletHistory?.forEach((element) {
           listOfWalletHistory.add(element);
         });

        if(getWalletHistoryModel.value?.walletHistory != null && getWalletHistoryModel.value!.walletHistory!.isNotEmpty){
          print("offset::::::   $offset");
          offset=offset+10;
        }

      }
    }
    queryParametersForGetWalletApi.clear();

  }

  void increment() => count.value++;

   clickOnBackIcon({required BuildContext context}) {

   if(!isWillPop.value)
     {
       Get.back();
     }

  }

   onWillPop() {
     clickOnBackIcon(context: Get.context!);
   }

  Future<void> clickOnRotateIcon() async {
    isWillPop.value=true;
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    rotationController.forward(from: 0.0); // it starts the animation
    await getUserProfileApiCalling();
    await Future.delayed(const Duration(seconds: 2));
    rotationController.stop();
    isWillPop.value=false;
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnArrowIcon() {
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();

  if (addMoneyController.value.text.trim().toString().isNotEmpty) {
      openGateway(
          type: OpenGetWayType.addMoneyWallet,
          price: int.parse(addMoneyController.value.text.trim().toString()),
          description: "Transection From Wallet",
          inAmt: true,
          cancelOrder: false);
    } else {
      MyCommonMethods.showSnackBar(
          message: "Please enter amount!", context: Get.context!);
    }
  absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();

  }

  void clickOnParticularTransection({required int index}) {}

}
