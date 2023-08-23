import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_order_list_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/my_orders/views/cancel_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/orders_filter_bottom_sheet.dart';
import 'package:zerocart/app/modules/my_orders/views/tracking_bottomsheet.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class MyOrdersController extends GetxController {

  final count = 0.obs;
  bool globalWantEmpty = false;
  bool globalWantFilter = false;
  bool globalWantSearchFilter = false;
  bool globalWantSimple=false;
  String limit = "10";
  int offset = 0;
  Timer? searchOnStoppedTyping;
  final response = false.obs;
  final isLoading = false.obs;
  final scrollController=ScrollController();
  final searchOrderController = TextEditingController();
  final totalTrackStep = 4.obs;
  final currentTrackStep = 2.obs;
  final isClicked = true.obs;
  final orderFilterType = "-1".obs;
  final isClearFiltersButtonClicked = false.obs;
  final isApplyButtonClicked = false.obs;
  List orderStatusList = [
    "Pending",
    "Shipped",
    "Picked",
    "Delivered",
    "Canceled",
  ];
  Map<String, dynamic> queryParametersForGetOrderListApi = {};
  final getOrderListModal = Rxn<GetOrderListApiModal?>();
  final orderList = [].obs;
  final orderListObject = Rxn<OrderList?>();
  DateTime? dateTime;
  DateFormat? dateFormat;

  @override
  Future<void> onInit() async {
    super.onInit();
    response.value=true;
    await getOrderListApiCalling(wantSimple: true);
    response.value=false;
    scrollController.addListener(
            () async {
          if(scrollController.position.isScrollingNotifier.value&&ScrollDirection.reverse==scrollController.position.userScrollDirection)
          {
            isLoading.value=true;
          }
          if ( scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            await getOrderListApiCalling(wantSimple: globalWantSimple,wantEmpty: false,wantFilter: globalWantFilter,wantSearchFilter: globalWantSearchFilter);
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

  void increment() => count.value++;

  Future<void> getOrderListApiCalling(
      {bool wantEmpty = false,
      bool wantFilter = false,
      bool wantSearchFilter = false,
      bool wantSimple=false}) async {

    globalWantEmpty=wantEmpty;
    globalWantFilter=wantFilter;
    globalWantSearchFilter=wantSearchFilter;
    globalWantSimple=wantSimple;

    queryParametersForGetOrderListApi.clear();
    if (wantFilter) {
      queryParametersForGetOrderListApi = {
        ApiKeyConstant.orderStatus: orderStatusList[int.parse(orderFilterType.value)].toString().replaceAll(" ", ""),
        ApiKeyConstant.limit: limit,
        ApiKeyConstant.offset:offset.toString()
      };
    }

    if (wantSearchFilter) {
      queryParametersForGetOrderListApi = {
        ApiKeyConstant.searchSrting: searchOrderController.text.trim().toString(),
        ApiKeyConstant.limit: limit,
        ApiKeyConstant.offset:offset.toString()
      };
    }

    if(wantSimple)
      {
        queryParametersForGetOrderListApi = {
          ApiKeyConstant.limit: limit,
          ApiKeyConstant.offset:offset.toString()
        };
      }

    // offset=offset+10;

    getOrderListModal.value = await CommonApis.getOrderListApi(queryParameters: queryParametersForGetOrderListApi);
    if (getOrderListModal.value != null) {
      if (getOrderListModal.value?.orderList != null) {
        if(wantEmpty)
          {
            orderList.clear();
          }
        getOrderListModal.value?.orderList?.forEach((element) {
          orderList.add(element);
        });

        if(getOrderListModal.value?.orderList != null && getOrderListModal.value!.orderList!.isNotEmpty){
          print("offset::::::   $offset");
          offset=offset+10;
        }

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
        await getOrderListApiCalling(wantSearchFilter: true,wantEmpty: true);
      });
    }
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

  void clickOnClearFilterButton() {
    isClearFiltersButtonClicked.value = true;
    orderFilterType.value = "-1";
  }

  void clickOnOrderStatus({required int index}) {
    orderFilterType.value = "$index";
    isClearFiltersButtonClicked.value = false;
  }

  Future<void> clickOnApplyButton({required BuildContext context}) async {
    response.value = CommonMethods.changeTheAbsorbingValueTrue();
    searchOrderController.text="";
    Get.back();
    offset = 0;
    if (orderFilterType.value == "-1") {
      await getOrderListApiCalling(wantSimple: true,wantEmpty: true);
    } else {
      await getOrderListApiCalling(wantFilter: true,wantEmpty: true);
    }
    response.value = CommonMethods.changeTheAbsorbingValueFalse();
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

/*clickOnTheWayButton() {
    orderFilterType.value = "OnTheWay";
  }

  clickOnDelivered() {
    orderFilterType.value = "Delivered";
  }
  clickOnCancelled() {
    orderFilterType.value = "Cancelled";
  }

  clickOnReturned() {
    orderFilterType.value = "Returned";
  }*/
}
