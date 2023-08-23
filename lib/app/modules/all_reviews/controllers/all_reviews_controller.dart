import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_modals/get_review_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';

class AllReviewsController extends GetxController {

  final count = 0.obs;
  final checkBoxValue = false.obs;

  final getReviewModal = Rxn<GetReviewModal?>();
  final rateStar=Rxn<RateStar?>();
  final rateStarList = Rxn<List<RateStar>?>();
  final review=Rxn<ReviewList?>();
  final reviewList = Rxn<List<ReviewList>?>();
  final reviewFile=Rxn<ReviewFile?>();
  final reviewFileList = Rxn<List<ReviewFile>?>();
  final bestReview = Rxn<BestReview?>();
  final rattingAverage=Rxn<RatingAverage?>();
  DateTime?   dateTime;
  Map<String, dynamic> queryParametersForGetProductReview = {};
  final rattingAvg=''.obs;
  String? productId = Get.parameters['productId'];
  List<String> list=["assets/categories_icon.png","assets/banner.png","assets/chat_gradient.png","assets/banner.png","assets/chat_gradient.png","assets/banner.png","assets/chat_gradient.png","assets/banner.png","assets/chat_gradient.png"];

  @override
  void onInit() {
    super.onInit();
    callGetProductReviewApi(productId: productId);
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

  Future<void> callGetProductReviewApi({String? productId}) async {
    queryParametersForGetProductReview = {'productId': productId};
    getReviewModal.value = await CommonApis.getProductReviewApi(
        queryParameters: queryParametersForGetProductReview);
    if (getReviewModal.value != null) {
      if (getReviewModal.value?.rateStar != null &&
          getReviewModal.value!.rateStar!.isNotEmpty) {
        rateStarList.value = getReviewModal.value?.rateStar;
      }

      if (getReviewModal.value?.reviewList != null &&
          getReviewModal.value!.reviewList!.isNotEmpty) {
        reviewList.value = getReviewModal.value?.reviewList;

      }

      if (getReviewModal.value?.bestReview != null) {
        bestReview.value = getReviewModal.value?.bestReview;
      }

      if (getReviewModal.value?.ratingAverage != null) {
        rattingAverage.value = getReviewModal.value?.ratingAverage;
      }
    }
  }

  void clickOnBackIcon({required BuildContext context}) {
    Get.back();
  }

  void clickOnReviewImageList({required int index}) {}




}
