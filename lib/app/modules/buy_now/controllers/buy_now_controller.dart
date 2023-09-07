import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_apply_coupon_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_buy_now_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_cart_details_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/buy_now/views/payment_proceed_bottom_sheet.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:http/http.dart' as http;

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';

class BuyNowController extends CommonMethods {
  final count = 0.obs;
  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;

  final proceedToPaymentAbsorbing = false.obs;
  final isClickOnProceedToCheckOut = false.obs;
  String inventoryId = Get.arguments[0];
  final wallets = 'wallet'.obs;
  final others = 'others'.obs;
  final cashOnDelivery = 'cashOnDelivery'.obs;
  final paymentMethod = 'wallet'.obs;
  final valueString = ''.obs;
  final sellPrice = 0.0.obs;
  double sellPriceCopy = 0.0;
  final discountPrice = 0.0.obs;
  double discountPriceCopy = 0.0;
  final deliveryPrice = 0.0.obs;
  final totalPrice = 0.0.obs;
  double totalPriceCopy = 0.0;

  final itemQuantity = 1.obs;
  GetProductByInventoryApiModal? getProductByInventoryApiModal;
  ProductDetail? productDetail;
  AddressDetail? addressDetail;
  Map<String, dynamic> queryParametersForGetProductByInventory = {};

  GetApplyCouponModal? getApplyCouponModal;
  final applyCouponController = TextEditingController();
  Result? applyCouponResult;

  //final isClickOnApplyCoupon = false.obs;
  final isClickOnApplyCouponVisible = false.obs;
  Map<String, dynamic> bodyParametersForApplyCouponApi = {};

  String? paymentType;
  final isApplyCoupon = true.obs;
  final isCouponRange = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    try {
      await callingGetProductByInventoryApi();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
    }
    inAsyncCall.value = false;
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

  Future<void> callingGetProductByInventoryApi() async {
    itemQuantity.value = 1;
    valueString.value = '';
    sellPrice.value = 0.0;
    sellPriceCopy = 0.0;
    discountPrice.value = 0.0;
    discountPriceCopy = 0.0;
    deliveryPrice.value = 0.0;
    totalPrice.value = 0.0;
    totalPriceCopy = 0.0;

    if (inventoryId.isNotEmpty) {
      queryParametersForGetProductByInventory = {'inventoryId': inventoryId};
      Map<String, String> authorization = {};
      String? token =
          await MyCommonMethods.getString(key: ApiKeyConstant.token);
      authorization = {"Authorization": token!};
      http.Response? response = await MyHttp.getMethodForParams(
          baseUri: ApiConstUri.baseUrlForGetMethod,
          endPointUri: ApiConstUri.endPointGetProductByInventoryApi,
          queryParameters: queryParametersForGetProductByInventory,
          authorization: authorization,
          context: Get.context!);
      responseCode = response?.statusCode ?? 0;
      if (response != null) {
        if (await CommonMethods.checkResponse(response: response)) {
          getProductByInventoryApiModal =
              GetProductByInventoryApiModal.fromJson(jsonDecode(response.body));
          if (getProductByInventoryApiModal != null) {
            if (getProductByInventoryApiModal?.addressDetail != null) {
              addressDetail = getProductByInventoryApiModal?.addressDetail;
            }
            if (getProductByInventoryApiModal?.productDetail != null) {
              productDetail = getProductByInventoryApiModal?.productDetail;
              if (productDetail?.isOffer != null &&
                  productDetail?.isOffer == "1") {
                if (productDetail?.deliveryCharge != null &&
                    productDetail!.deliveryCharge!.isNotEmpty &&
                    productDetail?.deliveryCharge != "0.0") {
                  deliveryPrice.value = double.parse(
                      double.parse(productDetail!.deliveryCharge!)
                          .toStringAsFixed(2));
                }
                if (productDetail?.sellPrice != null) {
                  sellPrice.value =
                      double.parse(productDetail!.sellPrice.toString());
                  sellPriceCopy = sellPrice.value;
                }
                if (productDetail?.sellPrice != null &&
                    productDetail?.offerPrice != null) {
                  discountPrice.value =
                      (double.parse(productDetail!.sellPrice.toString()) -
                          double.parse(productDetail!.offerPrice.toString()));
                  discountPriceCopy = discountPrice.value;
                  totalPrice.value = deliveryPrice.value +
                      double.parse(productDetail!.offerPrice.toString());
                  totalPriceCopy = totalPrice.value - deliveryPrice.value;
                }
              } else {
                if (productDetail?.sellPrice != null) {
                  sellPrice.value =
                      double.parse(productDetail!.sellPrice.toString());
                  sellPriceCopy = sellPrice.value;
                  totalPrice.value = sellPrice.value + deliveryPrice.value;
                  totalPriceCopy = sellPrice.value;
                }
              }
            }
          }
        }
      }
      increment();
    }
  }

  Future<void> applyCouponApi() async {
    inAsyncCall.value = true;
    bodyParametersForApplyCouponApi = {
      ApiKeyConstant.couponCode: applyCouponController.text.toString().trim(),
      ApiKeyConstant.inventoryId: productDetail?.inventoryId.toString(),
      ApiKeyConstant.quantity: itemQuantity.toString(),
    };
    getApplyCouponModal = await CommonApis.applyCouponApi(
        bodyParams: bodyParametersForApplyCouponApi);
    if (getApplyCouponModal != null) {
      isApplyCoupon.value = false;
      if (getApplyCouponModal?.result != null) {
        applyCouponResult = getApplyCouponModal?.result;
        if (applyCouponResult?.totalPrice != null &&
            applyCouponResult?.couponDisPrice != null) {
          discountPrice.value = (double.parse(
              int.parse(applyCouponResult!.discount!).toDouble().toString()));
          totalPrice.value = double.parse(
                  int.parse(applyCouponResult!.totalPrice!)
                      .toDouble()
                      .toString()) -
              double.parse(int.parse(applyCouponResult!.discount!)
                  .toDouble()
                  .toString());
          sellPrice.value = double.parse(
              int.parse(applyCouponResult!.totalPrice!).toDouble().toString());
          isCouponRange.value = true;
          /*  discountPrice.value = itemQuantity.value * double.parse(
              int.parse(applyCouponResult!.discount!)
                  .toDouble()
                  .toString()) + (double.parse(productDetail!.sellPrice.toString()) -
              double.parse(productDetail!.offerPrice.toString()));*/
          /*discountPrice.value = (discountPrice.value +
              double.parse(int.parse(applyCouponResult!.totalPrice!)
                  .toDouble()
                  .toString()) -
              double.parse(int.parse(applyCouponResult!.couponDisPrice!)
                  .toDouble()
                  .toString()));
          totalPrice.value = */ /*itemQuantity.value **/ /*
              double.parse(int.parse(applyCouponResult!.couponDisPrice!)
                  .toDouble()
                  .toString());*/
        }
      }
    } else {
      /*totalPrice.value = sellPrice.value;
      sellPrice.value = sellPrice.value;*/
      discountPrice.value = discountPriceCopy;
      applyCouponController.text = '';
      isApplyCoupon.value = true;
      isCouponRange.value = false;
    }
    inAsyncCall.value = false;
  }

  void clickOnBackButton() {
    MyCommonMethods.unFocsKeyBoard();
    Get.back();
  }

  Future<void> clickOnChangeAddressButton(
      {required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    await Get.toNamed(Routes.ADDRESS);
    await callingGetProductByInventoryApi();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnAddAddressButton({required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    await Get.toNamed(Routes.ADD_ADDRESS);
    await callingGetProductByInventoryApi();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnIncreaseQuantityButton() {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    if (productDetail?.availability != null &&
        productDetail!.availability!.isNotEmpty) {
      if (itemQuantity.value < int.parse(productDetail!.availability!)) {
        itemQuantity.value = ++itemQuantity.value;
        if (productDetail?.isOffer != null && productDetail?.isOffer == "1") {
          sellPrice.value = sellPrice.value + sellPriceCopy;
          discountPrice.value = discountPrice.value + discountPriceCopy;
          totalPrice.value = totalPrice.value + totalPriceCopy;
          if (!isApplyCoupon.value) {
            clickOnApplyCouponButtonView();
          }
        } else {
          sellPrice.value = sellPrice.value + sellPriceCopy;
          totalPrice.value = totalPrice.value + totalPriceCopy;
          if (!isApplyCoupon.value) {
            clickOnApplyCouponButtonView();
          }
        }
      }
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnDecreaseQuantityButton() {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    if (productDetail?.availability != null &&
        productDetail!.availability!.isNotEmpty) {
      if (itemQuantity.value > 1) {
        itemQuantity.value = --itemQuantity.value;
        if (productDetail?.isOffer != null && productDetail?.isOffer == "1") {
          sellPrice.value = sellPrice.value - sellPriceCopy;
          discountPrice.value = discountPrice.value - discountPriceCopy;
          totalPrice.value = totalPrice.value - totalPriceCopy;
          if (!isApplyCoupon.value) {
            clickOnApplyCouponButtonView();
          }
        } else {
          sellPrice.value = sellPrice.value - sellPriceCopy;
          totalPrice.value = totalPrice.value - totalPriceCopy;
          if (!isApplyCoupon.value) {
            clickOnApplyCouponButtonView();
          }
        }
      }
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

/*  void clickOnDecreaseQuantityButton() {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    if (itemQuantity.value > 1) {
      itemQuantity.value = --itemQuantity.value;
      if (productDetail?.isOffer != null &&
          productDetail?.isOffer == "1") {
        sellPrice.value = sellPrice.value - sellPriceCopy;
        discountPrice.value = discountPrice.value - discountPriceCopy;
        totalPrice.value = totalPrice.value - totalPriceCopy;
        if (!isApplyCoupon.value) {
          clickOnApplyCouponButtonView();
        }
      } else {
        sellPrice.value = sellPrice.value - sellPriceCopy;
        totalPrice.value = totalPrice.value - totalPriceCopy;
        if (!isApplyCoupon.value) {
          clickOnApplyCouponButtonView();
        }
      }
      */
  /* itemQuantity.value = --itemQuantity.value;
      if (productDetail?.isOffer != null &&
          productDetail?.isOffer == "1") {
        sellPrice.value = sellPrice.value - sellPriceCopy;
        discountPrice.value = discountPrice.value - discountPriceCopy;
        totalPrice.value = totalPrice.value - totalPriceCopy;
        if(!isApplyCoupon.value)
        {
          clickOnApplyCouponButtonView();
        }
      } else {
        sellPrice.value = sellPrice.value - sellPriceCopy;
        totalPrice.value = totalPrice.value - totalPriceCopy;
        if(!isApplyCoupon.value)
        {
          clickOnApplyCouponButtonView();
        }
      }*/
  /*
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }*/

  Future<void> clickOnApplyCouponButtonView() async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    await applyCouponApi();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  clickOnRemoveCouponButtonView({required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    //await onInit();
    totalPrice.value =
        itemQuantity.value * (totalPriceCopy + deliveryPrice.value);
    discountPrice.value = itemQuantity.value * discountPriceCopy;
    sellPrice.value = itemQuantity.value * sellPriceCopy;
    applyCouponController.text = '';
    isApplyCoupon.value = true;
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnProceedToPaymentButton({required BuildContext context}) {
    MyCommonMethods.unFocsKeyBoard();
    if (addressDetail != null) {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColorsLight().secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        context: Get.context!,
        builder: (context) => const PaymentProceedBuyNow(),
      );
    } else {
      MyCommonMethods.showSnackBar(
          message: "Please Add Delivery Address", context: context);
    }
  }

  Future<void> clickOnProceedToCheckout() async {
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    isClickOnProceedToCheckOut.value = true;
    bool isSuccess = false;
    var userMeasurement = await MyCommonMethods.getString(key: "measurement");
    if (userMeasurement != null && userMeasurement.isNotEmpty) {
      if (paymentMethod.value.toString() == "cashOnDelivery") {
        paymentType = "COD";
        bodyParametersForPlaceOrderApi = {
          ApiKeyConstant.paymentMode: paymentType,
          ApiKeyConstant.transId: '',
          ApiKeyConstant.isCart: '0',
          ApiKeyConstant.inventoryId: inventoryId,
          ApiKeyConstant.userMeasurement: userMeasurement,
          ApiKeyConstant.quantity: itemQuantity.value.toString(),
        };
        isSuccess = await placeOrderApiCalling();
        Get.back();
        if (isSuccess) {
          MyCommonMethods.showSnackBar(
              message: "Your order has been placed successfully",
              context: Get.context!);
        }
        bodyParametersForPlaceOrderApi.clear();
      } else if (paymentMethod.value.toString() == "wallet") {
        paymentType = "Wallet";
        bodyParametersForPlaceOrderApi = {
          ApiKeyConstant.paymentMode: paymentType,
          ApiKeyConstant.transId: '',
          ApiKeyConstant.isCart: '0',
          ApiKeyConstant.inventoryId: inventoryId,
          ApiKeyConstant.userMeasurement: userMeasurement,
          ApiKeyConstant.quantity: itemQuantity.value.toString(),
        };
        isSuccess = await placeOrderApiCalling();
        if (isSuccess) {
          bodyParametersForPlaceOrderApi.clear();
          bodyParametersForPlaceOrderApi = {
            ApiKeyConstant.transType: 'debit',
            ApiKeyConstant.outAmt: totalPrice.value.toString(),
          };
          http.Response? response = await CommonApis.walletTransactionApi(
              bodyParams: bodyParametersForPlaceOrderApi);
          if (response != null) {
            Get.back();
            MyCommonMethods.showSnackBar(
                message: "Your order has been placed successfully",
                context: Get.context!);
          }
        }
        Get.back();
        bodyParametersForPlaceOrderApi.clear();
      } else if (paymentMethod.value.toString() == "others") {
        Get.back();
        paymentType = "Online";
        await openGateway(
            type: OpenGetWayType.buyNow,
            priceValue: int.parse(
                double.parse(totalPrice.value.toString()).toInt().toString()),
            inventoryId: inventoryId,
            description: productDetail?.productName ?? "",
            itemQuantity: itemQuantity.value);
      }
    } else {
      Get.back();
      await Get.toNamed(Routes.MEASUREMENTS);
    }
    isClickOnProceedToCheckOut.value = false;
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  onRefresh() async {
    await onInit();
  }
}
