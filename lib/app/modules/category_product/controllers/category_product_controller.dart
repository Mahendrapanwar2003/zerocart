import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/search_product_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/filter/controllers/filter_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import '../../../apis/api_modals/get_product_list_api_model.dart';
import '../../../common_widgets/alert_dialog.dart';

class CategoryProductController extends GetxController {
  final absorbing = false.obs;
  final scrollController = ScrollController();

  final image = Rxn<File?>();
  final count = 0.obs;
  final getProductListApiModel = Rxn<GetProductListApiModel>();
  final searchProductModel = Rxn<SearchProductModel>();
  List<ColorsList>? colorsList;
  List<Products> products = [];
  CategoryData? categoryData;
  Map<String, dynamic> queryParameters = {};
  String? categoryId;
  String? isChatOption;
  String? categoryName;

  String? searchPageValue;
  String? appBarTitleFromSearchPage;
  List filterDataList = [];
  Map<String, dynamic> filterDataMap = {};
  String? filterDataJson;
  String limit = '10';
  int offset = 0;
  final isLoading = false.obs;
  final List<String> urls = [];

  //final searchProductModel = Rxn<SearchProductModel>();
  // List<ProductList> searchProductList=[];
  Map<String, dynamic> bodyParamsForSearchProductApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    categoryName = Get.parameters['categoryName'];
    isChatOption = Get.parameters['isChatOption'];
    categoryId = Get.parameters['categoryId'];

    searchPageValue = Get.parameters['searchPage'];
    appBarTitleFromSearchPage = Get.parameters['appBarTitleFromSearchPage'];
    if(searchPageValue == 'searchPage') {
      await getSearchProductListApi(
          searchString: appBarTitleFromSearchPage.toString());
      scrollController.addListener(() async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          isLoading.value = true;
          await getSearchProductListApi(
              searchString: appBarTitleFromSearchPage.toString());
          isLoading.value = false;
        }
      });
    } else {
      await callCategoryProductApi(
          categoryId: categoryId, isChat: isChatOption);
      scrollController.addListener(() async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          isLoading.value = true;
          await callCategoryProductApi(categoryId: categoryId,
              isChat: isChatOption,
              filterData: filterDataJson,
              wantReload: false);
          isLoading.value = false;
        }
      });
    }
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
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getSearchProductListApi({String? searchString}) async {
    if (searchString != null && searchString.isNotEmpty) {
      bodyParamsForSearchProductApi = {
        'searchString': searchString,
        ApiKeyConstant.limit: limit.toString(),
        ApiKeyConstant.offset: offset.toString()
      };
      // offset=offset+10;
    }
    searchProductModel.value = await CommonApis.getSearchProductListApi(
        queryParameters: bodyParamsForSearchProductApi);
    if (searchProductModel.value != null) {
      if (searchProductModel.value?.productList != null &&
          searchProductModel.value!.productList!.isNotEmpty) {
        products.addAll(searchProductModel.value?.productList ?? []);
        if (searchProductModel.value?.productList != null &&
            searchProductModel.value!.productList!.isNotEmpty) {
          offset = offset + 10;
        }
        // searchProductModel.value?.productList?.forEach((element) {
        //   searchProductList.add(element);
        // });
      }
    }
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
    if (wantReload) {
      getProductListApiModel.value = null;
    }
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
    getProductListApiModel.value = await CommonApis.getCategoryProductApi(
        queryParameters: queryParameters);
    if (getProductListApiModel.value != null) {
      if (getProductListApiModel.value?.products != null) {
        if (getProductListApiModel.value?.categoryData != null) {
          categoryData = getProductListApiModel.value?.categoryData;
        }
        if (offset == 0) {
          products.clear();
        }
        products.addAll(getProductListApiModel.value?.products ?? []);
        if (getProductListApiModel.value?.products != null &&
            getProductListApiModel.value!.products!.isNotEmpty) {
          offset = offset + 10;
        }
        // getProductListApiModel.value?.products?.forEach((element) {
        //   products.add(element);
        // });
      }
    }
  }

/*
  Future<void> refreshIndicator() async {
    onClose();
    await Future.delayed(
      const Duration(seconds: 2),
          () {
        return callCategoryProductApi(categoryId: categoryId,isChat: isChatOption);
      },
    );
  }
*/

  Future<void> clickOnProduct(
      {required BuildContext context, required String productId}) async {
    /*  var random=Random();
    String randomValue=random.nextInt(9999).toString();*/
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: productId);
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

/* Filter Work Or Upload Prescription Api Working */
  Future<void> clickOnFilterButton({
    required BuildContext context,
    required bool isChatOption,
  }) async {
    if (!isChatOption) {
      absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
      await Get.toNamed(Routes.FILTER,
          arguments: [categoryId ?? "", filterDataMap]);
      FilterController filterController = Get.find();
      filterDataMap = filterController.filterData;
      filterDataList = filterDataMap.values.toList();
      filterDataJson = json.encode(filterDataMap);
      count.value++;
      offset = 0;
      await callCategoryProductApi(
          categoryId: categoryId, filterData: filterDataJson);
      absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    } else {
      showAlertDialog();
      /*Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatView(),
        ),
      );*/
    }
  }

  Future<void> clickOnFilterOptionListButton({required int index}) async {
    count.value++;
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

  void showAlertDialog() {
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
  }
}
