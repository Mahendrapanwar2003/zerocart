import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_filter_list_modal.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/category_product/controllers/category_product_controller.dart';
import 'package:http/http.dart' as http;

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';

class FilterController extends CommonMethods {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;
  final isLastPage = false.obs;

  PageController pageController = PageController();
  GetFilterModal? getFilterModal;
  List<FilterList> filterList = [];
  Map<String, dynamic> queryParametersForFilter = {};
  GetFilterListModal? getFilterList;
  List<FilterDetailList> filterDetailList = [];
  Map<String, dynamic> queryParametersForFilterList = {};
  final isFilterUpdate = false.obs;
  String categoryId = Get.arguments[0];
  Map<String, dynamic> filterData = Get.arguments[1];
  final initialIndex = 0.obs;

/*
  String limit = "10";
  int offset = 0;*/

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        await getFilterApiCalling(categoryId: categoryId);
      } catch (e) {
        MyCommonMethods.showSnackBar(
            message: "Something went wrong", context: Get.context!);
        responseCode = 100;
      }
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

  void clickOnCloseButton({required BuildContext context}) {
    CategoryProductController categoryProductController = Get.find();
    if (filterData == categoryProductController.filterDataMap) {
      Get.back(canPop: true, result: {'filterData': filterData});
    } else {
      Get.back(canPop: true);
    }
  }

  Future<void> getFilterApiCalling({String? categoryId}) async {
    if (categoryId != null) {
      queryParametersForFilter = {ApiKeyConstant.categoryId: categoryId};
      Map<String, String> authorization = {};
      String? token =
          await MyCommonMethods.getString(key: ApiKeyConstant.token);
      authorization = {"Authorization": token!};
      http.Response? response = await MyHttp.getMethodForParams(
          context: Get.context!,
          queryParameters: queryParametersForFilter,
          authorization: authorization,
          baseUri: ApiConstUri.baseUrlForGetMethod,
          endPointUri: ApiConstUri.endPointGetFilterCategoriesApi);
      responseCode = response?.statusCode ?? 0;
      if (response != null) {
        if (await CommonMethods.checkResponse(response: response)) {
          getFilterModal = GetFilterModal.fromJson(jsonDecode(response.body));
          /*if (offset == 0) {
            products.clear();
          }*/
          if (getFilterModal != null) {
            if (getFilterModal?.filterList != null &&
                getFilterModal!.filterList!.isNotEmpty) {
              isLastPage.value = false;
              filterList = getFilterModal!.filterList!;
              await getFilterListApiCalling(
                  filterId: filterList[initialIndex.value].filterId);
            } else {
              isLastPage.value = true;
            }
          }
        }
      }
      increment();
    }

    /*
        if (categoryId != null) {
      queryParametersForFilter = {ApiKeyConstant.categoryId: categoryId};
      getFilter = await CommonApis.getCategoryProductFilterApi(
          queryParameters: queryParametersForFilter);
      if ((getFilter != null) &&
          (getFilter?.filterList != null &&
              getFilter!.filterList!.isNotEmpty)) {
        filter = getFilter!.filterList;
        await getFilterListApiCalling(
            filterId: filter![initialIndex.value].filterId);
      }
    }*/
  }

  Future<void> getFilterListApiCalling({String? filterId}) async {
    inAsyncCall.value = true;
    filterDetailList = [];
    if (filterId != null) {
      queryParametersForFilterList = {ApiKeyConstant.filterCatId: filterId};
      Map<String, String> authorization = {};
      String? token =
      await MyCommonMethods.getString(key: ApiKeyConstant.token);
      authorization = {"Authorization": token!};
      http.Response? response = await MyHttp.getMethodForParams(
          context: Get.context!,
          queryParameters: queryParametersForFilterList,
          authorization: authorization,
          baseUri: ApiConstUri.baseUrlForGetMethod,
          endPointUri: ApiConstUri.endPointGetFilterCategoriesListApi);
      responseCode = response?.statusCode ?? 0;
      if (response != null) {
        if (await CommonMethods.checkResponse(response: response)) {
          getFilterList = GetFilterListModal.fromJson(jsonDecode(response.body));
          /*if (offset == 0) {
            products.clear();
          }*/
          if (getFilterList != null) {
            if (getFilterList?.filterDetailList != null &&
                getFilterList!.filterDetailList!.isNotEmpty) {
              isLastPage.value = false;
              filterDetailList = getFilterList!.filterDetailList!;
            } else {
              isLastPage.value = true;
            }
          }
        }
      }
      increment();
    }
    /*if (filterId != null) {
      queryParametersForFilterList = {ApiKeyConstant.filterCatId: filterId};
      getFilterList = await CommonApis.getCategoryProductFilterListApi(
          queryParameters: queryParametersForFilterList);

      if ((getFilterList != null) &&
          (getFilterList?.filterDetailList != null &&
              getFilterList!.filterDetailList!.isNotEmpty)) {
        filterDetailList = getFilterList!.filterDetailList!;
      }
    }*/
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularFilterButton({required int index}) async {
    initialIndex.value = index;
    await getFilterListApiCalling(filterId: filterList[index].filterId);
    pageController.jumpToPage(index);
  }

  void clickOnFilterList({required int index}) {
    isFilterUpdate.value = !isFilterUpdate.value;
    CategoryProductController categoryProductController = Get.find();
    categoryProductController.filterDataMap = {};
    if (filterList[initialIndex.value].filterId != null &&
        filterDetailList[index].filterValue != null) {
      filterData[filterList[initialIndex.value].filterId.toString()] =
          filterDetailList[index].filterValue.toString();
    }
  }

  void clickOnApplyFilterButton({required BuildContext context}) {
    Get.back(canPop: true, result: {'filterData': filterData});
  }

  onRefresh() async {
    //offset = 0;
    await onInit();
  }
}
