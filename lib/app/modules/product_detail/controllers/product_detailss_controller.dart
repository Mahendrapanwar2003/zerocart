/*
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get%20_recent_product_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_product_detail_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_review_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/app/routes/app_pages.dart';

class ProductDetailController extends CommonMethods {
  String productId = Get.arguments;

  final absorbing = false.obs;
  final current = 0.obs;
  final isViewToCartVisible = false.obs;
  final isViewCartValue = true.obs;
  final isAddToCartValue = true.obs;
  final bannerValue = true.obs;

  final initialIndexOfInventoryArray = 0.obs;
  final initialIndexOfVariantList = 0.obs;

  final isClickOnSize = 0.obs;
  final isClickOnColor = 0.obs;

  final isColor = "".obs;
  final isVariant = "".obs;
  final isOffer = "".obs;
  final sellPrice = "".obs;
  final offerPrice = "".obs;
  final percentageDis = "".obs;
  final productDescription = "".obs;
  final inventoryId = "".obs;
  final customerId = "".obs;

  final sellerDescription = "".obs;
  final productName = "".obs;
  final inStock = "".obs;
  final brandName = "".obs;
  final totalRating = "".obs;
  final totalReview = "".obs;

  DateTime? dateTime;


  final getProductDetailRecentApiValue = false.obs;
  final getProductApiModel = Rxn<RecentProduct>();
  List<HomeProducts>? recentProductsList;

  Map<String, dynamic> queryParametersForGetProductReview = {};

  final getReviewModal = Rxn<GetReviewModal?>();

  Map<String, dynamic> bodyParamsForAddToOutfit = {};

  Map<String, dynamic> bodyParamsForAddToCartApi = {};

  Map<String, dynamic> queryParametersForGetProductDetail = {};

  Map<String, dynamic> bodyParams = {};

  final getProductDetailsModel = Rxn<GetProductDetailModel?>();
  final productDetail = Rxn<ProductDetails?>();
  final listOfInventoryArr = Rxn<List<InventoryArr>?>();
  final inventoryArr = Rxn<InventoryArr>();

  final reviewList = Rxn<List<ReviewList>?>();
  final bestReview = Rxn<BestReview?>();

  final productImage = Rxn<List<ProductImage>?>();
  List<dynamic> productImageList = [];
  List<ImageProvider> productImagesListView = [];
  final currentIndexOfDotIndicator = 0.obs;
  late final easyEmbeddedImageProvider =
      MultiImageProvider(productImagesListView);
  CarouselController myController =
      CarouselController() as CarouselControllerImpl;

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

  void clickOnBackButton() {
    Get.back();
  }

  onWillPop({required BuildContext context}) {
    clickOnBackButton();
  }

  Future<void> clickOnColorButton({required int index}) async {
    inventoryArr.value = null;
    isClickOnColor.value = index;
    isClickOnSize.value = 0;
    inventoryId.value = listOfInventoryArr.value![index].inventoryId ?? '';
    if ((inventoryId.value.isNotEmpty) && (productId.isNotEmpty)) {
      bodyParams = {
        "inventoryId": inventoryId.value.toString(),
        "productId": productId.toString()
      };
    }
    inventoryArr.value = listOfInventoryArr.value![index];
    print('inventoryArr.value::::1${inventoryArr.value?.inventoryId}');
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

  void valueChange() {
    currentIndexOfDotIndicator.value = 0;
  }

  void clickOnColorWhenIsVariantTrueAndIsColorTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
    productImage.value = inventoryArr.value?.productImage;
    if (productImage.value != null && productImage.value!.isNotEmpty) {
      print('inventoryArr.value::::${inventoryArr.value?.offerPrice}');
      if ((inventoryArr.value != null)) {
        setTheValueOfPriceOrOfferPriceOrProductDescription(
            isOfferString: inventoryArr.value?.isOffer ?? "",
            offerPriceString: inventoryArr.value?.offerPrice ?? "",
            sellPriceString: inventoryArr.value?.sellPrice ?? "",
            percentageDisString: inventoryArr.value?.percentageDis ?? "",
            productDescriptionString: inventoryArr.value?.productDescription ?? "",
            inventoryIdString: inventoryArr.value?.inventoryId.toString() ?? "");
        if ((inventoryArr.value?.productImage != null &&
            inventoryArr.value!.productImage!.isNotEmpty)) {
          addBannerImage(productImagesList: inventoryArr.value!.productImage!);
        }
      }
    }
  }

  void clickOnColorWhenIsVariantFalseAndIsColorTrue({required int index}) {
    inventoryArr.value = listOfInventoryArr.value![index];
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOfferString: inventoryArr.value?.isOffer ?? "",
        offerPriceString: inventoryArr.value?.offerPrice ?? "",
        sellPriceString: inventoryArr.value?.sellPrice ?? "",
        percentageDisString: inventoryArr.value?.percentageDis ?? "",
        productDescriptionString: inventoryArr.value?.productDescription ?? "",
        inventoryIdString: inventoryArr.value?.inventoryId ?? "");
    if ((inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty)) {
      addBannerImage(productImagesList: inventoryArr.value!.productImage!);
    }
  }

  clickOnSizeButton({required index, required index2, required List sizes}) {}

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
    isAddToCartValue.value = false;
    await addToCartApiCalling();
    isAddToCartValue.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  Future<void> addToCartApiCalling() async {
    if ((inventoryId.value.isNotEmpty) && (productId.isNotEmpty)) {
      bodyParamsForAddToCartApi = {
        ApiKeyConstant.productId: productId,
        ApiKeyConstant.inventoryId: inventoryId.value,
        ApiKeyConstant.cartQty: "1",
      };
      http.Response? response =
          await CommonApis.manageCartApi(bodyParams: bodyParamsForAddToCartApi);
      if (response != null) {
        MyCommonMethods.showSnackBar(message: "Success", context: Get.context!);
        await Future.delayed(const Duration(seconds: 1));
        isViewToCartVisible.value = true;
      }
    }
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

  clickOnCustomButton() {
    Get.toNamed(Routes.MEASUREMENTS);
  }

  clickOnCustomizeButton() {
    Get.toNamed(Routes.TAILOR);
  }

  clickOnAddToOutfitButton() async {
    bodyParamsForAddToOutfit = {
      ApiKeyConstant.productId: productId.toString(),
      ApiKeyConstant.inventoryId: inventoryId.value.toString(),
    };
    http.Response? response = await CommonApis.addToOutfitRoomApi(
        bodyParams: bodyParamsForAddToOutfit);
    if (response != null) {
      MyCommonMethods.showSnackBar(message: 'Success', context: Get.context!);
    }
  }

  void clickOnBuyNowButton() {
    Get.toNamed(Routes.BUY_NOW, arguments: [inventoryId.value]);
  }

  Future<void> clickOnViewAllReviews({required BuildContext context}) async {
    Get.toNamed(Routes.ALL_REVIEWS, parameters: {"productId": productId});
  }

  clickOnProductImage({required BuildContext context}) {
    Get.toNamed(Routes.SHOW_BANNER_IMAGES, arguments: productImagesListView);
  }

  Future<void> callCategoryProductDetailApi(
      {String? productId,
      String? categoryId,
      String? isChat,
      required String randomValue}) async {
    productImageList.clear();
    getProductDetailsModel.value = null;
    queryParametersForGetProductDetail = {'productId': productId};
    getProductDetailsModel.value = await CommonApis.getCategoryProductDetailApi(
        queryParameters: queryParametersForGetProductDetail);
    if (getProductDetailsModel.value != null &&
        getProductDetailsModel.value?.productDetails != null) {
      isColorOrVariant(
          productDetails: getProductDetailsModel.value!.productDetails!);
      productDetail.value = getProductDetailsModel.value?.productDetails;
      listOfInventoryArr.value = productDetail.value?.inventoryArr;
      totalReview.value = productDetail.value?.totalReview ?? "";
      totalReview.value = productDetail.value?.totalReview ?? "";
      brandName.value = productDetail.value?.brandName ?? "";
      inStock.value = productDetail.value?.inStock ?? "";
      productName.value = productDetail.value?.productName ?? "";
      sellerDescription.value = productDetail.value?.sellerDescription ?? "";
      isAddedCartOrWishList();
      whenProductDetailIsNotNull();
    }
    await callGetProductReviewApi(productId: productId);
    await getProductDetailRecentApi2();
    if (inventoryId.value.isNotEmpty &&
        productId != null &&
        productId.isNotEmpty) {
      bodyParams = {
        "inventoryId": inventoryId.value.toString(),
        "productId": productId.toString()
      };
      CommonApis.searchRecentProductApi(bodyParams: bodyParams);
    }
  }

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
          productDetail.value!.totalRating!.isNotEmpty) {}
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
    if (inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty) {
      productImage.value = inventoryArr.value!.productImage;
      setTheValueOfPriceOrOfferPriceOrProductDescription(
          isOfferString: inventoryArr.value?.isOffer ?? "",
          offerPriceString: inventoryArr.value?.offerPrice ?? "",
          sellPriceString: inventoryArr.value?.sellPrice ?? "",
          percentageDisString: inventoryArr.value?.percentageDis ?? "",
          productDescriptionString: inventoryArr.value?.productDescription ?? "",
          inventoryIdString: inventoryArr.value?.inventoryId ?? "");
      if (inventoryArr.value?.productImage != null &&
          inventoryArr.value!.productImage!.isNotEmpty) {
        addBannerImage(productImagesList: inventoryArr.value!.productImage!);
      }
    }
  }

  void whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorFalse() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOfferString: inventoryArr.value?.isOffer ?? "",
        offerPriceString: inventoryArr.value?.offerPrice ?? "",
        sellPriceString: inventoryArr.value?.sellPrice ?? "",
        percentageDisString: inventoryArr.value?.percentageDis ?? "",
        productDescriptionString: inventoryArr.value?.productDescription ?? "",
        inventoryIdString: inventoryArr.value?.inventoryId ?? "");
    if (inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty) {
      addBannerImage(productImagesList: inventoryArr.value!.productImage!);
    }
  }

  void whenInventoryArrayIsNotNullOrIsVariantFalseOrIsColorTrue() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOfferString: inventoryArr.value?.isOffer ?? "",
        offerPriceString: inventoryArr.value?.offerPrice ?? "",
        sellPriceString: inventoryArr.value?.sellPrice ?? "",
        percentageDisString: inventoryArr.value?.percentageDis ?? "",
        productDescriptionString: inventoryArr.value?.productDescription ?? "",
        inventoryIdString: inventoryArr.value?.inventoryId ?? "");
    if (inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty) {
      addBannerImage(productImagesList: inventoryArr.value!.productImage!);
    }
  }

  void whenInventoryArrayIsNotNullOrIsVariantTrueOrIsColorFalse() {
    setTheValueOfPriceOrOfferPriceOrProductDescription(
        isOfferString: inventoryArr.value?.isOffer ?? "",
        offerPriceString: inventoryArr.value?.offerPrice ?? "",
        sellPriceString: inventoryArr.value?.sellPrice ?? "",
        percentageDisString: inventoryArr.value?.percentageDis ?? "",
        productDescriptionString: inventoryArr.value?.productDescription ?? "",
        inventoryIdString: inventoryArr.value?.inventoryId ?? "");
    if (inventoryArr.value?.productImage != null &&
        inventoryArr.value!.productImage!.isNotEmpty) {
      addBannerImage(productImagesList: inventoryArr.value!.productImage!);
    }
  }

  void setTheValueOfPriceOrOfferPriceOrProductDescription(
      {
      String isOfferString = '',
      String offerPriceString = '',
      String sellPriceString = '',
      String percentageDisString = '',
      String productDescriptionString = '',
      String inventoryIdString = ''}) {
    isOffer.value = isOfferString;
    offerPrice.value = offerPriceString;
    sellPrice.value = sellPriceString;
    percentageDis.value = percentageDisString;
    productDescription.value = productDescriptionString;
    inventoryId.value = inventoryIdString;
  }

  void addBannerImage({required List<ProductImage> productImagesList}) {
    productImageList.clear();
    productImagesListView.clear();
    for (var element in productImagesList) {
      if (element.productImage != null && element.productImage!.isNotEmpty) {
        productImageList
            .add(CommonMethods.imageUrl(url: element.productImage.toString()));
        productImagesListView.add(NetworkImage(
            CommonMethods.imageUrl(url: element.productImage.toString())));
      }
    }

    if (productImageList.isNotEmpty) {
      currentIndexOfDotIndicator.value = 0;
      if (myController.ready == true) {
        myController.jumpToPage(0);
      }
    }
  }

  Future<void> getProductDetailRecentApi2() async {
    getProductDetailRecentApiValue.value = true;
    customerId.value =
        (await MyCommonMethods.getString(key: ApiKeyConstant.customerId)) ?? '';
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

  Future<void> clickOnRelatedProduct({required String productId}) async {
    var random = Random();
    String randomValue = random.nextInt(9999).toString();
    */
/*absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();*//*

  }
}
*/
