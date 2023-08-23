import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_order_list_modal.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/my_orders/views/cancel_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/orders_filter_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/tracking_bottomsheet.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class MyOrdersController extends CommonMethods {

  final count = 0.obs;
  int responseCode = 0;
  int load = 0;
  final inAsyncCall=false.obs;
  final searchOrderController = TextEditingController();

  List orderStatusList = [
    "Pending",
    "Shipped",
    "Picked",
    "Delivered",
    "Canceled",
  ];
  final orderFilterType = "-1".obs;
  final isClearFiltersButtonClicked = false.obs;
  final isApplyButtonClicked = false.obs;
  String limit = "10";
  int offset = 0;
  Map<String, dynamic> queryParametersForGetOrderListApi = {};
  GetOrderListApiModal? getOrderListModal ;
  List<OrderList> orderList = [];

  final totalTrackStep = 4.obs;
  final currentTrackStep = 2.obs;

  Timer? searchOnStoppedTyping;
  DateTime? dateTime;
  DateFormat? dateFormat;

  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value=true;
    if(await MyCommonMethods.internetConnectionCheckerMethod())
    {
      await getOrderListApiCalling();

    }
    inAsyncCall.value=false;
  }

  void increment() => count.value++;



  void onReload()
  {
    connectivity.onConnectivityChanged.listen((event) async {
      if ( await MyCommonMethods.internetConnectionCheckerMethod()) {
        if(load==0)
        {
          load=1;
          offset=0;
          await onInit();
        }
      } else {
        load=0;
      }
    });
  }

  Future<void> onRefresh() async {
    offset=0;
    await onInit();
  }

  Future<void> getOrderListApiCalling() async {
    queryParametersForGetOrderListApi.clear();
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    queryParametersForGetOrderListApi = {
      ApiKeyConstant.orderStatus: orderFilterType.value!="-1"?orderStatusList[int.parse(orderFilterType.value)].toString().replaceAll(" ", ""):"",
      ApiKeyConstant.limit: limit,
      ApiKeyConstant.offset:offset.toString(),
      ApiKeyConstant.searchSrting: searchOrderController.text.trim().toString(),
    };
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParametersForGetOrderListApi,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetOrderListApi);
    if (response != null) {
      responseCode=response.statusCode;
      if (await CommonMethods.checkResponse(response: response)) {
        getOrderListModal = GetOrderListApiModal.fromJson(jsonDecode(response.body));
      }
    }
    if (getOrderListModal!= null) {
      if (getOrderListModal?.orderList != null) {
        if(offset==0)
        {
          orderList.clear();
        }
        getOrderListModal?.orderList?.forEach((element) {
          orderList.add(element);
        });
        offset=offset+10;
      }
    }
  }

  void clickOnBackIcon({required BuildContext context}) {
    Get.back();
  }

  void clickOnFilterButton() {
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
        builder: (context) {
          return const OderFilterBottomSheet();
        });
  }

  Future<void> onChangeSearchTextField({String? value}) async {
    if (value != null) {
      const duration = Duration(milliseconds:800); // set the duration that you want call search() after that.
      if (searchOnStoppedTyping != null) {
        searchOnStoppedTyping?.cancel(); // clear timer
      }
      searchOnStoppedTyping =  Timer(duration, () async {
        offset=0;
        await getOrderListApiCalling();
      });
    }
  }

  void clickOnClearFilterButton() {
    isClearFiltersButtonClicked.value = true;
    orderFilterType.value = "-1";
  }

  void clickOnOrderStatus({required int index}) {
    orderFilterType.value = "$index";
    isClearFiltersButtonClicked.value = false;
  }

  Future<void> clickOnApplyButton({required BuildContext context}) async {
    searchOrderController.text="";
    Get.back();
    offset = 0;
    if (orderFilterType.value == "-1") {
      await getOrderListApiCalling();}

  }

  void clickOnTrackButton() {
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
        builder: (context) => const TrackingBottomSheet());
  }

  void clickOnCancelButton({required BuildContext context, required int index}) {

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
        builder: (context) {
          OrderList orderListObject=orderList[index];
          double price=0.0;
          /*for(int i=1;i<=int.parse(orderListObject.productQty??"1");i++)
          {

          }*/
          if(orderListObject.isOffer=="1")
          {
            price=price+double.parse(double.parse(orderListObject.productDisPrice!).toStringAsFixed(2));
          }
          else
          {
            price=price+double.parse(double.parse(orderListObject.productPrice!).toStringAsFixed(2));
          }
          return  MyOrdersCancelBottomSheet(index: index,price: price,);
        });
  }

  void clickOnDoNotCancelButton() {
    Get.back();
  }

  void clickOnCancelFiltersBottomSheetButton() {
    Get.back();
  }

  void clickOnCancelOrderButton({required BuildContext context,required int index}) {
    Get.offNamed(Routes.CANCEL_ORDER,arguments: {"orderList[index]":orderList[index]},);
  }

  void clickOnOrderDetails({required String productId}) {
    Get.toNamed(Routes.MY_ORDER_DETAILS,arguments:productId);
  }

}
