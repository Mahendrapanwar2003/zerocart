import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
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

class BuyNowController extends CommonMethods {
  final count = 0.obs;
  final proceedToPaymentAbsorbing = false.obs;
  final isClickOnProceedToCheckOut = false.obs;
  String inventoryId = Get.arguments[0];
  final wallets = 'wallet'.obs;
  final others = 'others'.obs;
  final cashOnDelivery = 'cashOnDelivery'.obs;
  final paymentMethod = 'wallet'.obs;
  final absorbing = false.obs;
  final valueString = ''.obs;
  final sellPrice = 0.0.obs;
  double sellPriceCopy = 0.0;
  final discountPrice = 0.0.obs;
  double discountPriceCopy = 0.0;
  final deliveryPrice = 0.0.obs;
  final totalPrice = 0.0.obs;
  double totalPriceCopy = 0.0;

  final itemQuantity = 1.obs;
  final getProductByInventoryApiModal = Rxn<GetProductByInventoryApiModal>();
  final productDetail = Rxn<ProductDetail?>();
  final addressDetail = Rxn<AddressDetail?>();
  Map<String, dynamic> queryParametersForGetProductByInventory = {};

  final getApplyCouponModal = Rxn<GetApplyCouponModal?>();
  final applyCouponController = TextEditingController();
  final applyCouponResult = Rxn<Result?>();

  //final isClickOnApplyCoupon = false.obs;
  final isClickOnApplyCouponVisible = false.obs;
  Map<String, dynamic> bodyParametersForApplyCouponApi = {};

  String? paymentType;
  final isApplyCoupon = true.obs;
  final isCouponRange = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingGetProductByInventoryApi();
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
      absorbing.value = true;
      queryParametersForGetProductByInventory = {'inventoryId': inventoryId};
      getProductByInventoryApiModal.value =
          await CommonApis.getProductByInventoryApi(
              queryParameters: queryParametersForGetProductByInventory);
      if (getProductByInventoryApiModal.value != null) {
        if (getProductByInventoryApiModal.value?.addressDetail != null) {
          addressDetail.value =
              getProductByInventoryApiModal.value?.addressDetail;
        }
        if (getProductByInventoryApiModal.value?.productDetail != null) {
          productDetail.value =
              getProductByInventoryApiModal.value?.productDetail;
          if (productDetail.value?.isOffer != null &&
              productDetail.value?.isOffer == "1") {
            if (productDetail.value?.deliveryCharge != null &&
                productDetail.value!.deliveryCharge!.isNotEmpty &&
                productDetail.value?.deliveryCharge != "0.0") {
              deliveryPrice.value = double.parse(
                  double.parse(productDetail.value!.deliveryCharge!)
                      .toStringAsFixed(2));
            }
            if (productDetail.value?.sellPrice != null) {
              sellPrice.value =
                  double.parse(productDetail.value!.sellPrice.toString());
              sellPriceCopy = sellPrice.value;
            }
            if (productDetail.value?.sellPrice != null &&
                productDetail.value?.offerPrice != null) {
              discountPrice.value =
                  (double.parse(productDetail.value!.sellPrice.toString()) -
                      double.parse(productDetail.value!.offerPrice.toString()));
              discountPriceCopy = discountPrice.value;
              totalPrice.value = deliveryPrice.value +
                  double.parse(productDetail.value!.offerPrice.toString());
              totalPriceCopy = totalPrice.value - deliveryPrice.value;
            }
          } else {
            if (productDetail.value?.sellPrice != null) {
              sellPrice.value =
                  double.parse(productDetail.value!.sellPrice.toString());
              sellPriceCopy = sellPrice.value;
              totalPrice.value = sellPrice.value + deliveryPrice.value;
              totalPriceCopy = sellPrice.value;
            }
          }
        }
      }
    }
    absorbing.value = false;
  }

  Future<void> applyCouponApi() async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    bodyParametersForApplyCouponApi = {
      ApiKeyConstant.couponCode: applyCouponController.text.toString().trim(),
      ApiKeyConstant.inventoryId: productDetail.value?.inventoryId.toString(),
      ApiKeyConstant.quantity: itemQuantity.toString(),
    };
    getApplyCouponModal.value = await CommonApis.applyCouponApi(
        bodyParams: bodyParametersForApplyCouponApi);
    if (getApplyCouponModal.value != null) {
      isApplyCoupon.value = false;
      if (getApplyCouponModal.value?.result != null) {
        applyCouponResult.value = getApplyCouponModal.value?.result;
        if (applyCouponResult.value?.totalPrice != null &&
            applyCouponResult.value?.couponDisPrice != null) {
          discountPrice.value =
              (double.parse(int.parse(applyCouponResult.value!.discount!)
                  .toDouble()
                  .toString()));
          totalPrice.value = double.parse(
                  int.parse(applyCouponResult.value!.totalPrice!)
                      .toDouble()
                      .toString()) -
              double.parse(int.parse(applyCouponResult.value!.discount!)
                  .toDouble()
                  .toString());
          sellPrice.value = double.parse(
              int.parse(applyCouponResult.value!.totalPrice!)
                  .toDouble()
                  .toString());
          isCouponRange.value= true;
          /*  discountPrice.value = itemQuantity.value * double.parse(
              int.parse(applyCouponResult.value!.discount!)
                  .toDouble()
                  .toString()) + (double.parse(productDetail.value!.sellPrice.toString()) -
              double.parse(productDetail.value!.offerPrice.toString()));*/
          /*discountPrice.value = (discountPrice.value +
              double.parse(int.parse(applyCouponResult.value!.totalPrice!)
                  .toDouble()
                  .toString()) -
              double.parse(int.parse(applyCouponResult.value!.couponDisPrice!)
                  .toDouble()
                  .toString()));
          totalPrice.value = */ /*itemQuantity.value **/ /*
              double.parse(int.parse(applyCouponResult.value!.couponDisPrice!)
                  .toDouble()
                  .toString());*/
        }
      }
      absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    } else {
      totalPrice.value = sellPrice.value;
      sellPrice.value = sellPrice.value;
      discountPrice.value = 0.0;
      applyCouponController.text = '';
      isApplyCoupon.value = true;
      isCouponRange.value= false;
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnBackButton() {
    MyCommonMethods.unFocsKeyBoard();
    Get.back();
  }

  Future<void> clickOnChangeAddressButton(
      {required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    await Get.toNamed(Routes.ADDRESS);
    await callingGetProductByInventoryApi();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnAddAddressButton({required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    await Get.toNamed(Routes.ADD_ADDRESS);
    await callingGetProductByInventoryApi();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnIncreaseQuantityButton() {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    if (productDetail.value?.availability != null &&
        productDetail.value!.availability!.isNotEmpty) {
      if (itemQuantity.value < int.parse(productDetail.value!.availability!)) {
        itemQuantity.value = ++itemQuantity.value;
        if (productDetail.value?.isOffer != null &&
            productDetail.value?.isOffer == "1") {
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
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnDecreaseQuantityButton() {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    if (itemQuantity.value > 1) {
      itemQuantity.value = --itemQuantity.value;
      if (productDetail.value?.isOffer != null &&
          productDetail.value?.isOffer == "1") {
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
      /* itemQuantity.value = --itemQuantity.value;
      if (productDetail.value?.isOffer != null &&
          productDetail.value?.isOffer == "1") {
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
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnApplyCouponButtonView() async {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    await applyCouponApi();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  clickOnRemoveCouponButtonView({required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    //await onInit();
    totalPrice.value = itemQuantity.value * (totalPriceCopy + deliveryPrice.value);
    discountPrice.value = itemQuantity.value * discountPriceCopy;
    sellPrice.value = itemQuantity.value * sellPriceCopy;
    applyCouponController.text = '';
    isApplyCoupon.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnProceedToPaymentButton({required BuildContext context}) {
    MyCommonMethods.unFocsKeyBoard();
    if (addressDetail.value != null) {
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
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    isClickOnProceedToCheckOut.value = true;
    bool isSuccess = false;
    var userMeasurement = await MyCommonMethods.getString(key: "measurement");
    if(userMeasurement!=null && userMeasurement.isNotEmpty)
      {
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
        }
        else if (paymentMethod.value.toString() == "wallet") {
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
        }
        else if (paymentMethod.value.toString() == "others") {
          Get.back();
          paymentType = "Online";
          await openGateway(
              type: OpenGetWayType.buyNow,
              priceValue: int.parse(
                  double.parse(totalPrice.value.toString()).toInt().toString()),
              inventoryId: inventoryId,
              description: productDetail.value?.productName ?? "",
              itemQuantity: itemQuantity.value);
        }
      }else{
      Get.back();
      await Get.toNamed(Routes.MEASUREMENTS);
    }
    isClickOnProceedToCheckOut.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }
}
