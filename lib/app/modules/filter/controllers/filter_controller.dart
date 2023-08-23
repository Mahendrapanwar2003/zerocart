import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_filter_list_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/category/controllers/category_controller.dart';
import 'package:zerocart/app/modules/category_product/controllers/category_product_controller.dart';

class FilterController extends GetxController {
  final count = 0.obs;
  final absorbing = false.obs;
  PageController pageController = PageController();
  String categoryId= Get.arguments[0];
  final getFilter = Rxn<GetFilterModal?>();
  final filter = Rxn<List<FilterList>?>();
  Map<String, dynamic> queryParametersForFilter = {};
  final getFilterList = Rxn<GetFilterListModal?>();
  final filterDetailList = Rxn<List<FilterDetailList>?>();
  Map<String, dynamic> queryParametersForFilterList = {};
  final isFilterUpdate=false.obs;
  Map<String, dynamic> filterData = Get.arguments[1];

  final initialIndex = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
   await  getFilterApiCalling(categoryId: categoryId);
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

  void clickOnCloseButton() {
     CategoryProductController categoryProductController = Get.find();
      print("njcsndnsndks:::::::::${categoryProductController.filterDataMap==filterData}");
      print("njcsndnsndks:::::::::${categoryProductController.filterDataMap}");
      print("njcsndnsndks:::::::::${filterData}");
      if(categoryProductController.filterDataMap==filterData)
        {
          Get.back();
        }
      else
        {
          filterData = {};
          Get.back();
        }

  }

  Future<void> getFilterApiCalling({String? categoryId}) async {
    if (categoryId != null) {
      queryParametersForFilter = {ApiKeyConstant.categoryId: categoryId};
      getFilter.value = await CommonApis.getCategoryProductFilterApi(queryParameters: queryParametersForFilter);
      if ((getFilter.value != null) && (getFilter.value?.filterList != null && getFilter.value!.filterList!.isNotEmpty)) {
        filter.value = getFilter.value!.filterList;
        await getFilterListApiCalling(filterId: filter.value![initialIndex.value].filterId);
      }
    }
  }

  Future<void> getFilterListApiCalling({String? filterId}) async {
    absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    filterDetailList.value = null;
    if (filterId != null) {
      queryParametersForFilterList = {ApiKeyConstant.filterCatId: filterId};
      getFilterList.value = await CommonApis.getCategoryProductFilterListApi(queryParameters: queryParametersForFilterList);

      if ((getFilterList.value != null) && (getFilterList.value?.filterDetailList != null && getFilterList.value!.filterDetailList!.isNotEmpty)) {
        filterDetailList.value = getFilterList.value!.filterDetailList;
      }
    }
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnParticularFilterButton({required int index}) async {
    initialIndex.value = index;
    await getFilterListApiCalling(filterId: filter.value![index].filterId);
    pageController.jumpToPage(index);
  }

  void clickOnFilterList({required int index}) {
    isFilterUpdate.value=!isFilterUpdate.value;
    if (filter.value![initialIndex.value].filterId != null &&
        filterDetailList.value![index].filterValue != null) {
      filterData[filter.value![initialIndex.value].filterId.toString()] =
          filterDetailList.value![index].filterValue.toString();
    }
  }

 void clickOnApplyFilterButton({required BuildContext context}) {
   Get.back();
 }
}
