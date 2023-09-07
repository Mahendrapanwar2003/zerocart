import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_modals/get_categories_modal.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';
import '../../../apis/api_constant/api_constant.dart';
import 'package:http/http.dart' as http;

class CategoryController extends CommonMethods {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;
  final isLastPage = false.obs;

  String limit = "10";
  int offset = 0;
  Map<String, dynamic> queryParameters = {};

  GetCategories? getCategories;
  List<Categories> listOfCategories = [];
  Categories? categories;

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        await callingGetCategoriesApi();
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

  void increment() => count.value++;


  Future<void> clickOnCategory(
      {required int index, required BuildContext context}) async {
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    afterClickOnCategoryWorking(
      index: index,
      context: context,
      isChatOption: listOfCategories[index].isChatOption.toString(),
      categoryId: listOfCategories[index].categoryId.toString(),
      categoryName: listOfCategories[index].categoryName.toString(),
    );
  }


  void afterClickOnCategoryWorking(
      {required int index,
      required BuildContext context,
      required String isChatOption,
      required String categoryId,
      required String categoryName}) async {
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
    Get.toNamed(Routes.CATEGORIE_PRODUCT, parameters: {
      'categoryName': categoryName,
      'categoryId': categoryId,
      'isChatOption': isChatOption
    });
  }

  void clickOnBackIcon() {
    Get.back();
  }

  Future<void> callingGetCategoriesApi() async {
    queryParameters.clear();
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    queryParameters = {
      ApiKeyConstant.limit: limit.toString(),
      ApiKeyConstant.offset: offset.toString(),
    };
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetCategoryApi);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCategories = GetCategories.fromJson(jsonDecode(response.body));
        if (offset == 0) {
          listOfCategories.clear();
        }
        if (getCategories != null) {
          if (getCategories?.categories != null &&
              getCategories!.categories!.isNotEmpty) {
            isLastPage.value = false;
            getCategories?.categories?.forEach((element) {
              listOfCategories.add(element);
            });
          } else {
            isLastPage.value = true;
          }
        }
      }
    }
    increment();
  }


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

  onRefresh() async {
    offset = 0;
    await onInit();
  }

  Future<void> onLoadMore() async {
    offset = offset + 10;
    try {
      await callingGetCategoriesApi();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
    }
  }

}
