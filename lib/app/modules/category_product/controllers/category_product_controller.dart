import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/search_product_model.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import '../../../apis/api_modals/get_product_list_api_model.dart';
import 'package:http/http.dart' as http;

class CategoryProductController extends CommonMethods {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;
  final isLastPage = false.obs;

  GetProductListApiModel? getProductListApiModel;
  SearchProductModel? searchProductModel;
  CategoryData? categoryData;
  List<ColorsList> colorsList = [];
  List<Products> products = [];
  Map<String, dynamic> queryParameters = {};
  String? categoryId;
  String? isChatOption;
  String? categoryName;
  String limit = "10";
  int offset = 0;

  String? searchPageValue;
  String? appBarTitleFromSearchPage;

  List filterDataList = [];
  Map<String, dynamic> filterDataMap = {};
  String? filterDataJson;

  final List<String> urls = [];

  Map<String, dynamic> bodyParamsForSearchProductApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    categoryName = Get.parameters['categoryName'];
    isChatOption = Get.parameters['isChatOption'];
    categoryId = Get.parameters['categoryId'];
    searchPageValue = Get.parameters['searchPage'];
    appBarTitleFromSearchPage = Get.parameters['appBarTitleFromSearchPage'];
    onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        if (searchPageValue == 'searchPage') {
          await getSearchProductListApi(
              searchString: appBarTitleFromSearchPage.toString());
        } else {
          await callCategoryProductApi(
              categoryId: categoryId, isChat: isChatOption);
        }
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
      if (searchPageValue == 'searchPage') {
        await getSearchProductListApi(
            searchString: appBarTitleFromSearchPage.toString());
      } else {
        await callCategoryProductApi(
            categoryId: categoryId, isChat: isChatOption);
      }
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
    }
  }

  Future<void> getSearchProductListApi({String? searchString}) async {
    bodyParamsForSearchProductApi.clear();
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    if (searchString != null && searchString.isNotEmpty) {
      bodyParamsForSearchProductApi = {
        ApiKeyConstant.searchString: searchString,
        ApiKeyConstant.limit: limit.toString(),
        ApiKeyConstant.offset: offset.toString()
      };
    }
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetAllProductListApi);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        searchProductModel =
            SearchProductModel.fromJson(jsonDecode(response.body));
        if (offset == 0) {
          products.clear();
        }
        if (searchProductModel != null) {
          if (searchProductModel?.productList != null &&
              searchProductModel!.productList!.isNotEmpty) {
            isLastPage.value = false;
            searchProductModel?.productList?.forEach((element) {
              products.add(element);
            });
          } else {
            isLastPage.value = true;
          }
        }
      }
    }
    increment();
  }

  void clickOnBackButton({required BuildContext context}) {
    Get.back();
  }

  onWillPop({required BuildContext context}) {
    Get.back();
  }

  Future<void> callCategoryProductApi(
      {String? categoryId,
      String? isChat,
      String? filterData,
      bool wantReload = true}) async {
    queryParameters.clear();
    isChatOption = isChat;
    this.categoryId = categoryId;
    if ((categoryId != null && categoryId.isNotEmpty) &&
        (filterData != null && filterData.isNotEmpty)) {
      queryParameters = {
        ApiKeyConstant.categoryId: categoryId,
        ApiKeyConstant.filters: filterData,
        ApiKeyConstant.limit: limit.toString(),
        ApiKeyConstant.offset: offset.toString()
      };
    } else if (categoryId != null && categoryId.isNotEmpty) {
      queryParameters = {
        ApiKeyConstant.categoryId: categoryId,
        ApiKeyConstant.limit: limit.toString(),
        ApiKeyConstant.offset: offset.toString()
      };
    }
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductListApi);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getProductListApiModel =
            GetProductListApiModel.fromJson(jsonDecode(response.body));
        if (offset == 0) {
          products.clear();
        }
        if (getProductListApiModel != null) {
          if (getProductListApiModel?.products != null &&
              getProductListApiModel!.products!.isNotEmpty) {
            isLastPage.value = false;
            getProductListApiModel?.products?.forEach((element) {
              products.add(element);
            });
          } else {
            isLastPage.value = true;
          }
        }
      }
    }
    increment();
  }

  Future<void> clickOnProduct(
      {required BuildContext context, required String productId}) async {
    /*  var random=Random();
    String randomValue=random.nextInt(9999).toString();*/
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: productId);
    inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

/* Filter Work Or Upload Prescription Api Working */
  Future<void> clickOnFilterButton({
    required BuildContext context,
    required bool isChatOption,
  }) async {
    if (!isChatOption) {
      inAsyncCall.value = CommonMethods.changeTheAbsorbingValueTrue();
      var value = await Get.toNamed(Routes.FILTER,
          arguments: [categoryId ?? "", filterDataMap]);
      if (value != null) {
        filterDataMap = value['filterData'];
      } else {
        filterDataMap = {};
      }
      filterDataList = filterDataMap.values.toList();
      filterDataJson = json.encode(filterDataMap);
      count.value++;
      offset = 0;
      await callCategoryProductApi(
          categoryId: categoryId, filterData: filterDataJson);
      inAsyncCall.value = CommonMethods.changeTheAbsorbingValueFalse();
    } else {
      //showAlertDialog();
    }
  }

  Future<void> clickOnFilterOptionListButton({required int index}) async {
    increment();
    filterDataJson = null;
    List filterKeyList = filterDataMap.keys.toList();
    filterDataMap.remove(filterKeyList[index]);
    filterKeyList.removeAt(index);
    filterDataList.removeAt(index);
    filterDataJson = json.encode(filterDataMap);
    offset = 0;
    await callCategoryProductApi(
        categoryId: categoryId,
        filterData: filterDataMap.isNotEmpty ? filterDataJson : null);
  }
}
//old code onInit
/*    try{
      searchPageValue = Get.arguments[0];
      appBarTitleFromSearchPage = Get.arguments[1];
      getSearchProductListApi(searchString: appBarTitleFromSearchPage.toString());
      scrollController.addListener(() async {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          isLoading.value=true;
          await getSearchProductListApi(searchString: appBarTitleFromSearchPage.toString());
          isLoading.value=false;
        }
      });
    }
    catch(e){
      await callCategoryProductApi(categoryId: categoryId, isChat: isChatOption);
      scrollController.addListener(() async {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          isLoading.value=true;
          await callCategoryProductApi(categoryId: categoryId, isChat: isChatOption, filterData: filterDataJson, wantReload: false);
          isLoading.value=false;
        }
      });
    }*/

//Upload The Prescription From The Options Below
// final image = Rxn<File?>();

/*  void showAlertDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: cameraTextButtonView(),
              onPressed: () => clickCameraTextButtonView(),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: galleryTextButtonView(),
              onPressed: () => clickGalleryTextButtonView(),
            ),
          ],
          title: selectImageTextView(),
          content: contentTextView(),
        );
      },
    );
  }

  Widget selectImageTextView() => Text(
        "Select Image",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 18.px),
      );

  Widget contentTextView() => Text(
        "Upload The Prescription From The Options Below",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget cameraTextButtonView() => Text(
        "Camera",
        style: Theme.of(Get.context!).textTheme.subtitle2,
      );

  Widget galleryTextButtonView() =>
      Text("Gallery", style: Theme.of(Get.context!).textTheme.subtitle2);

  Future<void> clickCameraTextButtonView() async {
    Get.back();
    await pickCamera();
  }

  Future<void> clickGalleryTextButtonView() async {
    Get.back();
    await pickGallery();
  }

  Future<void> pickCamera() async {
    image.value = await MyImagePicker.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).colorScheme.primary,
    );
    if (image.value != null) {
      showAlertDialogImage();
    }
  }

  Future<void> pickGallery() async {
    image.value = await MyImagePicker.pickImage(
        context: Get.context!,
        wantCropper: true,
        color: Theme.of(Get.context!).colorScheme.primary,
        pickImageFromGallery: true);
    if (image.value != null) {
      showAlertDialogImage();
    }
  }

  void showAlertDialogImage() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: cancelTextButtonView(),
              onPressed: () => clickCancelTextButtonView(),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: okTextButtonView(),
              onPressed: () =>
                  clickOkTextButtonView(image: File(image.value!.path)),
            )
          ],
          title: SizedBox(
              height: 60.h,
              child: Image.file(
                File(image.value!.path),
                fit: BoxFit.contain,
              )),
        );
      },
    );
  }

  Widget okTextButtonView() =>
      Text("Ok", style: Theme.of(Get.context!).textTheme.subtitle2);

  Widget cancelTextButtonView() =>
      Text("Cancel", style: Theme.of(Get.context!).textTheme.subtitle2);

  Future<void> clickOkTextButtonView({required File image}) async {
    await CommonApis.userPrescriptionApi(image: image);
    Get.back();
  }

  void clickCancelTextButtonView() {
    image.value = null;
    Get.back();
  }*/
