import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_cancel_order_reason_model.dart';
import 'package:zerocart/app/apis/api_modals/get_order_list_modal.dart';
import 'package:zerocart/app/apis/api_modals/my_order_detail_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';

class CancelOrderController extends CommonMethods {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;


  final isSubmitVisible = false.obs;
  final isClickOnSubmitButton = false.obs;
  final checkValue = ''.obs;
  double price = 0.0;
  TextEditingController commentTextField = TextEditingController();


  OrderList orderListObject = Get.arguments['orderList[index]'] ?? OrderList();
  ProductDetails productDetails = Get.arguments['productDetailsList'] ?? ProductDetails();
  String? myOrderDetailPage = Get.arguments['myOrderDetailPage'];



  /*List title = [
    'I want to change address for the order',
    'Expected delivery time is very long',
    'I have purchased the product elsewhere',
    'I have changed my mind',
    'I want to change my phone number',
    'I will not be available at home on delivery day',
    'I want to convert my order to Prepaid',
    'Price for the product has decreased',
    'I want to cancel due to product quality issue',
  ];*/


  Map<String, dynamic> bodyParamsForCancelOrderApi = {};
  String? orderItemUuid;
  GetCancelOrderReasonList? getCancelOrderReasonList;
  List<CancelReasonList> cancelReasonList=[];

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value=true;
    if (myOrderDetailPage == 'myOrderDetailPage') {
        if (productDetails.isOffer == "1") {
          price = price + double.parse(double.parse(productDetails.isOffer!).toStringAsFixed(2));
        } else {
          price = price + double.parse(double.parse(productDetails.productPrice!).toStringAsFixed(2));
        }

    }else{
      for(int i=1;i<=int.parse(orderListObject.productQty??"1");i++)
      {
        if(orderListObject.isOffer=="1")
        {
          price=price+double.parse(double.parse(orderListObject.productDisPrice!).toStringAsFixed(2));
        }
        else
        {
          price=price+double.parse(double.parse(orderListObject.productPrice!).toStringAsFixed(2));
        }
      }
    }
    await getCancelOrderReasonListApi();
    inAsyncCall.value=false;

  }

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

  Future<void> onRefresh() async {
    await onInit();
  }

  void increment() => count.value++;

  Future<void> getCancelOrderReasonListApi() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!,
        url: ApiConstUri.endPointGetCancelReasonListApi,
        token: authorization);
    // ignore: unnecessary_null_comparison
    responseCode=response?.statusCode??0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCancelOrderReasonList = GetCancelOrderReasonList.fromJson(jsonDecode(response.body));
        if (getCancelOrderReasonList != null) {
          cancelReasonList.clear();
          if (getCancelOrderReasonList?.cancelReasonList != null &&
              getCancelOrderReasonList!.cancelReasonList!.isNotEmpty) {
            cancelReasonList = getCancelOrderReasonList?.cancelReasonList ?? [];
          }
        }
      }
    }
    increment();
  }

  Future<void> cancelOrderApiCalling() async {
    bodyParamsForCancelOrderApi = {
      ApiKeyConstant.orderId:    /* myOrderDetailPage == 'myOrderDetailPage' ? productDetails.ordId.toString() :   */  orderListObject.ordId.toString(),
      ApiKeyConstant.orderItemId:/* myOrderDetailPage == 'myOrderDetailPage' ? productDetails.ordItmId.toString() :*/ orderListObject.ordItmId.toString() ,
      ApiKeyConstant.itemPrice: price.toString() ,
      ApiKeyConstant.orderItemUuid: orderItemUuid.toString() ,
      ApiKeyConstant.userComment: commentTextField.text.trim().toString() ,
      ApiKeyConstant.userReason: checkValue.toString() ,
    };
    http.Response? response = await CommonApis.cancelOrderApi(bodyParams: bodyParamsForCancelOrderApi);
    if (response != null) {
      Get.offNamed(Routes.CONFIRM_CANCEL);
    } else {
      MyCommonMethods.showSnackBar(message: 'Some Went Wrong'/*"razorpay Issue"*/, context: Get.context!);
      Get.offNamed(Routes.CONFIRM_CANCEL);
    }
  }

  void clickOnBackIcon() {
    inAsyncCall.value=true;
    Get.back();
    inAsyncCall.value=false;
  }

  void clickOnShoppingCart() {}

  Future<void> clickOnSubmitButton() async {
    isClickOnSubmitButton.value = true;
    await cancelOrderApiCalling();
    isClickOnSubmitButton.value = false;
  }

}
