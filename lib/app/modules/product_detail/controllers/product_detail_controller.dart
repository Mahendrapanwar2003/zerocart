import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get%20_recent_product_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_product_detail_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_review_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/app/modules/outfit_room/controllers/outfit_room_controller.dart';
import 'package:zerocart/app/modules/product_detail/views/rating_alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/routes/app_pages.dart';

import '../../../apis/api_modals/get_product_list_api_model.dart';

class ProductDetailController extends CommonMethods {
  String productId = Get.arguments;
  final count = 0.obs;
  final absorbing = false.obs;
  final bannerValue = true.obs;
  final addToCartButtonStateId =
      Rxn<AddToCartButtonStateId>(AddToCartButtonStateId.idle);
  late final easyEmbeddedImageProvider =
      MultiImageProvider(bannerImagesListView);
  String randomValue = "";
  final isViewToCartVisible = false.obs;
  final isViewToOutfitRoomVisible = false.obs;
  final isClickOnAddToWishList = false.obs;
  final isClickOnAddToCart = false.obs;
  final currentIndexOfDotIndicator = 0.obs;
  final initialIndexOfInventoryArray = 0.obs;
  final initialIndexOfVariantList = 0.obs;
  final isClickOnSize = 0.obs;
  final isClickOnColor = 0.obs;
  final isColor = "".obs;
  final isVariant = "".obs;
  final isClickedColorOrSize = false.obs;
  final sellPrice = "".obs;
  final isOffer = "".obs;
  final offerPrice = "".obs;
  final percentageDis = "".obs;
  final productDescription = "".obs;

  //final reviewAvg = 0.0.obs;
  final sellerDescription = "".obs;
  String? inventoryId;
  Map<String, dynamic> queryParametersForGetProductDetail = {};
  Map<String, dynamic> bodyParamsForAddToCartApi = {};
  Map<String, dynamic> bodyParamsForAddToWishListApi = {};
  final getProductDetailsModel = Rxn<GetProductDetailModel?>();
  final productDetail = Rxn<ProductDetails?>();
  final listOfInventoryArr = Rxn<List<InventoryArr>?>();
  final inventoryArr = Rxn<InventoryArr?>();
  final listOfVariant = Rxn<List<VarientList>?>();
  final variant = Rxn<VarientList?>();
  List<String> bannerImagesList = [];
  List<ImageProvider> bannerImagesListView = [];
  CarouselController myController =
      CarouselController() as CarouselControllerImpl;
  final getReviewModal = Rxn<GetReviewModal?>();
  final bestReview = Rxn<BestReview?>();
  final reviewList = Rxn<List<ReviewList>?>();
  DateTime? dateTime;
  Map<String, dynamic> queryParametersForGetProductReview = {};
  final descriptionController = TextEditingController();
  final isSubmitButtonVisible = true.obs;
  String ratingCount = "1";
  List<XFile> xFileTypeList = [];
  List<File> selectedImageForRating = [];
  Map<String, dynamic> bodyParamsForProductFeedbackApi = {};
  final getProductListModel = Rxn<GetProductListApiModel>();
  List<ColorsList>? colorsList;
  List<Products>? products;
  CategoryData? categoryData;
  Map<String, dynamic> queryParametersForRelatedProduct = {};
  String? categoryId;
  String? isChatOption;
  Map<String, String?> bodyParams = {};
  final String tag = '';
  String? customerId;
  final getProductDetailRecentApiValue = false.obs;

  Map<String, dynamic> bodyParamsForRemoveWishlistItemApi = {};

  final getProductApiModel = Rxn<RecentProduct>();
  List<HomeProducts>? recentProductsList;

  final isViewCartValue = true.obs;
  final isAddToCartValue = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callCategoryProductDetailApi(productId: productId, randomValue: '');
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        await callCategoryProductDetailApi(
            productId: productId, randomValue: '');
      }
    });
    await Future.delayed(
      const Duration(seconds: 5),
      () => bannerValue.value = false,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void increment() => count.value++;

  ///TODO AMAN
  Future<void> getProductDetailRecentApi2() async {
    getProductDetailRecentApiValue.value = true;
    customerId =
        await MyCommonMethods.getString(key: ApiKeyConstant.customerId);
    getProductApiModel.value = await CommonApis.getProductDetailRecentApi2(
        queryParameters: {'pId': productId.toString()});
    if (getProductApiModel.value != null) {
      if (getProductApiModel.value?.products != null &&
          getProductApiModel.value!.products!.isNotEmpty) {
        recentProductsList = getProductApiModel.value?.products;
        getProductDetailRecentApiValue.value = false;
      }
    }
    getProductDetailRecentApiValue.value = false;
  }

  void valueChange() {
    isClickedColorOrSize.value = !isClickedColorOrSize.value;
    currentIndexOfDotIndicator.value = 0;
  }

  void clickOnBackButton() {
    Get.back();
  }

  onWillPop({required BuildContext context}) {
    clickOnBackButton();
  }

  void setColorOrSizeValue() {
    isClickOnColor.value = 0;
    isClickOnSize.value = 0;
  }

/*
  Future<void> refreshIndicator() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    setTheValueOfIndicatorIndex();

    callCategoryProductDetailApi(productId: productId);

  }

  void setTheValueOfIndicatorIndex() {}
*/

  Future<void> clickOnWishListIconButton(
      {required BuildContext context}) async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    isClickOnAddToWishList.value = true;
    addToWishListApiCalling(); // isClickOnAddToWishList.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

/*  Future<void> clickOnRemoveWishListIconButton({required BuildContext context}) async {

  }*/

  Future<void> clickOnRemoveWishListIconButton() async {
    /*absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    isClickOnAddToWishList.value = false;
    removeWishlistItemApiCalling();
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();*/
  }

  Future<void> removeWishlistItemApiCalling() async {
    if (productDetail.value != null &&
        productDetail.value!.uuid != null &&
        productDetail.value!.uuid!.isNotEmpty) {
      bodyParamsForRemoveWishlistItemApi = {
        ApiKeyConstant.uuid: productDetail.value!.uuid!
      };
      http.Response? response = await CommonApis.removeWishlistItemApi(
          bodyParams: bodyParamsForRemoveWishlistItemApi);
      if (response != null) {
        //wishList.remove(wishList[index]);
      }
    }
  }

  Future<void> callCategoryProductDetailApi(
      {String? productId,
      String? categoryId,
      String? isChat,
      required String randomValue}) async {
    bannerImagesList.clear();
    getProductDetailsModel.value = null;
    queryParametersForGetProductDetail = {'productId': productId};
    getProductDetailsModel.value = await CommonApis.getCategoryProductDetailApi(
        queryParameters: queryParametersForGetProductDetail);
    if (getProductDetailsModel.value != null &&
        getProductDetailsModel.value?.productDetails != null) {
      if (getProductDetailsModel.value?.productDetails?.inWishlist != null) {
        if (getProductDetailsModel.value?.productDetails?.inWishlist == 'yes') {
          isClickOnAddToWishList.value = true;
        } else {
          isClickOnAddToWishList.value = false;
        }
      }
      isColorOrVariant(
          productDetails: getProductDetailsModel.value!.productDetails!);
      productDetail.value = getProductDetailsModel.value?.productDetails;
      categoryId = productDetail.value?.categoryId;
      isAddedCartOrWishListAndInOutfitRoom();
      sellerDescription.value = productDetail.value?.sellerDescription ?? "";
      whenProductDetailIsNotNull();
    }
    await callGetProductReviewApi(productId: productId);
    await getProductDetailRecentApi2();
    // await callCategoryProductApi(categoryId: categoryId,);
    if (inventoryId != null &&
        inventoryId.toString().isNotEmpty &&
        productId != null &&
        productId.isNotEmpty) {
      bodyParams = {
        "inventoryId": inventoryId.toString(),
        "productId": productId.toString()
      };
      CommonApis.searchRecentProductApi(bodyParams: bodyParams);
    }
  }

  Future<void> addToWishListApiCalling() async {
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        (productId.isNotEmpty)) {
      bodyParamsForAddToWishListApi = {
        ApiKeyConstant.productId: productId,
        ApiKeyConstant.inventoryId: inventoryId,
      };
      http.Response? response = await CommonApis.addToWishListApi(
          bodyParams: bodyParamsForAddToWishListApi);
      if (response != null) {}
    }
  }

  Future<void> clickOnBannerImage({required BuildContext context}) async {
    Get.toNamed(Routes.SHOW_BANNER_IMAGES, arguments: bannerImagesListView);
  }

  Future<void> callGetProductReviewApi({String? productId}) async {
    queryParametersForGetProductReview = {'productId': productId};
    getReviewModal.value = await CommonApis.getProductReviewApi(
        queryParameters: queryParametersForGetProductReview);
    if (getReviewModal.value != null) {
      if (getReviewModal.value?.bestReview != null) {
        bestReview.value = getReviewModal.value?.bestReview;
        if (bestReview.value?.createdDate != null &&
            bestReview.value!.createdDate!.isNotEmpty) {
          dateTime = DateTime.parse(bestReview.value!.createdDate!);
        }
      }
      if (getReviewModal.value?.reviewList != null &&
          getReviewModal.value!.reviewList!.isNotEmpty) {
        reviewList.value = getReviewModal.value?.reviewList;
      }
    }
  }

  /*Future<void> callCategoryProductApi({String? categoryId, String? filterData}) async {
    getProductListModel.value = null;
    this.categoryId = categoryId;
    if ((categoryId != null && categoryId.isNotEmpty) &&
        (filterData != null && filterData.isNotEmpty)) {
      queryParametersForRelatedProduct = {
        ApiKeyConstant.categoryId: categoryId,
        ApiKeyConstant.filters: filterData
      };
    } else if (categoryId != null && categoryId.isNotEmpty) {
      queryParametersForRelatedProduct = {
        ApiKeyConstant.categoryId: categoryId
      };
    }
    getProductListModel.value = await CommonApis.getCategoryProductApi(
        queryParameters: queryParametersForRelatedProduct);
    if (getProductListModel.value != null) {
      if (getProductListModel.value!.products != null) {
        if (getProductListModel.value!.categoryData != null) {
          categoryData = getProductListModel.value!.categoryData;
        }
        products = getProductListModel.value!.products;
      }
    }
  }*/

  void isAddedCartOrWishListAndInOutfitRoom() {
    if ((productDetail.value?.inCart != null &&
            productDetail.value!.inCart!.isNotEmpty) &&
        (productDetail.value?.inCart?.toLowerCase() == "yes")) {
      isViewToCartVisible.value = true;
    } else {
      isViewToCartVisible.value = false;
    }

    if ((productDetail.value?.inOutfitRoom != null &&
            productDetail.value!.inOutfitRoom!.isNotEmpty) &&
        (productDetail.value?.inOutfitRoom?.toLowerCase() == "yes")) {
      isViewToOutfitRoomVisible.value = true;
    } else {
      isViewToOutfitRoomVisible.value = false;
    }
  }

  void isColorOrVariant({required ProductDetails productDetails}) {
    if (productDetails.checkProductType == TypeOfProduct.SHOW_BOTH) {
      isColor.value = "1";
      isVariant.value = "1";
    } else if (productDetails.checkProductType == TypeOfProduct.SHOW_COLOR) {
      isColor.value = "1";
      isVariant.value = "0";
    } else if (productDetails.checkProductType == TypeOfProduct.SHOW_VARIANT) {
      isColor.value = "0";
      isVariant.value = "1";
    } else if (productDetails.checkProductType == TypeOfProduct.SHOW_IMAGES) {
      isColor.value = "0";
      isVariant.value = "0";
    }
  }

  void whenProductDetailIsNotNull() {
    if (productDetail.value?.inventoryArr != null &&
        productDetail.value!.inventoryArr!.isNotEmpty) {
      if (productDetail.value?.totalRating != null &&
          productDetail.value!.totalRating!.isNotEmpty) {
        /*reviewAvg.value =
            double.parse(productDetail.value!.totalRating.toString()) /
                double.parse(productDetail.value!.totalReview.toString());*/
      }
      listOfInventoryArr.value = productDetail.value!.inventoryArr;
      inventoryArr.value =
          listOfInventoryArr.value![initialIndexOfInventoryArray.value];
      whenInventoryArrayListListIsNotNullOrNotEmpty();
    }
  }

  void whenInventoryArrayListListIsNotNullOrNotEmpty() {
    if (inventoryArr.value != null) {
      if (isVariant.value == "1" && isColor.value == "1") {
        whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorTrue();
      } else if (isVariant.value == "0" && isColor.value == "0") {
        whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorFalse();
      } else if (isVariant.value == "0" && isColor.value == "1") {
        whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorTrue();
      } else if (isVariant.value == "1" && isColor.value == "0") {
        whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorFalse();
      }
    }
  }

  void whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorTrue() {
    if (inventoryArr.value?.varientList != null &&
        inventoryArr.value!.varientList!.isNotEmpty) {
      listOfVariant.value = inventoryArr.value!.varientList;
      variant.value = listOfVariant.value?[initialIndexOfVariantList.value];
      setTheValueOfPriceOrOfferPriceOrProductDescription(
          isOffer: variant.value?.isOffer ?? "",
          offerPrice: variant.value?.offerPrice ?? "",
          sellPrice: variant.value?.sellPrice ?? "",
          percentageDis: variant.value?.percentageDis ?? "",
          productDescription: variant.value?.productDescription ?? "",
          inventoryId: variant.value?.inventoryId);
      if (variant.value?.productImage != null &&
          variant.value!.productImage!.isNotEmpty) {
        addBannerImage(productImageList: variant.value!.productImage!);
      }
    }
  }

  void whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorFalse() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    if (inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty) {
      addBannerImage(productImageList: inventoryArr.value!.productImage!);
    }
  }

  void whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorTrue() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    if (inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty) {
      addBannerImage(productImageList: inventoryArr.value!.productImage!);
    }
  }

  void whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorFalse() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    if (inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty) {
      addBannerImage(productImageList: inventoryArr.value!.productImage!);
    }
  }

  void setTheValueOfPriceOrOfferPriceOrProductDescription(
      {required String isOffer,
      required String offerPrice,
      required String sellPrice,
      required String percentageDis,
      required String productDescription,
      String? inventoryId}) {
    print("inventoryId:::::::::${inventoryId}");
    this.isOffer.value = isOffer;
    this.offerPrice.value = offerPrice;
    this.sellPrice.value = sellPrice;
    this.percentageDis.value = percentageDis;
    this.productDescription.value = productDescription;
    this.inventoryId = inventoryId;
  }

  Future<void> clickOnColorButton({required int index}) async {
    inventoryArr.value = null;
    listOfVariant.value = null;
    variant.value = null;
    isClickOnColor.value = index;
    isClickOnSize.value = 0;
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        (productId.isNotEmpty)) {
      bodyParams = {
        "inventoryId": inventoryId.toString(),
        "productId": productId.toString()
      };
    }
    if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      variant.value = listOfVariant.value![index];
      if (variant.value != null) {
        if ((inventoryId != null && inventoryId!.isNotEmpty) &&
            productId.isNotEmpty) {
          bodyParams = {
            "inventoryId": variant.value?.inventoryId.toString(),
            "productId": productId.toString()
          };
        }
      }
    }
    inventoryArr.value = listOfInventoryArr.value![index];
    listOfVariant.value = inventoryArr.value?.varientList;
    if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      variant.value = listOfVariant.value![initialIndexOfVariantList.value];
      if ((variant.value != null)) {
        if ((variant.value?.inventoryId != null &&
                variant.value!.inventoryId!.isNotEmpty) &&
            productId.isNotEmpty) {
          bodyParams = {
            "inventoryId": variant.value?.inventoryId.toString(),
            "productId": productId.toString()
          };
        }
      }
    }
    if ((listOfInventoryArr.value != null &&
        listOfInventoryArr.value!.isNotEmpty)) {
      if (isVariant.value == "1" && isColor.value == "1") {
        CommonApis.searchRecentProductApi(bodyParams: bodyParams);
        clickOnColorWhenIsVariantTrueAndIsColorTrue(index: index);
      } else {
        CommonApis.searchRecentProductApi(bodyParams: bodyParams);
        clickOnColorWhenIsVariantFalseAndIsColorTrue(index: index);
      }
    }
    valueChange();
  }

  void clickOnColorWhenIsVariantTrueAndIsColorTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
    listOfVariant.value = inventoryArr.value?.varientList;
    if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      variant.value = listOfVariant.value![initialIndexOfVariantList.value];
      if ((variant.value != null)) {
        setTheValueOfPriceOrOfferPriceOrProductDescription(
            isOffer: variant.value?.isOffer ?? "",
            offerPrice: variant.value?.offerPrice ?? "",
            sellPrice: variant.value?.sellPrice ?? "",
            percentageDis: variant.value?.percentageDis ?? "",
            productDescription: variant.value?.productDescription ?? "",
            inventoryId: variant.value?.inventoryId);
        if ((variant.value?.productImage != null &&
            variant.value!.productImage!.isNotEmpty)) {
          addBannerImage(productImageList: variant.value!.productImage!);
        }
      }
    }
  }

  void clickOnColorWhenIsVariantFalseAndIsColorTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    if ((inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty)) {
      addBannerImage(productImageList: inventoryArr.value!.productImage!);
    }
  }

  Future<void> clickOnSizeButton({required int index}) async {
    print(
        "clickOnSizeButton::::::::::::::::::::::::::${index} ${inventoryId.toString()}");
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        productId.isNotEmpty) {
      bodyParams = {
        "inventoryId": inventoryId.toString(),
        "productId": productId.toString()
      };
    }

    if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      variant.value = listOfVariant.value![index];
      if (variant.value != null) {
        if ((inventoryId != null && inventoryId!.isNotEmpty) &&
            productId.isNotEmpty) {
          bodyParams = {
            "inventoryId": variant.value?.inventoryId.toString(),
            "productId": productId.toString()
          };
        }
      }
    }

    if (isColor.value == "1" && isVariant.value == "1") {
      CommonApis.searchRecentProductApi(bodyParams: bodyParams);
      clickOnSizeWhenIsColorTrueOrIsVariantTrue(index: index);
    } else if (isColor.value == "0" && isVariant.value == "1") {
      CommonApis.searchRecentProductApi(bodyParams: bodyParams);
      clickOnSizeWhenIsColorFalseOrIsVariantTrue(index: index);
    }
    valueChange();
  }

  void clickOnSizeWhenIsColorTrueOrIsVariantTrue({required int index}) {
    variant.value = null;
    isClickOnSize.value = index;
    if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      variant.value = listOfVariant.value![index];
      if (variant.value != null) {
        setTheValueOfPriceOrOfferPriceOrProductDescription(
            isOffer: variant.value?.isOffer ?? "",
            offerPrice: variant.value?.offerPrice ?? "",
            sellPrice: variant.value?.sellPrice ?? "",
            percentageDis: variant.value?.percentageDis ?? "",
            productDescription: variant.value?.productDescription ?? "",
            inventoryId: variant.value?.inventoryId);
        if ((variant.value?.productImage != null &&
            variant.value!.productImage!.isNotEmpty)) {
          addBannerImage(productImageList: variant.value!.productImage!);
        }
      }
    }
  }

  void clickOnSizeWhenIsColorFalseOrIsVariantTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
    isClickOnSize.value = index;
    if (inventoryArr.value != null) {
      setTheValueOfPriceOrOfferPriceOrProductDescription(
          isOffer: inventoryArr.value?.isOffer ?? "",
          offerPrice: inventoryArr.value?.offerPrice ?? "",
          sellPrice: inventoryArr.value?.sellPrice ?? "",
          percentageDis: inventoryArr.value?.percentageDis ?? "",
          productDescription: inventoryArr.value?.productDescription ?? "",
          inventoryId: inventoryArr.value?.inventoryId);
      if ((inventoryArr.value?.productImage != null &&
          inventoryArr.value!.productImage!.isNotEmpty)) {
        addBannerImage(productImageList: inventoryArr.value!.productImage!);
      }
    }
  }

  void addBannerImage({required List<ProductImage> productImageList}) {
    bannerImagesList.clear();
    bannerImagesListView.clear();
    for (var element in productImageList) {
      if (element.productImage != null && element.productImage!.isNotEmpty) {
        bannerImagesList
            .add(CommonMethods.imageUrl(url: element.productImage.toString()));
        bannerImagesListView.add(NetworkImage(
            CommonMethods.imageUrl(url: element.productImage.toString())));
      }
    }

    if (bannerImagesList.isNotEmpty) {
      currentIndexOfDotIndicator.value = 0;
      if (myController.ready == true) {
        myController.jumpToPage(0);
      }
    }
  }

  void clickOnSizeChartTextButton() {
    showDialog(
      context: Get.context!,
      barrierLabel: "Size Chart",
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Image.network(
              CommonMethods.imageUrl(
                  url: productDetail.value!.brandChartImg.toString()),
              errorBuilder: (context, error, stackTrace) =>
                  CommonWidgets.defaultImage(),
            )
          ],
        );
      },
    );
  }

  Future<void> clickOnAddToCartButton({
    required BuildContext context,
  }) async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    addToCartButtonStateId.value = AddToCartButtonStateId.loading;
    isAddToCartValue.value = false;
    await addToCartApiCalling();
    isAddToCartValue.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnViewToCartButton({required BuildContext context}) async {
    isViewCartValue.value = false;
    await Get.delete<MyCartController>();
    Get.lazyPut<MyCartController>(
      () => MyCartController(),
    );
    await Get.toNamed(Routes.MY_CART, arguments: true);
    await callCategoryProductDetailApi(productId: productId, randomValue: '');
    isViewCartValue.value = true;
  }

  Future<void> addToCartApiCalling() async {
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        (productId.isNotEmpty)) {
      bodyParamsForAddToCartApi = {
        ApiKeyConstant.productId: productId,
        ApiKeyConstant.inventoryId: inventoryId,
        ApiKeyConstant.cartQty: "1",
      };
      http.Response? response =
          await CommonApis.manageCartApi(bodyParams: bodyParamsForAddToCartApi);
      if (response != null) {
        MyCommonMethods.showSnackBar(message: "Success", context: Get.context!);
        addToCartButtonStateId.value = AddToCartButtonStateId.done;
        await Future.delayed(const Duration(seconds: 1));
        isViewToCartVisible.value = true;
      }
    }
  }

  void clickOnBuyNowButton() {
    Get.toNamed(Routes.BUY_NOW, arguments: [inventoryId]);
  }

  Future<void> clickOnViewAllReviews({required BuildContext context}) async {
    Get.toNamed(Routes.ALL_REVIEWS, parameters: {"productId": productId});
  }

  void clickOnRateButton() {
    //showBottomSheet();
  }

  void showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.px),
          topRight: Radius.circular(20.px),
        ),
      ),
      context: Get.context!,
      builder: (context) {
        return const ModelBottomSheet();
      },
    );
    /* showDialog(
      context: Get.context!,
      barrierLabel: "Rating",
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const RatingAlertDialog();
      },
    );*/
  }

  Future<void> clickOnAddAttachmentIcon() async {
    xFileTypeList = await MyImagePicker.pickMultipleImages();
    selectedImageForRating =
        MyImagePicker.convertXFilesToFiles(xFiles: xFileTypeList);
    count.value++;
  }

  void clickOnRemoveReviewImage({required int index}) {
    selectedImageForRating.remove(selectedImageForRating[index]);
    count.value++;
  }

  Future<void> clickOnSubmitButton() async {
    print('huhiguihguihuiihuihuihhuihiu');
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    isSubmitButtonVisible.value = false;
    await userProductFeedbackApiCalling();
    selectedImageForRating = [];
    Get.back();
    bodyParamsForProductFeedbackApi.clear();
    descriptionController.text = "";
    isSubmitButtonVisible.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> userProductFeedbackApiCalling() async {
    print('huhiguihguihuiihuihuihhuihiu');
    bodyParamsForProductFeedbackApi = {
      ApiKeyConstant.productId: productId,
      ApiKeyConstant.rating: ratingCount,
      ApiKeyConstant.review: descriptionController.text.trim().toString(),
    };
    http.Response? response = await CommonApis.userProductFeedbackApi(
        imageList: selectedImageForRating,
        bodyParams: bodyParamsForProductFeedbackApi);
    if (response != null) {}
    print('huhiguihguihuiihuihuihhuihiu');
  }

  void clickOnSeeAllProductButton() {}

  void clickOnBottomSheet() {}

  Future<void> clickOnRelatedProduct({required String productId}) async {
    MyCommonMethods.showSnackBar(
        message: "Currently Working PRODUCT", context: Get.context!);
    var random = Random();
    String randomValue = random.nextInt(9999).toString();
    /*absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();*/
  }

  clickOnProduct({required BuildContext context, required String productId}) {}

  clickOnCustomButton() {
    Get.toNamed(Routes.MEASUREMENTS);
  }

  clickOnCustomizeButton() {
    Get.toNamed(Routes.TAILOR);
  }

  clickOnAddToOutfitButton() async {
    bodyParams = {
      ApiKeyConstant.productId: productId.toString(),
      ApiKeyConstant.inventoryId: inventoryId.toString(),
    };
    http.Response? response =
        await CommonApis.addToOutfitRoomApi(bodyParams: bodyParams);
    if (response != null) {
      MyCommonMethods.showSnackBar(
          message: 'Successfully added outfit room', context: Get.context!);
      isViewToOutfitRoomVisible.value = true;
    }
  }

  clickOnViewOutfitButton() async {
    await Get.delete<OutfitRoomController>();
    Get.lazyPut<OutfitRoomController>(
      () => OutfitRoomController(),
    );
    Get.toNamed(Routes.OUTFIT_ROOM, arguments: 0.0);
  }
}

/*
import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get%20_recent_product_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_product_detail_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_product_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_review_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/app/modules/product_detail/views/rating_alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/routes/app_pages.dart';

class ProductDetailController extends CommonMethods {


  List<String> bannerImagesList = [];

  String productId = Get.arguments;
  final count = 0.obs;
  final absorbing = false.obs;
  final bannerValue = true.obs;
  final addToCartButtonStateId =
      Rxn<AddToCartButtonStateId>(AddToCartButtonStateId.idle);
  late final easyEmbeddedImageProvider =
      MultiImageProvider(bannerImagesListView);
  String randomValue = "";
  final isViewToCartVisible = false.obs;
  final isClickOnAddToWishList = false.obs;
  final isClickOnAddToCart = false.obs;
  final currentIndexOfDotIndicator = 0.obs;
  final initialIndexOfInventoryArray = 0.obs;
  final initialIndexOfVariantList = 0.obs;
  final isClickOnSize = 0.obs;
  final isClickOnColor = 0.obs;
  final isColor = "".obs;
  final isVariant = "".obs;
  final isClickedColorOrSize = false.obs;
  final sellPrice = "".obs;
  final isOffer = "".obs;
  final offerPrice = "".obs;
  final percentageDis = "".obs;
  final productDescription = "".obs;

  //final reviewAvg = 0.0.obs;
  final sellerDescription = "".obs;
  String? inventoryId;
  Map<String, dynamic> queryParametersForGetProductDetail = {};
  Map<String, dynamic> bodyParamsForAddToCartApi = {};
  Map<String, dynamic> bodyParamsForAddToWishListApi = {};
  final getProductDetailsModel = Rxn<GetProductDetailModel?>();
  final productDetail = Rxn<ProductDetails?>();
  final listOfInventoryArr = Rxn<List<InventoryArr>?>();
  var inventoryArr = Rxn<InventoryArr?>();
*/
/*  final listOfVariant = Rxn<List<VarientList>?>();
  final variant = Rxn<VarientList?>();*/ /*

  List<ImageProvider> bannerImagesListView = [];
  CarouselController myController =
      CarouselController() as CarouselControllerImpl;
  final getReviewModal = Rxn<GetReviewModal?>();
  final bestReview = Rxn<BestReview?>();
  final reviewList = Rxn<List<ReviewList>?>();
  DateTime? dateTime;
  Map<String, dynamic> queryParametersForGetProductReview = {};
  final descriptionController = TextEditingController();
  final isSubmitButtonVisible = true.obs;
  String ratingCount = "1";
  List<XFile> xFileTypeList = [];
  List<File> selectedImageForRating = [];
  Map<String, dynamic> bodyParamsForProductFeedbackApi = {};
  final getProductListApiModel = Rxn<GetProductListApiModel>();
  List<ColorsList>? colorsList;
  List<Products>? products;
  CategoryData? categoryData;
  Map<String, dynamic> queryParametersForRelatedProduct = {};
  String? categoryId;
  String? isChatOption;
  Map<String, String?> bodyParams = {};
  final String tag = '';
  String? customerId;
  final getProductDetailRecentApiValue = false.obs;

  Map<String, dynamic> bodyParamsForRemoveWishlistItemApi = {};

  final getProductApiModel = Rxn<RecentProduct>();
  List<HomeProducts>? recentProductsList;

  final isViewCartValue = true.obs;
  final isAddToCartValue = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callCategoryProductDetailApi(productId: productId, randomValue: '');
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        await callCategoryProductDetailApi(
            productId: productId, randomValue: '');
      }
    });
    await Future.delayed(
      const Duration(seconds: 5),
      () => bannerValue.value = false,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void increment() => count.value++;

  ///TODO AMAN
  Future<void> getProductDetailRecentApi2() async {
    getProductDetailRecentApiValue.value = true;
    customerId =
        await MyCommonMethods.getString(key: ApiKeyConstant.customerId);
    getProductApiModel.value = await CommonApis.getProductDetailRecentApi2(
        queryParameters: {'pId': productId.toString()});
    if (getProductApiModel.value != null) {
      if (getProductApiModel.value?.products != null &&
          getProductApiModel.value!.products!.isNotEmpty) {
        recentProductsList = getProductApiModel.value?.products;
        getProductDetailRecentApiValue.value = false;
      }
    }
    getProductDetailRecentApiValue.value = false;
  }

  void valueChange() {
    isClickedColorOrSize.value = !isClickedColorOrSize.value;
    currentIndexOfDotIndicator.value = 0;
  }

  void clickOnBackButton() {
    Get.back();
  }

  onWillPop({required BuildContext context}) {
    clickOnBackButton();
  }

  void setColorOrSizeValue() {
    isClickOnColor.value = 0;
    isClickOnSize.value = 0;
  }

*/
/*
  Future<void> refreshIndicator() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    setTheValueOfIndicatorIndex();

    callCategoryProductDetailApi(productId: productId);

  }

  void setTheValueOfIndicatorIndex() {}
*/ /*


  Future<void> clickOnWishListIconButton(
      {required BuildContext context}) async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    isClickOnAddToWishList.value = true;
    addToWishListApiCalling(); // isClickOnAddToWishList.value = false;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

*/
/*  Future<void> clickOnRemoveWishListIconButton({required BuildContext context}) async {

  }*/ /*


  Future<void> clickOnRemoveWishListIconButton() async {
    */
/*absorbing.value=CommonMethods.changeTheAbsorbingValueTrue();
    isClickOnAddToWishList.value = false;
    removeWishlistItemApiCalling();
    absorbing.value=CommonMethods.changeTheAbsorbingValueFalse();*/ /*

  }

  Future<void> removeWishlistItemApiCalling() async {
    if (productDetail.value != null &&
        productDetail.value!.uuid != null &&
        productDetail.value!.uuid!.isNotEmpty) {
      bodyParamsForRemoveWishlistItemApi = {
        ApiKeyConstant.uuid: productDetail.value!.uuid!
      };
      http.Response? response = await CommonApis.removeWishlistItemApi(
          bodyParams: bodyParamsForRemoveWishlistItemApi);
      if (response != null) {
        //wishList.remove(wishList[index]);
      }
    }
  }

  Future<void> callCategoryProductDetailApi(
      {String? productId,
      String? categoryId,
      String? isChat,
      required String randomValue}) async {

    bannerImagesList.clear();
    getProductDetailsModel.value = null;
    queryParametersForGetProductDetail = {'productId': productId};
    getProductDetailsModel.value = await CommonApis.getCategoryProductDetailApi(
        queryParameters: queryParametersForGetProductDetail);
    if (getProductDetailsModel.value != null &&
        getProductDetailsModel.value?.productDetails != null) {
      if (getProductDetailsModel.value?.productDetails?.inWishlist != null) {
        if (getProductDetailsModel.value?.productDetails?.inWishlist == 'yes') {
          isClickOnAddToWishList.value = true;
        } else {
          isClickOnAddToWishList.value = false;
        }
      }
      isColorOrVariant(
          productDetails: getProductDetailsModel.value!.productDetails!);
      productDetail.value = getProductDetailsModel.value?.productDetails;
      categoryId = productDetail.value?.categoryId;
      listOfInventoryArr.value = productDetail.value?.inventoryArr;
      isAddedCartOrWishList();
      sellerDescription.value = productDetail.value?.sellerDescription ?? "";
      whenProductDetailIsNotNull();
    }
    await callGetProductReviewApi(productId: productId);
    await getProductDetailRecentApi2();
    // await callCategoryProductApi(categoryId: categoryId,);
    if (inventoryId != null &&
        inventoryId.toString().isNotEmpty &&
        productId != null &&
        productId.isNotEmpty) {
      bodyParams = {
        "inventoryId": inventoryId.toString(),
        "productId": productId.toString()
      };
      CommonApis.searchRecentProductApi(bodyParams: bodyParams);
    }
  }

  Future<void> addToWishListApiCalling() async {
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        (productId.isNotEmpty)) {
      bodyParamsForAddToWishListApi = {
        ApiKeyConstant.productId: productId,
        ApiKeyConstant.inventoryId: inventoryId,
      };
      http.Response? response = await CommonApis.addToWishListApi(
          bodyParams: bodyParamsForAddToWishListApi);
      if (response != null) {}
    }
  }

  Future<void> clickOnBannerImage({required BuildContext context}) async {
    Get.toNamed(Routes.SHOW_BANNER_IMAGES, arguments: bannerImagesListView);
  }

  Future<void> callGetProductReviewApi({String? productId}) async {
    queryParametersForGetProductReview = {'productId': productId};
    getReviewModal.value = await CommonApis.getProductReviewApi(
        queryParameters: queryParametersForGetProductReview);
    if (getReviewModal.value != null) {
      if (getReviewModal.value?.bestReview != null) {
        bestReview.value = getReviewModal.value?.bestReview;
        if (bestReview.value?.createdDate != null &&
            bestReview.value!.createdDate!.isNotEmpty) {
          dateTime = DateTime.parse(bestReview.value!.createdDate!);
        }
      }
      if (getReviewModal.value?.reviewList != null &&
          getReviewModal.value!.reviewList!.isNotEmpty) {
        reviewList.value = getReviewModal.value?.reviewList;
      }
    }
  }

  */
/*Future<void> callCategoryProductApi({String? categoryId, String? filterData}) async {
    getProductListApiModel.value = null;
    this.categoryId = categoryId;
    if ((categoryId != null && categoryId.isNotEmpty) &&
        (filterData != null && filterData.isNotEmpty)) {
      queryParametersForRelatedProduct = {
        ApiKeyConstant.categoryId: categoryId,
        ApiKeyConstant.filters: filterData
      };
    } else if (categoryId != null && categoryId.isNotEmpty) {
      queryParametersForRelatedProduct = {
        ApiKeyConstant.categoryId: categoryId
      };
    }
    getProductListApiModel.value = await CommonApis.getCategoryProductApi(
        queryParameters: queryParametersForRelatedProduct);
    if (getProductListApiModel.value != null) {
      if (getProductListApiModel.value!.products != null) {
        if (getProductListApiModel.value!.categoryData != null) {
          categoryData = getProductListApiModel.value!.categoryData;
        }
        products = getProductListApiModel.value!.products;
      }
    }
  }*/ /*


  void isAddedCartOrWishList() {
    if ((productDetail.value?.inCart != null &&
            productDetail.value!.inCart!.isNotEmpty) &&
        (productDetail.value?.inCart?.toLowerCase() == "yes")) {
      isViewToCartVisible.value = true;
    } else {
      isViewToCartVisible.value = false;
    }
  }

  void isColorOrVariant({required ProductDetails productDetails}) {
    if (productDetails.checkProductType == TypeOfProduct.SHOW_BOTH) {
      isColor.value = "1";
      isVariant.value = "1";
    } else if (productDetails.checkProductType == TypeOfProduct.SHOW_COLOR) {
      isColor.value = "1";
      isVariant.value = "0";
    } else if (productDetails.checkProductType == TypeOfProduct.SHOW_VARIANT) {
      isColor.value = "0";
      isVariant.value = "1";
    } else if (productDetails.checkProductType == TypeOfProduct.SHOW_IMAGES) {
      isColor.value = "0";
      isVariant.value = "0";
    }
  }

  void whenProductDetailIsNotNull() {
    if (productDetail.value?.inventoryArr != null &&
        productDetail.value!.inventoryArr!.isNotEmpty) {
      if (productDetail.value?.totalRating != null &&
          productDetail.value!.totalRating!.isNotEmpty) {
        */
/*reviewAvg.value =
            double.parse(productDetail.value!.totalRating.toString()) /
                double.parse(productDetail.value!.totalReview.toString());*/ /*

      }
      listOfInventoryArr.value = productDetail.value!.inventoryArr;
      inventoryArr.value =
          listOfInventoryArr.value![initialIndexOfInventoryArray.value];
      whenInventoryArrayListListIsNotNullOrNotEmpty();
    }
  }

  void whenInventoryArrayListListIsNotNullOrNotEmpty() {
    if (inventoryArr.value != null) {
      if (isVariant.value == "1" && isColor.value == "1") {
        //whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorTrue();
      } else if (isVariant.value == "0" && isColor.value == "0") {
        whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorFalse();
      } else if (isVariant.value == "0" && isColor.value == "1") {
        whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorTrue();
      } else if (isVariant.value == "1" && isColor.value == "0") {
        whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorFalse();
      }
    }
  }

*/
/*  void whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorTrue() {
    if (inventoryArr.value?.varientList != null &&
        inventoryArr.value!.varientList!.isNotEmpty) {
      listOfVariant.value = inventoryArr.value!.varientList;
      variant.value = listOfVariant.value?[initialIndexOfVariantList.value];
      setTheValueOfPriceOrOfferPriceOrProductDescription(
          isOffer: variant.value?.isOffer ?? "",
          offerPrice: variant.value?.offerPrice ?? "",
          sellPrice: variant.value?.sellPrice ?? "",
          percentageDis: variant.value?.percentageDis ?? "",
          productDescription: variant.value?.productDescription ?? "",
          inventoryId: variant.value?.inventoryId);
      if (variant.value?.productImage != null &&
          variant.value!.productImage!.isNotEmpty) {
        addBannerImage(productImageList: variant.value!.productImage!);
      }
    }
  }*/ /*


  void whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorFalse() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    */
/*if (inventoryArr.value?.productImageList != null &&
        inventoryArr.value!.productImageList!.isNotEmpty) {
      addBannerImage(productImageList: inventoryArr.value!.productImageList!);
    }*/ /*

  }

  void whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorTrue() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    */
/*if (inventoryArr.value?.productImageList != null &&
        inventoryArr.value!.productImageList!.isNotEmpty) {
      addBannerImage(productImageList: inventoryArr.value!.productImageList!);
    }*/ /*

  }

  void whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorFalse() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    */
/*if (inventoryArr.value?.productImageList != null &&
        inventoryArr.value!.productImageList!.isNotEmpty) {
      addBannerImage(productImageList: inventoryArr.value!.productImageList!);
    }*/ /*

  }

  void setTheValueOfPriceOrOfferPriceOrProductDescription(
      { String isOffer = '',
       String offerPrice = '',
       String sellPrice = '',
       String percentageDis = '',
       String productDescription ='',
      String? inventoryId}) {
    print("inventoryId:::::::::${inventoryId}");
    this.isOffer.value = isOffer;
    this.offerPrice.value = offerPrice;
    this.sellPrice.value = sellPrice;
    this.percentageDis.value = percentageDis;
    this.productDescription.value = productDescription;
    this.inventoryId = inventoryId;
  }

  Future<void> clickOnColorButton({required int index}) async {
    inventoryArr.value = null;
    isClickOnColor.value = index;
    isClickOnSize.value = 0;
    inventoryId = listOfInventoryArr.value![index].inventoryId;
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        (productId.isNotEmpty)) {
      bodyParams = {
        "inventoryId": inventoryId.toString(),
        "productId": productId.toString()
      };
    }
    inventoryArr.value = listOfInventoryArr.value![index];
    if ((listOfInventoryArr.value != null &&
        listOfInventoryArr.value!.isNotEmpty)) {
      if (isVariant.value == "1" && isColor.value == "1") {
        CommonApis.searchRecentProductApi(bodyParams: bodyParams);
        clickOnColorWhenIsVariantTrueAndIsColorTrue(index: index);
      } else {
        CommonApis.searchRecentProductApi(bodyParams: bodyParams);
        clickOnColorWhenIsVariantFalseAndIsColorTrue(index: index);
      }
    }
    valueChange();
  }

  void clickOnColorWhenIsVariantTrueAndIsColorTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
   */
/* listOfVariant.value = inventoryArr.value?.varientList;
    if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      variant.value = listOfVariant.value![initialIndexOfVariantList.value];
      if ((variant.value != null)) {
        print('variant.value?.offerPrice::::::::${variant.value?.offerPrice}');
        setTheValueOfPriceOrOfferPriceOrProductDescription(
            isOffer: variant.value?.isOffer ?? "",
            offerPrice: variant.value?.offerPrice ?? "",
            sellPrice: variant.value?.sellPrice ?? "",
            percentageDis: variant.value?.percentageDis ?? "",
            productDescription: variant.value?.productDescription ?? "",
            inventoryId: variant.value?.inventoryId);
        if ((variant.value?.productImage != null &&
            variant.value!.productImage!.isNotEmpty)) {
          addBannerImage(productImageList: variant.value!.productImage!);
        }
      }
    }*/ /*

  }

  void clickOnColorWhenIsVariantFalseAndIsColorTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOffer: inventoryArr.value?.isOffer ?? "",
        offerPrice: inventoryArr.value?.offerPrice ?? "",
        sellPrice: inventoryArr.value?.sellPrice ?? "",
        percentageDis: inventoryArr.value?.percentageDis ?? "",
        productDescription: inventoryArr.value?.productDescription ?? "",
        inventoryId: inventoryArr.value?.inventoryId);
    */
/*if ((inventoryArr.value?.productImageList != null &&
        inventoryArr.value!.productImageList!.isNotEmpty)) {
      addBannerImage(productImageList: inventoryArr.value!.productImageList!);
    }*/ /*

  }

  Future<void> clickOnSizeButton(
      {required int index,
      required int index2,
      required List<dynamic> sizes}) async {
   */
/* print("clickOnSizeButton::::$index::::${sizes[index]['variantAbbreviation']}::::::::::::::::::${index} ${inventoryId.toString()}");
    print("clickOnSizeButton::::$index2::::${sizes[index]['sellPrice']}::::::::::::::::::${index} ${inventoryId.toString()}");
    print("clickOnSizeButton::::::::${sizes[index]['isOffer']}::::::::::::::::::${index} ${inventoryId.toString()}");
    print("clickOnSizeButton::::::::${sizes[index]['offerPrice']}::::::::::::::::::${index} ${inventoryId.toString()}");
*/ /*
      sellPrice.value =
      sizes[index]['sellPrice'];
      isOffer.value = sizes[index]['isOffer'];
      offerPrice.value =
      sizes[index]['offerPrice'];
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        productId.isNotEmpty) {
      bodyParams = {
        "inventoryId": inventoryId.toString(),
        "productId": productId.toString()
      };
    }
  */
/*  if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      print("listOfVariant.value:::${listOfVariant.value?.length}");
      variant.value = listOfVariant.value![index2];
      if (variant.value != null) {
        if ((inventoryId != null && inventoryId!.isNotEmpty) &&
            productId.isNotEmpty) {
          bodyParams = {
            "inventoryId": variant.value?.inventoryId.toString(),
            "productId": productId.toString()
          };
        }
      }
    }*/ /*


    if (isColor.value == "1" && isVariant.value == "1") {
      CommonApis.searchRecentProductApi(bodyParams: bodyParams);
      clickOnSizeWhenIsColorTrueOrIsVariantTrue(index: index,index2:index2);
    } else if (isColor.value == "0" && isVariant.value == "1") {
      CommonApis.searchRecentProductApi(bodyParams: bodyParams);
      clickOnSizeWhenIsColorFalseOrIsVariantTrue(index: index);
    }
    valueChange();
  }

  void clickOnSizeWhenIsColorTrueOrIsVariantTrue({required int index,required int index2}) {
    //variant.value = null;
    isClickOnSize.value = index;
    */
/*if (listOfVariant.value != null && listOfVariant.value!.isNotEmpty) {
      variant.value = listOfVariant.value![index2];
      if (variant.value != null) {
        setTheValueOfPriceOrOfferPriceOrProductDescription(
            isOffer: variant.value?.isOffer ?? "",
            offerPrice: variant.value?.offerPrice ?? "",
            sellPrice: variant.value?.sellPrice ?? "",
            percentageDis: variant.value?.percentageDis ?? "",
            productDescription: variant.value?.productDescription ?? "",
            inventoryId: variant.value?.inventoryId);
        if ((variant.value?.productImage != null &&
            variant.value!.productImage!.isNotEmpty)) {
          addBannerImage(productImageList: variant.value!.productImage!);
        }
      }
    }*/ /*

  }

  void clickOnSizeWhenIsColorFalseOrIsVariantTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
    isClickOnSize.value = index;
    if (inventoryArr.value != null) {
      setTheValueOfPriceOrOfferPriceOrProductDescription(
          isOffer: inventoryArr.value?.isOffer ?? "",
          offerPrice: inventoryArr.value?.offerPrice ?? "",
          sellPrice: inventoryArr.value?.sellPrice ?? "",
          percentageDis: inventoryArr.value?.percentageDis ?? "",
          productDescription: inventoryArr.value?.productDescription ?? "",
          inventoryId: inventoryArr.value?.inventoryId);
      */
/*if ((inventoryArr.value?.productImageList != null &&
          inventoryArr.value!.productImageList!.isNotEmpty)) {
        addBannerImage(productImageList: inventoryArr.value!.productImageList!);
      }*/ /*

    }
  }

  void addBannerImage({required List<ProductImage> productImageList}) {
    bannerImagesList.clear();
    bannerImagesListView.clear();
    for (var element in productImageList) {
      if (element.productImage != null && element.productImage!.isNotEmpty) {
        bannerImagesList
            .add(CommonMethods.imageUrl(url: element.productImage.toString()));
        bannerImagesListView.add(NetworkImage(
            CommonMethods.imageUrl(url: element.productImage.toString())));
      }
    }

    if (bannerImagesList.isNotEmpty) {
      currentIndexOfDotIndicator.value = 0;
      if (myController.ready == true) {
        myController.jumpToPage(0);
      }
    }
  }

  void clickOnSizeChartTextButton() {
    showDialog(
      context: Get.context!,
      barrierLabel: "Size Chart",
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Image.network(
              CommonMethods.imageUrl(
                  url: productDetail.value!.brandChartImg.toString()),
              errorBuilder: (context, error, stackTrace) =>
                  CommonWidgets.defaultImage(),
            )
          ],
        );
      },
    );
  }

  Future<void> clickOnAddToCartButton({
    required BuildContext context,
  }) async {
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    addToCartButtonStateId.value = AddToCartButtonStateId.loading;
    isAddToCartValue.value = false;
    await addToCartApiCalling();
    isAddToCartValue.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> clickOnViewToCartButton({required BuildContext context}) async {
    isViewCartValue.value = false;
    await Get.delete<MyCartController>();
    Get.lazyPut<MyCartController>(
      () => MyCartController(),
    );
    await Get.toNamed(Routes.MY_CART, arguments: true);
    await callCategoryProductDetailApi(productId: productId, randomValue: '');
    isViewCartValue.value = true;
  }

  Future<void> addToCartApiCalling() async {
    if ((inventoryId != null && inventoryId!.isNotEmpty) &&
        (productId.isNotEmpty)) {
      bodyParamsForAddToCartApi = {
        ApiKeyConstant.productId: productId,
        ApiKeyConstant.inventoryId: inventoryId,
        ApiKeyConstant.cartQty: "1",
      };
      http.Response? response =
          await CommonApis.manageCartApi(bodyParams: bodyParamsForAddToCartApi);
      if (response != null) {
        MyCommonMethods.showSnackBar(message: "Success", context: Get.context!);
        addToCartButtonStateId.value = AddToCartButtonStateId.done;
        await Future.delayed(const Duration(seconds: 1));
        isViewToCartVisible.value = true;
      }
    }
  }

  void clickOnBuyNowButton() {
    Get.toNamed(Routes.BUY_NOW, arguments: [inventoryId]);
  }

  Future<void> clickOnViewAllReviews({required BuildContext context}) async {
    Get.toNamed(Routes.ALL_REVIEWS, parameters: {"productId": productId});
  }

  void clickOnRateButton() {
    //showBottomSheet();
  }

  void showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.px),
          topRight: Radius.circular(20.px),
        ),
      ),
      context: Get.context!,
      builder: (context) {
        return const ModelBottomSheet();
      },
    );
    */
/* showDialog(
      context: Get.context!,
      barrierLabel: "Rating",
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const RatingAlertDialog();
      },
    );*/ /*

  }

  Future<void> clickOnAddAttachmentIcon() async {
    xFileTypeList = await MyImagePicker.pickMultipleImages();
    selectedImageForRating =
        MyImagePicker.convertXFilesToFiles(xFiles: xFileTypeList);
    count.value++;
  }

  void clickOnRemoveReviewImage({required int index}) {
    selectedImageForRating.remove(selectedImageForRating[index]);
    count.value++;
  }

  Future<void> clickOnSubmitButton() async {
    print('huhiguihguihuiihuihuihhuihiu');
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    isSubmitButtonVisible.value = false;
    await userProductFeedbackApiCalling();
    selectedImageForRating = [];
    Get.back();
    bodyParamsForProductFeedbackApi.clear();
    descriptionController.text = "";
    isSubmitButtonVisible.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> userProductFeedbackApiCalling() async {
    print('huhiguihguihuiihuihuihhuihiu');
    bodyParamsForProductFeedbackApi = {
      ApiKeyConstant.productId: productId,
      ApiKeyConstant.rating: ratingCount,
      ApiKeyConstant.review: descriptionController.text.trim().toString(),
    };
    http.Response? response = await CommonApis.userProductFeedbackApi(
        imageList: selectedImageForRating,
        bodyParams: bodyParamsForProductFeedbackApi);
    if (response != null) {}
    print('huhiguihguihuiihuihuihhuihiu');
  }

  void clickOnSeeAllProductButton() {}

  void clickOnBottomSheet() {}

  Future<void> clickOnRelatedProduct({required String productId}) async {
    MyCommonMethods.showSnackBar(
        message: "Currently Working PRODUCT", context: Get.context!);
    var random = Random();
    String randomValue = random.nextInt(9999).toString();
    */
/*absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();*/ /*

  }

  clickOnProduct({required BuildContext context, required String productId}) {}

  clickOnCustomButton() {
    Get.toNamed(Routes.MEASUREMENTS);
  }

  clickOnCustomizeButton() {
    Get.toNamed(Routes.TAILOR);
  }

  clickOnAddToOutfitButton() async {
    bodyParams = {
      ApiKeyConstant.productId: productId.toString(),
      ApiKeyConstant.inventoryId: inventoryId.toString(),
    };
    http.Response? response =
        await CommonApis.addToOutfitRoomApi(bodyParams: bodyParams);
    if (response != null) {
      MyCommonMethods.showSnackBar(message: 'Success', context: Get.context!);
    }
  }
}
*/
