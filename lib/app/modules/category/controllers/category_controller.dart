import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_modals/get_categories_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';

class CategoryController extends CommonMethods {
  final absorbing = false.obs;
  final getCategories = Rxn<GetCategories?>();
  List<Categories>? listOfCategories;
  Categories? categories;
  @override
  Future<void> onInit() async {
    super.onInit();
    await callingGetCategoriesApi();
    onConnectivityChange();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onConnectivityChange() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (getCategories.value == null) {
          await onInit();
        }
      } else {

      }
    });
  }

  /*refreshIndicator() async {
    await Future.delayed(const Duration(seconds: 2));
    await callingGetCategoriesApi();
  }*/

  Future<void> callingGetCategoriesApi({bool wantEmpty=true}) async {
    absorbing.value=true;
    if (wantEmpty)
    {
        categories = null;
      }
    getCategories.value = await CommonApis.getCategoryApi();
    if (getCategories.value != null) {
      if (getCategories.value?.categories != null &&
          getCategories.value!.categories!.isNotEmpty) {
        listOfCategories = List.from(getCategories.value!.categories!.reversed);
      }
    }
    absorbing.value=false;
  }


  Future<void> clickOnCategory(
      {required int index, required BuildContext context}) async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    afterClickOnCategoryWorking(
      index: index,
      context: context,
      isChatOption: listOfCategories![index].isChatOption.toString(),
      categoryId: listOfCategories![index].categoryId.toString(),
      categoryName: listOfCategories![index].categoryName.toString(),
    );
  }

  void afterClickOnCategoryWorking(
      {required int index,
      required BuildContext context,
      required String isChatOption,
      required String categoryId,
      required String categoryName}) async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    Get.toNamed(Routes.CATEGORIE_PRODUCT, parameters: {
      'categoryName': categoryName,
      'categoryId': categoryId,
      'isChatOption': isChatOption
    });
  }

  void clickOnBackIcon() {
    Get.back();
  }

}
