import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_apply_coupon_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_cart_details_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../views/payment_proceed_bottom_sheet.dart';
import 'package:http/http.dart' as http;

class MyCartController extends CommonMethods {
  bool wantBackButton = Get.arguments ?? false;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;
  final isLastPage = false.obs;
  final proceedToPaymentAbsorbing = false.obs;
  final isClickOnApplyCoupon = false.obs;
  final isClickOnProceedToCheckOut = false.obs;
  final isClickOnApplyCouponVisible = false.obs;
  final wallets = 'wallet'.obs;
  final others = 'others'.obs;
  final cashOnDelivery = 'COD'.obs;
  final paymentMethod = 'wallet'.obs;
  final count = 0.obs;
  final showDropDown = false.obs;
  double? latitude;
  double? longitude;
  GetLatLong? getLatLong;
  Map<String, dynamic> queryParametersForGetCartApi = {};

  GetCartDetailsModel? getCartDetailsModel;
  List<CartItemList> cartItemList = [];
  List checkedCarItemList = [];
  List checkedListItemQuantity = [];
  List checkedListItemAvailability = [];
  List unCheckedListItemAvailability = [];
  List checkedListItemVariant = [];
  List checkedListItemVariant1 = [];
  List unCheckedCartItemList = [];
  List unCheckedListItemQuantity = [];
  List uncheckedListItemVariant = [];
  List uncheckedListItemVariant1 = [];
  CartItemList? cartItem;
  AddressDetail? addressDetail;
  Map<String, dynamic> bodyParamsForRemoveCartItemApi = {};
  Map<String, dynamic> bodyParamsForCartItemSelectionApi = {};
  Map<String, dynamic> bodyParamsForManageCartApi = {};
  final valueString = ''.obs;
  final sellPrice = 0.0.obs;
  final discountPrice = 0.0.obs;
  final deliveryPrice = 0.0.obs;
  final totalPrice = 0.0.obs;
  GetApplyCouponModal? getApplyCouponModal;
  final applyCouponController = TextEditingController();
  Result? applyCouponResult;
  Map<String, dynamic> bodyParametersForApplyCouponApi = {};

  String? paymentType;

  final itemQuantity = 1.obs;

  final isApplyCoupon = true.obs;
  final isCouponRange = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    responseCode = 0;
    onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        await getCartDetailsModelApiCalling();
      } catch (e) {
        MyCommonMethods.showSnackBar(
            message: "Something went wrong", context: Get.context!);
        responseCode = 100;
      }
    }
    inAsyncCall.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          //offset = 0;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  void increment() => count.value++;

  Future<void> getCartDetailsModelApiCalling() async {
    setEmpty();
      Map<String, String> authorization = {};
      String? token =
      await MyCommonMethods.getString(key: ApiKeyConstant.token);
      authorization = {"Authorization": token!};
      http.Response? response = await MyHttp.getMethodForParams(
          context: Get.context!,
          queryParameters: queryParametersForGetCartApi,
          authorization: authorization,
          baseUri: ApiConstUri.baseUrlForGetMethod,
          endPointUri: ApiConstUri.endPointGetCartDetailsApi);
      responseCode = response?.statusCode ?? 0;
      if (response != null) {
        if (await CommonMethods.checkResponse(response: response)) {
          getCartDetailsModel = GetCartDetailsModel.fromJson(jsonDecode(response.body));
          /*if (offset == 0) {
            products.clear();
          }*/
          if (getCartDetailsModel != null) {
            if (getCartDetailsModel?.addressDetail != null) {
              addressDetail = getCartDetailsModel?.addressDetail;
            }
            if (getCartDetailsModel?.totalDeliveryCharge != null) {
              discountPrice.value = double.parse(getCartDetailsModel!.totalDeliveryCharge!
                  .toDouble()
                  .toString());
            }
            if (getCartDetailsModel!.cartItemList != null &&
                getCartDetailsModel!.cartItemList!.isNotEmpty) {
              cartItemList = getCartDetailsModel!.cartItemList!;
              cartItemList.forEach((element) {
                if (element.availability != null && element.availability != "0") {
                  if (element.userSelection != null &&
                      element.userSelection == "1") {
                    if (element.varientList != null &&
                        element.varientList!.isNotEmpty) {
                      checkedListItemVariant.add(element.varientList![0]);
                    } else {
                      checkedListItemVariant.add(null);
                    }
                    checkedCarItemList.add(element);
                    checkedListItemQuantity.add(int.parse(element.cartQty!));
                    for (int i = 1; i <= int.parse(element.cartQty!); i++) {
                      if (element.isOffer != null && element.isOffer == "1") {
                        if (element.sellPrice != null &&
                            element.offerPrice != null) {
                          sellPrice.value = double.parse(
                              double.parse(element.sellPrice!)
                                  .toDouble()
                                  .toStringAsFixed(2)) +
                              sellPrice.value;
                          discountPrice.value = (double.parse(
                              double.parse(element.sellPrice!)
                                  .toDouble()
                                  .toStringAsFixed(2)) -
                              double.parse(double.parse(element.offerPrice!)
                                  .toDouble()
                                  .toStringAsFixed(2))) +
                              discountPrice.value;
                        }
                      } else {
                        if (element.sellPrice != null &&
                            element.sellPrice!.isNotEmpty) {
                          sellPrice.value = double.parse(
                              double.parse(element.sellPrice!)
                                  .toDouble()
                                  .toStringAsFixed(2)) +
                              sellPrice.value;
                        }
                      }
                    }
                    checkedListItemAvailability.add(element.availability);
                  } else {
                    if (element.varientList != null &&
                        element.varientList!.isNotEmpty) {
                      uncheckedListItemVariant.add(element.varientList![0]);
                    } else {
                      uncheckedListItemVariant.add(null);
                    }
                    unCheckedListItemQuantity.add(int.parse(element.cartQty!));
                    unCheckedCartItemList.add(element);
                    unCheckedListItemAvailability.add(element.availability);
                  }
                } else {
                  if (element.varientList != null &&
                      element.varientList!.isNotEmpty) {
                    uncheckedListItemVariant.add(element.varientList![0]);
                  } else {
                    uncheckedListItemVariant.add(null);
                  }
                  unCheckedListItemQuantity.add(int.parse(element.cartQty!));
                  unCheckedCartItemList.add(element);
                  unCheckedListItemAvailability.add(element.availability);
                }
              });
            }
            else {
              isLastPage.value = true;
            }
          }
        }
      }
      increment();
  }

  void setEmpty() {
    getCartDetailsModel = null;
    checkedCarItemList.clear();
    unCheckedCartItemList.clear();
    sellPrice.value = 0.0;
    applyCouponController.text = "";
    discountPrice.value = 0.0;
    deliveryPrice.value = 0.0;
    checkedListItemQuantity.clear();
    unCheckedListItemQuantity.clear();
    checkedListItemAvailability.clear();
    unCheckedListItemAvailability.clear();
  }

  Future<http.Response?> removeCartItemApiCalling({String? cartUuid}) async {
    if (cartUuid != null) {
      bodyParamsForRemoveCartItemApi = {ApiKeyConstant.cartUuid: cartUuid};
      http.Response? response = await CommonApis.removeCartItemApi(
          bodyParams: bodyParamsForRemoveCartItemApi);
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<http.Response?> cartItemSelectionApiCalling(
      {String? cartUuid, required String userSelection}) async {
    if (cartUuid != null) {
      bodyParamsForCartItemSelectionApi = {
        ApiKeyConstant.cartUuid: cartUuid,
        ApiKeyConstant.userSelection: userSelection
      };
      http.Response? response = await CommonApis.cartItemSelectionApi(
          bodyParams: bodyParamsForCartItemSelectionApi);
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> applyCouponApi() async {
    bodyParametersForApplyCouponApi = {
      ApiKeyConstant.couponCode: applyCouponController.text.toString().trim(),
      ApiKeyConstant.inventoryId: '0',
      ApiKeyConstant.quantity: '0',
    };
    getApplyCouponModal = await CommonApis.applyCouponApi(
        bodyParams: bodyParametersForApplyCouponApi);
    if (getApplyCouponModal != null) {
      inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
      isApplyCoupon.value = false;
      if (getApplyCouponModal?.result != null) {
        applyCouponResult = getApplyCouponModal?.result;
        if (applyCouponResult?.totalPrice != null &&
            applyCouponResult?.couponDisPrice != null) {
          discountPrice.value =
          (double.parse(int.parse(applyCouponResult!.discount!)
              .toDouble()
              .toString()));
          totalPrice.value = double.parse(
              int.parse(applyCouponResult!.totalPrice!)
                  .toDouble()
                  .toString()) -
              double.parse(int.parse(applyCouponResult!.discount!)
                  .toDouble()
                  .toString());
          sellPrice.value = double.parse(
              int.parse(applyCouponResult!.totalPrice!)
                  .toDouble()
                  .toString());
          isCouponRange.value= true;
          /*  discountPrice.value = itemQuantity.value * double.parse(
              int.parse(applyCouponResult!.discount!)
                  .toDouble()
                  .toString()) + (double.parse(productDetail.value!.sellPrice.toString()) -
              double.parse(productDetail.value!.offerPrice.toString()));*/
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
      inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
    } else {
      /*totalPrice.value = sellPrice.value;
      sellPrice.value = sellPrice.value;*/
      //discountPrice.value = discountPriceCopy;
      applyCouponController.text = '';
      isApplyCoupon.value = true;
      isCouponRange.value = false;
    }
  }

  Future<http.Response?> manageCartApiCalling(
      {int? cartQty, CartItemList? cartItem, String? inventoryId}) async {
    var userMeasurement = await MyCommonMethods.getString(key: "measurement");
    if (cartItem != null) {
      if (cartQty != null) {
        bodyParamsForManageCartApi = {
          ApiKeyConstant.cartId: cartItem.cartId,
          ApiKeyConstant.cartQty: cartQty.toString(),
          ApiKeyConstant.productId: cartItem.productId,
          ApiKeyConstant.userMeasurement: userMeasurement ?? '',
          ApiKeyConstant.inventoryId: inventoryId ?? cartItem.inventoryId,
        };
      }
      http.Response? response = await CommonApis.manageCartApi(
          bodyParams: bodyParamsForManageCartApi);
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
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
    await getCartDetailsModelApiCalling();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnAddAddressButton({required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    await Get.toNamed(Routes.ADDRESS);
    await getCartDetailsModelApiCalling();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickedOnReadyToCheckOutListParticularItem({required int index}) {}

  Future<void> clickOnFilledCheckedBox(
      {required int index, String? cartUuid}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response = await cartItemSelectionApiCalling(
        userSelection: '0', cartUuid: cartUuid);
    if (response != null) {
      unCheckedListItemQuantity.add(checkedListItemQuantity[index]);
      uncheckedListItemVariant.add(checkedListItemVariant[index]);
      checkedListItemVariant.removeAt(index);
      cartItem = checkedCarItemList[index];
      for (int i = 1; i <= checkedListItemQuantity[index]; i++) {
        if (cartItem?.isOffer != null && cartItem?.isOffer == "1") {
          if (cartItem?.sellPrice != null &&
              cartItem?.offerPrice != null) {
            sellPrice.value = sellPrice.value -
                double.parse(double.parse(cartItem!.sellPrice!)
                    .toDouble()
                    .toStringAsFixed(2));
            discountPrice.value = discountPrice.value -
                (double.parse(double.parse(cartItem!.sellPrice!)
                        .toDouble()
                        .toStringAsFixed(2)) -
                    double.parse(double.parse(cartItem!.offerPrice!)
                        .toDouble()
                        .toStringAsFixed(2)));
          }
        } else {
          if (cartItem!.sellPrice != null &&
              cartItem!.sellPrice!.isNotEmpty) {
            sellPrice.value = sellPrice.value -
                double.parse(double.parse(cartItem!.sellPrice!)
                    .toDouble()
                    .toStringAsFixed(2));
          }
        }
      }
      if (!isApplyCoupon.value) {
        clickOnApplyCouponButtonView();
      }
      unCheckedListItemAvailability.add(checkedListItemAvailability[index]);
      checkedListItemAvailability.removeAt(index);
      checkedListItemQuantity.removeAt(index);
      checkedCarItemList.removeAt(index);
      unCheckedCartItemList.add(cartItem);
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnReadyToCheckOutItemDownIcon({required int index}) async {
    MyCommonMethods.unFocsKeyBoard();
    CartItemList cart = checkedCarItemList[index];
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response;
    if (checkedListItemVariant[index] != null) {
      response = await manageCartApiCalling(
          cartQty: checkedListItemQuantity[index] - 1,
          cartItem: cart,
          inventoryId: checkedListItemVariant[index].inventoryId);
    } else {
      response = await manageCartApiCalling(
          cartQty: checkedListItemQuantity[index] - 1,
          cartItem: cart,
          inventoryId: cart.inventoryId);
    }
    if (response != null) {
      if (cart.isOffer != null && cart.isOffer == "1") {
        if (cart.sellPrice != null && cart.offerPrice != null) {
          sellPrice.value = sellPrice.value -
              double.parse(
                  double.parse(cart.sellPrice!).toDouble().toStringAsFixed(2));
          discountPrice.value = discountPrice.value -
              (double.parse(double.parse(cart.sellPrice!)
                      .toDouble()
                      .toStringAsFixed(2)) -
                  double.parse(double.parse(cart.offerPrice!)
                      .toDouble()
                      .toStringAsFixed(2)));
        }
      } else {
        if (cart.sellPrice != null && cart.sellPrice!.isNotEmpty) {
          sellPrice.value = sellPrice.value -
              double.parse(
                  double.parse(cart.sellPrice!).toDouble().toStringAsFixed(2));
        }
      }
      if (!isApplyCoupon.value) {
        clickOnApplyCouponButtonView();
      }
      checkedListItemQuantity[index]--;
    }
    isApplyCoupon.value = true;
    //onInit();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnReadyToCheckOutItemUpIcon({required int index}) async {
    MyCommonMethods.unFocsKeyBoard();
    CartItemList cart = checkedCarItemList[index];
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response;
    if (checkedListItemVariant[index] != null) {
      response = await manageCartApiCalling(
          cartQty: checkedListItemQuantity[index] + 1,
          cartItem: cart,
          inventoryId: checkedListItemVariant[index].inventoryId);
    } else {
      response = await manageCartApiCalling(
          cartQty: checkedListItemQuantity[index] + 1,
          cartItem: cart,
          inventoryId: cart.inventoryId);
    }
    if (response != null) {
      if (cart.isOffer != null && cart.isOffer == "1") {
        if (cart.sellPrice != null && cart.offerPrice != null) {
          sellPrice.value = sellPrice.value +
              double.parse(
                  double.parse(cart.sellPrice!).toDouble().toStringAsFixed(2));
          discountPrice.value = discountPrice.value +
              (double.parse(double.parse(cart.sellPrice!)
                      .toDouble()
                      .toStringAsFixed(2)) -
                  double.parse(double.parse(cart.offerPrice!)
                      .toDouble()
                      .toStringAsFixed(2)));
        }
      } else {
        if (cart.sellPrice != null && cart.sellPrice!.isNotEmpty) {
          sellPrice.value = sellPrice.value +
              double.parse(
                  double.parse(cart.sellPrice!).toDouble().toStringAsFixed(2));
        }
      }
      if (!isApplyCoupon.value) {
        clickOnApplyCouponButtonView();
      }
      checkedListItemQuantity[index]++;
    }
    isApplyCoupon.value = true;
    //onInit();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }





  /*
  Future<void> clickOnReadyToCheckOutItemUpIcon({required int index}) async {
    MyCommonMethods.unFocsKeyBoard();
    CartItemList cart = checkedCarItemList[index];
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response;
    if (checkedListItemVariant[index] != null) {
      response = await manageCartApiCalling(
          cartQty: checkedListItemQuantity[index] + 1,
          cartItem: cart,
          inventoryId: checkedListItemVariant[index].inventoryId);
    } else {
      response = await manageCartApiCalling(
          cartQty: checkedListItemQuantity[index] + 1,
          cartItem: cart,
          inventoryId: cart.inventoryId);
    }
    if (response != null) {
      if (cart.isOffer != null && cart.isOffer == "1") {
        if (cart.sellPrice != null && cart.offerPrice != null) {
          sellPrice.value = sellPrice.value +
              double.parse(
                  double.parse(cart.sellPrice!).toDouble().toStringAsFixed(2));
          discountPrice.value = discountPrice.value +
              (double.parse(double.parse(cart.sellPrice!)
                      .toDouble()
                      .toStringAsFixed(2)) -
                  double.parse(double.parse(cart.offerPrice!)
                      .toDouble()
                      .toStringAsFixed(2)));
        }
      } else {
        if (cart.sellPrice != null && cart.sellPrice!.isNotEmpty) {
          sellPrice.value = sellPrice.value +
              double.parse(
                  double.parse(cart.sellPrice!).toDouble().toStringAsFixed(2));
        }
      }
      checkedListItemQuantity[index]++;
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }
*/

  Future<void> clickOnReadyToCheckOutItemDeleteIcon(
      {required int itemIndex, String? cartUuid}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response =
        await removeCartItemApiCalling(cartUuid: cartUuid);
    if (response != null) {
      cartItem = checkedCarItemList[itemIndex];
      for (int i = 1; i <= checkedListItemQuantity[itemIndex]; i++) {
        if (cartItem?.isOffer != null && cartItem?.isOffer == "1") {
          if (cartItem?.sellPrice != null &&
              cartItem?.offerPrice != null) {
            sellPrice.value = sellPrice.value -
                double.parse(double.parse(cartItem!.sellPrice!)
                    .toDouble()
                    .toStringAsFixed(2));
            discountPrice.value = discountPrice.value -
                (double.parse(double.parse(cartItem!.sellPrice!)
                        .toDouble()
                        .toStringAsFixed(2)) -
                    double.parse(double.parse(cartItem!.offerPrice!)
                        .toDouble()
                        .toStringAsFixed(2)));
          }
        } else {
          if (cartItem!.sellPrice != null &&
              cartItem!.sellPrice!.isNotEmpty) {
            sellPrice.value = sellPrice.value -
                double.parse(double.parse(cartItem!.sellPrice!)
                    .toDouble()
                    .toStringAsFixed(2));
          }
        }
      }
      checkedListItemAvailability.removeAt(itemIndex);
      checkedListItemQuantity.removeAt(itemIndex);
      checkedCarItemList.removeAt(itemIndex);
      checkedListItemVariant.removeAt(itemIndex);
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickedOnUncheckedListParticularItem({required int index}) {}

  Future<void> clickOnUnFilledCheckBox(
      {required int index, String? cartUuid}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response = await cartItemSelectionApiCalling(
        userSelection: '1', cartUuid: cartUuid);
    if (response != null) {
      checkedListItemQuantity.add(unCheckedListItemQuantity[index]);
      checkedListItemVariant.add(uncheckedListItemVariant[index]);
      uncheckedListItemVariant.removeAt(index);

      cartItem = unCheckedCartItemList[index];
      for (int i = 1; i <= unCheckedListItemQuantity[index]; i++) {
        if (cartItem?.isOffer != null && cartItem?.isOffer == "1") {
          if (cartItem?.sellPrice != null &&
              cartItem?.offerPrice != null) {
            sellPrice.value = sellPrice.value +
                double.parse(double.parse(cartItem!.sellPrice!)
                    .toDouble()
                    .toStringAsFixed(2));
            discountPrice.value = discountPrice.value +
                (double.parse(double.parse(cartItem!.sellPrice!)
                        .toDouble()
                        .toStringAsFixed(2)) -
                    double.parse(double.parse(cartItem!.offerPrice!)
                        .toDouble()
                        .toStringAsFixed(2)));
          }
        } else {
          if (cartItem!.sellPrice != null &&
              cartItem!.sellPrice!.isNotEmpty) {
            sellPrice.value = sellPrice.value +
                double.parse(double.parse(cartItem!.sellPrice!)
                    .toDouble()
                    .toStringAsFixed(2));
          }
        }
      }
      if (!isApplyCoupon.value) {
        clickOnApplyCouponButtonView();
      }
      checkedListItemAvailability.add(unCheckedListItemAvailability[index]);
      unCheckedListItemAvailability.removeAt(index);
      unCheckedListItemQuantity.removeAt(index);
      unCheckedCartItemList.removeAt(index);
      checkedCarItemList.add(cartItem);
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnUncheckedItemSizeUnit({required int itemIndex}) {}

  Future<void> clickOnUncheckedItemDownIcon({required int index}) async {
    MyCommonMethods.unFocsKeyBoard();
    CartItemList cart = unCheckedCartItemList[index];
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response;
    if (uncheckedListItemVariant[index] != null) {
      response = await manageCartApiCalling(
          cartQty: unCheckedListItemQuantity[index] - 1,
          cartItem: cart,
          inventoryId: uncheckedListItemVariant[index].inventoryId);
    } else {
      response = await manageCartApiCalling(
          cartQty: unCheckedListItemQuantity[index] - 1,
          cartItem: cart,
          inventoryId: cart.inventoryId);
    }
    if (response != null) {
      unCheckedListItemQuantity[index]--;
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnUncheckedItemUpIcon({required int index}) async {
    MyCommonMethods.unFocsKeyBoard();
    CartItemList cart = unCheckedCartItemList[index];
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response;
    if (uncheckedListItemVariant[index] != null) {
      response = await manageCartApiCalling(
          cartQty: unCheckedListItemQuantity[index] + 1,
          cartItem: cart,
          inventoryId: uncheckedListItemVariant[index].inventoryId);
    } else {
      response = await manageCartApiCalling(
          cartQty: unCheckedListItemQuantity[index] + 1,
          cartItem: cart,
          inventoryId: cart.inventoryId);
    }
    if (response != null) {
      unCheckedListItemQuantity[index]++;
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnUncheckedItemDeleteIcon(
      {required int itemIndex, String? cartUuid}) async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    http.Response? response =
        await removeCartItemApiCalling(cartUuid: cartUuid);
    if (response != null) {
      unCheckedCartItemList.remove(unCheckedCartItemList[itemIndex]);
      unCheckedListItemAvailability.removeAt(itemIndex);
      uncheckedListItemVariant.removeAt(itemIndex);
      unCheckedListItemQuantity.removeAt(itemIndex);
    }
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void clickOnContinueShopping({required BuildContext context}) {
    if (!wantBackButton) {
      selectedIndex.value = 2;
    } else {
      selectedIndex.value = 2;
      Get.offAllNamed(Routes.NAVIGATOR_BOTTOM_BAR);
    }
  }

/* proceed payment or apply coupon working*/
  void clickOnProceedToPaymentButton({required BuildContext context}) {
    MyCommonMethods.unFocsKeyBoard();
    if (addressDetail != null) {
      showModalBottomSheet(
        isDismissible: true,
        backgroundColor: MyColorsLight().secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        context: Get.context!,
        builder: (context) => const PaymentProceed(),
      );
    } else {
      MyCommonMethods.showSnackBar(
          message: "Please Add Delivery Address", context: context);
    }
  }

  Future<void> clickOnApplyCouponButtonView() async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    await applyCouponApi();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  clickOnRemoveCouponButtonView() async {
    MyCommonMethods.unFocsKeyBoard();
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    await onInit();
    applyCouponController.text = '';
    isApplyCoupon.value = true;
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnProceedToCheckout() async {
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    isClickOnProceedToCheckOut.value = true;
    bool isSuccess = false;
    var userMeasurement = await MyCommonMethods.getString(key: "measurement");
    proceedToPaymentAbsorbing.value =
        CommonMethods.changeTheAbsorbingValueTrue();
    if (paymentMethod.value.toString() == "COD") {
      paymentType = "COD";
      bodyParametersForPlaceOrderApi = {
        ApiKeyConstant.paymentMode: paymentType,
        ApiKeyConstant.transId: '',
        ApiKeyConstant.isCart: '1',
        ApiKeyConstant.userMeasurement: userMeasurement,
      };
      isSuccess = await placeOrderApiCalling();
      Get.back();
      if (isSuccess) {
        MyCommonMethods.showSnackBar(
            message: "Your order has been placed successfully",
            context: Get.context!);
      }
      bodyParametersForPlaceOrderApi.clear();
      await getCartDetailsModelApiCalling();
    } else if (paymentMethod.value.toString() == "wallet") {
      paymentType = "Wallet";
      bodyParametersForPlaceOrderApi = {
        ApiKeyConstant.paymentMode: paymentType,
        ApiKeyConstant.transId: '',
        ApiKeyConstant.isCart: '1',
        ApiKeyConstant.userMeasurement: userMeasurement,
      };
      isSuccess = await placeOrderApiCalling();
      Get.back();
      if (isSuccess) {
        MyCommonMethods.showSnackBar(
            message: "Your order has been placed successfully",
            context: Get.context!);
      }
      bodyParametersForPlaceOrderApi.clear();
      await getCartDetailsModelApiCalling();
    } else if (paymentMethod.value.toString() == "others") {
      Get.back();
      paymentType = "Online";
      totalPrice.value =
          (sellPrice.value - discountPrice.value + deliveryPrice.value);
      await openGateway(
        type: OpenGetWayType.cart,
        priceValue: int.parse(
            double.parse(totalPrice.value.toString()).toInt().toString()),
        description: "Order From Cart",
      );
    }
    isSuccess = false;
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
    isClickOnProceedToCheckOut.value = false;
    proceedToPaymentAbsorbing.value =
        CommonMethods.changeTheAbsorbingValueFalse();
  }

  void readyToCheckOutClickOnSizeButton({required int index}) {}

  void readyToCheckOutClickOnSizeIndexButton() {}


  onRefresh() async {
    await onInit();
  }
}
