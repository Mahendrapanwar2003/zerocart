import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_order_list_modal.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/my_orders/views/cancel_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/orders_filter_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/tracking_bottomsheet.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';

class MyOrdersController extends CommonMethods {
  final count = 0.obs;
  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;
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
  GetOrderListApiModal? getOrderListModal;

  List<OrderList> orderList = [];

  final totalTrackStep = 4.obs;
  final currentTrackStep = 2.obs;

  Timer? searchOnStoppedTyping;
  DateTime? dateTime;
  DateFormat? dateFormat;

  @override
  Future<void> onInit() async {
    super.onInit();
      onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        await getOrderListApiCalling();
      } catch (e) {
        MyCommonMethods.showSnackBar(message: "Something went wrong", context: Get.context!);
        responseCode = 100;
      }
    }
    inAsyncCall.value = false;
  }

  void increment() => count.value++;

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
    await onInit();
  }

  Future<void> onLoadMore() async {
    offset = offset + 10;
    try {
      await getOrderListApiCalling();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(message: "Something went wrong", context: Get.context!);
    }
  }

  Future<void> getOrderListApiCalling() async {
    queryParametersForGetOrderListApi.clear();
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    queryParametersForGetOrderListApi = {
      ApiKeyConstant.orderStatus: orderFilterType.value != "-1"
          ? orderStatusList[int.parse(orderFilterType.value)]
              .toString()
              .replaceAll(" ", "")
          : "",
      ApiKeyConstant.limit: limit,
      ApiKeyConstant.offset: offset.toString(),
      ApiKeyConstant.searchSrting: searchOrderController.text.trim().toString(),
    };
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParametersForGetOrderListApi,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetOrderListApi);
    responseCode = response?.statusCode??0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getOrderListModal =
            GetOrderListApiModal.fromJson(jsonDecode(response.body));
        if (getOrderListModal != null) {
          if (offset == 0) {
            orderList.clear();
          }
          if (getOrderListModal?.orderList != null &&
              getOrderListModal!.orderList!.isNotEmpty) {
            isLastPage.value = false;
            getOrderListModal?.orderList?.forEach((element) {
              orderList.add(element);
            });
          } else {
            isLastPage.value = true;
          }
        }

      }
    }
    increment();
  }

  void clickOnBackIcon({required BuildContext context}) {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
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
      const duration = Duration(
          milliseconds:
              800); // set the duration that you want call search() after that.
      if (searchOnStoppedTyping != null) {
        searchOnStoppedTyping?.cancel(); // clear timer
      }
      searchOnStoppedTyping = Timer(duration, () async {
        offset = 0;
        await getOrderListApiCalling();
      });
    }
  }

  void clickOnClearFilterButton() {
    inAsyncCall.value = true;

    isClearFiltersButtonClicked.value = true;
    orderFilterType.value = "-1";
    inAsyncCall.value = false;
  }

  void clickOnOrderStatus({required int index}) {
    inAsyncCall.value = true;
    orderFilterType.value = "$index";
    isClearFiltersButtonClicked.value = false;
    inAsyncCall.value = false;
  }

  Future<void> clickOnApplyButton({required BuildContext context}) async {
    Get.back();
    offset = 0;
    await onInit();
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

  void clickOnCancelButton(
      {required BuildContext context, required int index}) {
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
          OrderList orderListObject = orderList[index];
          double price = 0.0;
          /*for(int i=1;i<=int.parse(orderListObject.productQty??"1");i++)
          {

          }*/
          if (orderListObject.isOffer == "1") {
            price = price +
                double.parse(double.parse(orderListObject.productDisPrice!)
                    .toStringAsFixed(2));
          } else {
            price = price +
                double.parse(double.parse(orderListObject.productPrice!)
                    .toStringAsFixed(2));
          }
          return MyOrdersCancelBottomSheet(
            index: index,
            price: price,
          );
        });
  }

  void clickOnDoNotCancelButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  void clickOnCancelFiltersBottomSheetButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnCancelOrderButton(
      {required BuildContext context, required int index}) async {
    inAsyncCall.value = true;
    Get.back();
    await Get.toNamed(
      Routes.CANCEL_ORDER,
      arguments: {"orderList[index]": orderList[index]},
    );
    offset=0;
    await getOrderListApiCalling();
    inAsyncCall.value = false;
  }

  Future<void> clickOnOrderDetails({required String productId}) async {
    inAsyncCall.value = true;

    await Get.toNamed(Routes.MY_ORDER_DETAILS, arguments: productId);
    offset = 0;
    await onInit();
    inAsyncCall.value = false;
  }
}
