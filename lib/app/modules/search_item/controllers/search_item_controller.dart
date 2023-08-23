import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_modals/get_categories_modal.dart';
import 'package:zerocart/app/apis/api_modals/search_product_suggestion_model.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import '../../../apis/common_apis/common_apis.dart';

class SearchItemController extends GetxController {
  final count = 0.obs;
  bool isSearch = Get.arguments;
  final searchController = TextEditingController();
  final inAsyncCall = false.obs;

  SharedPreferences? sPrs;

  final categoriesModal = Rxn<GetCategories>();
  List<Categories> listOfCategories = [];
  final categoryObject = Rxn<Categories>();

  final searchProductSuggestionModel = Rxn<SearchProductSuggestionModel>();
  List<Suggestion> suggestionList = [];
  Map<String, dynamic> bodyParamsForSearchProductSuggestionApi = {};

  Timer? searchOnStoppedTyping;

  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value = true;
    await getCategories();
    await getSearchProductSuggestionListApi();
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

  Future<void> getCategories() async {
    categoriesModal.value = await CommonApis.getCategoryApi();
    if (categoriesModal.value != null) {
      listOfCategories = categoriesModal.value!.categories ?? [];
    }
  }

  Future<void> getSearchProductSuggestionListApi({
    bool wantSearchFilter = false,
    bool wantEmpty = true,
  }) async {
    bodyParamsForSearchProductSuggestionApi.clear();
    if (wantEmpty) {
      searchProductSuggestionModel.value = null;
      suggestionList.clear();
      suggestionList.clear();
    }
    if (wantSearchFilter) {
      bodyParamsForSearchProductSuggestionApi = {
        'searchString': searchController.value.text.toString().trim(),
      };
    }
    searchProductSuggestionModel.value =
        await CommonApis.getSearchProductListSuggestionApi(
            queryParameters: bodyParamsForSearchProductSuggestionApi);
    if (searchProductSuggestionModel.value != null) {
      if (searchProductSuggestionModel.value?.suggestion != null &&
          searchProductSuggestionModel.value!.suggestion!.isNotEmpty) {
        suggestionList = searchProductSuggestionModel.value?.suggestion ?? [];
      }
    }
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
}
