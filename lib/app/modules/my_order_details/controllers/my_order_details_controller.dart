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

class MyOrderDetailsController extends GetxController {
  final count = 0.obs;
  final isClickOnSize = 0.obs;
  List<File> selectedImageForRating = [];
  List<XFile> xFileTypeList = [];
  String ratingCount = "1";
  String? productId;
  final descriptionController = TextEditingController();
  final isSubmitButtonVisible = true.obs;
  Map<String, dynamic> bodyParamsForProductFeedbackApi = {};

  final bannerValue = true.obs;

  final myOrderDetailsModel = Rxn<MyOrderDetailsModel>();
  List<ProductDetails>? productDetailsList;
  Map<String, dynamic> queryParameters = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    productId = Get.arguments;
    print("productId:::::::::::::::::: $productId");
    await callingGetMyOrderDetailsApi();
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

  Future<void> callingGetMyOrderDetailsApi() async {
    queryParameters = {
      ApiKeyConstant.productId: productId.toString()
    };
    myOrderDetailsModel.value = await CommonApis.getMyOrderDetailsApi(queryParameters: queryParameters);
    if (myOrderDetailsModel.value != null) {
      productDetailsList = myOrderDetailsModel.value?.productDetails;
      await Future.delayed(const Duration(seconds: 5), () => bannerValue.value = false);
    }
  }

  void clickOnBackIcon() {
    Get.back();
  }

  void clickOnSizeChartTextButton() {}

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
          ProductDetails productDetailsListObject = productDetailsList![0];
          double price = 0.0;
          if (productDetailsListObject.isOffer == "1") {
            price = price + double.parse(double.parse(productDetailsListObject.offerPrice!).toStringAsFixed(2),);
          } else {
            price = price + double.parse(double.parse(productDetailsListObject.productPrice!).toStringAsFixed(2));
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

  void clickOnBottomSheet() {}

  void clickOnRemoveReviewImage({required int index}) {
    selectedImageForRating.remove(selectedImageForRating[index]);
    count.value++;
  }

  Future<void> clickOnAddAttachmentIcon() async {
    xFileTypeList = await MyImagePicker.pickMultipleImages();
    selectedImageForRating = MyImagePicker.convertXFilesToFiles(xFiles: xFileTypeList);
    count.value++;
  }

  Future<void> clickOnSubmitButton() async {
    isSubmitButtonVisible.value = false;
    await userProductFeedbackApiCalling();
    isSubmitButtonVisible.value = true;
   /* selectedImageForRating = [];
    Get.back();
    bodyParamsForProductFeedbackApi.clear();
    descriptionController.text = "";*/
  }

  Future<void> userProductFeedbackApiCalling() async {
    if (descriptionController.text.trim().toString().isNotEmpty) {
     if(selectedImageForRating.isNotEmpty){
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
         print("response::::: $response");
         selectedImageForRating = [];
         Get.back();
         bodyParamsForProductFeedbackApi.clear();
         descriptionController.text = "";
       }else{
         Get.back();
         MyCommonMethods.showSnackBar(message: "Fail", context: Get.context!);
       }
       //isSubmitButtonVisible.value = true;
     } else {
       Get.back();
       MyCommonMethods.showSnackBar(message: "Please Post Related Product Images", context: Get.context!);
     }
    } else {
      Get.back();
      MyCommonMethods.showSnackBar(message: "Please Enter Some Description", context: Get.context!);
    }
  }

  void clickOnOkOrderButton({required BuildContext context}) {
    Get.back();
    Get.offNamed(Routes.CANCEL_ORDER,arguments: {'productDetailsList':productDetailsList?[0],'myOrderDetailPage':'myOrderDetailPage'});
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
}
