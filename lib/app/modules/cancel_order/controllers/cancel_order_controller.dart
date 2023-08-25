import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_cancel_order_reason_model.dart';
import 'package:zerocart/app/apis/api_modals/get_order_list_modal.dart';
import 'package:zerocart/app/apis/api_modals/my_order_detail_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/routes/app_pages.dart';

class CancelOrderController extends GetxController {
  OrderList orderListObject = Get.arguments['orderList[index]'] ?? OrderList();

  ProductDetails productDetails = Get.arguments['productDetailsList'] ?? ProductDetails();

  String? myOrderDetailPage = Get.arguments['myOrderDetailPage'];

  final count = 0.obs;
  final absorbing = false.obs;
  final checkValue = ''.obs;
  String? orderItemUuid;
  final isSubmitVisible = false.obs;

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
  double price = 0.0;

  final getCancelOrderReasonList = Rxn<GetCancelOrderReasonList>();
  List<CancelReasonList>? cancelReasonList;

  TextEditingController commentTextField = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();

    if (myOrderDetailPage == 'myOrderDetailPage') {
      print("myOrderPage:::::::: myOrderPage     ::::::::::myOrderDetailPageValue::::::::::  $myOrderDetailPage");
        if (productDetails.isOffer == "1") {
          price = price + double.parse(double.parse(productDetails.isOffer!).toStringAsFixed(2));
        } else {
          price = price + double.parse(double.parse(productDetails.productPrice!).toStringAsFixed(2));
        }

    }else{
      print("myOrderDetailPageValue::::::::::  $myOrderDetailPage");
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

  Future<void> getCancelOrderReasonListApi() async {
    getCancelOrderReasonList.value = await CommonApis.getCancelOrderReasonListApi();
    if (getCancelOrderReasonList.value != null) {
      if (getCancelOrderReasonList.value?.cancelReasonList != null &&
          getCancelOrderReasonList.value!.cancelReasonList!.isNotEmpty) {
        cancelReasonList = getCancelOrderReasonList.value?.cancelReasonList ?? [];
        print("cancelReasonList:::::::::::::::::::::::::::::::$cancelReasonList");
      }
    }
  }

  Future<void> cancelOrderApiCalling() async {

    print("orderListObject.ordId  :::::::::::::::   ${orderListObject.ordId}");
    print("price  :::::::::::::::   $price");
    print("orderListObject.ordItmId  :::::::::::::::   ${orderListObject.ordItmId}");
    print("orderItemUuid  :::::::::::::::   $orderItemUuid");
    print("checkValue  :::::::::::::::   $checkValue");

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
    Get.back();
  }

  void clickOnShoppingCart() {}

  Future<void> clickOnSubmitButton() async {
    absorbing.value = true;
    await cancelOrderApiCalling();
    absorbing.value = false;
  }

}
