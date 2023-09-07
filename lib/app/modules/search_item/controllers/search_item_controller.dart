import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_modals/get_categories_modal.dart';
import 'package:zerocart/app/apis/api_modals/search_product_suggestion_model.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';
import '../../../apis/api_constant/api_constant.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:http/http.dart' as http;

class SearchItemController extends CommonMethods {
  final count = 0.obs;
  bool isSearch = Get.arguments;
  final searchController = TextEditingController();

  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;

  GetCategories? categoriesModal;
  List<Categories> listOfCategories = [];
  Categories? categoryObject;

  SearchProductSuggestionModel? searchProductSuggestionModel;
  List<Suggestion> suggestionList = [];
  Map<String, dynamic> bodyParamsForSearchProductSuggestionApi = {};

  Timer? searchOnStoppedTyping;

  Map<String, dynamic> queryParameters = {};
  String limit = '10';
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    try {
      await getCategories();
      await getSearchProductSuggestionListApi();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
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
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  void increment() => count.value++;

  Future<void> getCategories() async {
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
        categoriesModal = GetCategories.fromJson(jsonDecode(response.body));
        if (offset == 0) {
          listOfCategories.clear();
        }
        if (categoriesModal != null) {
          if (categoriesModal?.categories != null &&
              categoriesModal!.categories!.isNotEmpty) {
            isLastPage.value = false;
            categoriesModal?.categories?.forEach((element) {
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

  Future<void> getSearchProductSuggestionListApi({
    bool wantSearchFilter = false,
    bool wantEmpty = true,
  }) async {
    bodyParamsForSearchProductSuggestionApi.clear();
    if (wantEmpty) {
      searchProductSuggestionModel = null;
      suggestionList.clear();
    }
    if (wantSearchFilter) {
      bodyParamsForSearchProductSuggestionApi = {
        'searchString': searchController.value.text.toString().trim(),
      };
    }
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductSuggestion,
        queryParameters: bodyParamsForSearchProductSuggestionApi,
        authorization: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        searchProductSuggestionModel =
            SearchProductSuggestionModel.fromJson(jsonDecode(response.body));
        if (searchProductSuggestionModel != null) {
          if (searchProductSuggestionModel?.suggestion != null &&
              searchProductSuggestionModel!.suggestion!.isNotEmpty) {
            suggestionList = searchProductSuggestionModel?.suggestion ?? [];
          }
        }
      }
    }
    increment();
  }

  Future<void> clickOnSearchedListIem({required int index}) async {
    MyCommonMethods.unFocsKeyBoard();
    Get.toNamed(Routes.CATEGORIE_PRODUCT, parameters: {
      'searchPage': 'searchPage',
      'appBarTitleFromSearchPage': suggestionList[index].resName.toString()
    });
  }

  Future<void> clickOnSearchInTextField({required String value}) async {
    if (value.trim().isNotEmpty) {
      Get.toNamed(Routes.CATEGORIE_PRODUCT, parameters: {
        'searchPage': 'searchPage',
        'appBarTitleFromSearchPage': value
      });
    }
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
        await getSearchProductSuggestionListApi(wantSearchFilter: true);
      });
    }
  }

  void clickOnArrowIcon({required int index}) {
    searchController.text = suggestionList[index].resName ?? "";
  }

  onRefresh() async {
    await onInit();
  }
}
