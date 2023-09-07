import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/my_order_detail_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/modules/my_order_details/views/cancel_my_orders_detail_sheet.dart';
import 'package:zerocart/app/modules/my_order_details/views/rating_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/modules/my_orders/views/tracking_bottomsheet.dart';
import 'package:zerocart/app/routes/app_pages.dart';
import 'package:zerocart/my_colors/my_colors.dart';

import '../../../common_methods/common_methods.dart';
import '../../../common_widgets/common_widgets.dart';

class MyOrderDetailsController extends CommonMethods {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;

  String ratingCount = "1";
  List<File> selectedImageForRating = [];
  List<XFile> xFileTypeList = [];
  final descriptionController = TextEditingController();
  final isSubmitButtonVisible = true.obs;
  Map<String, dynamic> bodyParamsForProductFeedbackApi = {};
  String? productId;

  Map<String, dynamic> queryParametersForGetOrderDetailsApi = {};
  MyOrderDetailsModel? myOrderDetailsModel;
  List<ProductDetails> productDetailsList = [];

  final isEmpty = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    productId = Get.arguments;
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        await callingGetMyOrderDetailsApi();
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
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  Future<void> onRefresh() async {
    await onInit();
  }

  void increment() => count.value++;

  Future<void> callingGetMyOrderDetailsApi() async {
    queryParametersForGetOrderDetailsApi.clear();
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    queryParametersForGetOrderDetailsApi = {
      ApiKeyConstant.productId: productId.toString()
    };
    http.Response? response = await MyHttp.getMethodForParams(
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductSellerDetailApi,
        queryParameters: queryParametersForGetOrderDetailsApi,
        authorization: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        myOrderDetailsModel =
            MyOrderDetailsModel.fromJson(jsonDecode(response.body));
        if (myOrderDetailsModel != null) {
          if (myOrderDetailsModel!.productDetails != null &&
              myOrderDetailsModel!.productDetails!.isNotEmpty) {
            productDetailsList = myOrderDetailsModel!.productDetails ?? [];
            //await Future.delayed(const Duration(seconds: 5), () => bannerValue.value = false);
          }
        }
      }
    }
    increment();

/*    myOrderDetailsModel = await CommonApis.getMyOrderDetailsApi(
        queryParameters: queryParametersForGetOrderDetailsApi);
    if (myOrderDetailsModel != null &&
        myOrderDetailsModel!.productDetails != null) {
      productDetailsList = myOrderDetailsModel!.productDetails ?? [];
      //await Future.delayed(const Duration(seconds: 5), () => bannerValue.value = false);
    }*/
  }

  clickOnBackIcon() {
    Get.back();
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
                  url: productDetailsList[0].brandChartImg.toString()),
              errorBuilder: (context, error, stackTrace) =>
                  CommonWidgets.defaultImage(),
            )
          ],
        );
      },
    );
  }

  void clickOnSizeButton({required index}) {}

  void clickOnCancelButton() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColorsLight().secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        context: Get.context!,
        builder: (context) {
          ProductDetails productDetailsListObject = productDetailsList[0];
          double price = 0.0;
          if (productDetailsListObject.isOffer == "1") {
            price = price +
                double.parse(
                  double.parse(productDetailsListObject.offerPrice!)
                      .toStringAsFixed(2),
                );
          } else {
            price = price +
                double.parse(
                    double.parse(productDetailsListObject.productPrice!)
                        .toStringAsFixed(2));
          }
          return MyOrdersCancelDetailsBottomSheet(price: price);
        });
  }

  void clickOnTrackButton() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColorsLight().secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        context: Get.context!,
        builder: (context) => const TrackingBottomSheet());
  }

  void clickOnRateButton() {
    showBottomSheet();
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
        return const RatingBottomSheet();
      },
    );
  }

  void clickOnBottomSheet() {
    MyCommonMethods.unFocsKeyBoard();
  }

  void clickOnRemoveReviewImage({required int index}) {
    selectedImageForRating.remove(selectedImageForRating[index]);
    count.value++;
  }

  Future<void> clickOnAddAttachmentIcon() async {
    xFileTypeList = await MyImagePicker.pickMultipleImages();
    selectedImageForRating =
        MyImagePicker.convertXFilesToFiles(xFiles: xFileTypeList);
    count.value++;
  }

  Future<void> clickOnSubmitButton() async {
    isSubmitButtonVisible.value = false;
    MyCommonMethods.unFocsKeyBoard();
    if (descriptionController.text.trim().isNotEmpty &&
        selectedImageForRating.isNotEmpty) {
      isEmpty.value = false;
      await userProductFeedbackApiCalling();
    } else {
      if (descriptionController.text.trim().isEmpty) {
        MyCommonMethods.showSnackBar(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context!).size.height - 100,
                right: 20.px,
                left: 20.px),
            message: "Please enter some description",
            context: Get.context!);
      } else {
        MyCommonMethods.showSnackBar(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context!).size.height - 100,
                right: 20.px,
                left: 20.px),
            message: "Please select Images",
            context: Get.context!);
      }
      isEmpty.value = true;
    }
    isSubmitButtonVisible.value = true;
    /* selectedImageForRating = [];
    Get.back();
    bodyParamsForProductFeedbackApi.clear();
    descriptionController.text = "";*/
  }

  Future<void> userProductFeedbackApiCalling() async {
    bodyParamsForProductFeedbackApi.clear();
    if (descriptionController.text.trim().toString().isNotEmpty) {
      if (selectedImageForRating.isNotEmpty) {
        //isSubmitButtonVisible.value = false;
        bodyParamsForProductFeedbackApi = {
          ApiKeyConstant.productId: productId.toString(),
          ApiKeyConstant.rating: ratingCount.toString(),
          ApiKeyConstant.review: descriptionController.text.trim().toString(),
        };
        http.Response? response = await CommonApis.userProductFeedbackApi(
            imageList: selectedImageForRating,
            bodyParams: bodyParamsForProductFeedbackApi);
        if (response != null) {
          selectedImageForRating = [];
          Get.back();
          bodyParamsForProductFeedbackApi.clear();
          descriptionController.text = "";
        } else {
          Get.back();
          MyCommonMethods.showSnackBar(message: "Fail", context: Get.context!);
        }
        //isSubmitButtonVisible.value = true;
      } else {
        Get.back();
        MyCommonMethods.showSnackBar(
            message: "Please Post Related Product Images",
            context: Get.context!);
      }
    } else {
      Get.back();
      MyCommonMethods.showSnackBar(
          message: "Please Enter Some Description", context: Get.context!);
    }
  }

  void clickOnOkOrderButton({required BuildContext context}) {
    Get.back();
    Get.offNamed(Routes.CANCEL_ORDER, arguments: {
      'productDetailsList': productDetailsList[0],
      'myOrderDetailPage': 'myOrderDetailPage'
    });
    /*var snackBar = SnackBar(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: const Text('Ui is Ready But Api is not Ready'),
      margin: EdgeInsets.only(left: 4.w, right: 3.w, bottom: 4.h),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
  }

  onLoadMore() {}
}
