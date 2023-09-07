import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_modals/get_review_modal.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';
import '../../../apis/api_constant/api_constant.dart';
import '../../../common_methods/common_methods.dart';
import 'package:http/http.dart' as http;

class AllReviewsController extends CommonMethods{
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;
  final isLastPage = false.obs;

  final checkBoxValue = false.obs;

  GetProductReviewApiModel? getProductReviewApiModel;
  RateStar? rateStar;
  List<RateStar> rateStarList = [];
  ReviewList? review;
  List<ReviewList> reviewList = [];
  ReviewFile? reviewFile;
  List<ReviewFile> reviewFileList = [];
  ReviewList? bestReview;
  RatingAverage? rattingAverage;
  DateTime? dateTime;
  Map<String, dynamic> queryParametersForGetProductReview = {};
  final rattingAvg = ''.obs;
  String? productId = Get.parameters['productId'];


  @override
  Future<void> onInit() async {
    super.onInit();
    responseCode = 0;
    onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        callGetProductReviewApi(productId: productId);
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
          //offset = 0;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }
  void increment() => count.value++;

  Future<void> callGetProductReviewApi({String? productId}) async {
    queryParametersForGetProductReview = {'productId': productId};
    Map<String, String> authorization = {};
    String? token =
    await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParametersForGetProductReview,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductReviewApi);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getProductReviewApiModel = GetProductReviewApiModel.fromJson(jsonDecode(response.body));
        if (getProductReviewApiModel != null) {
          if (getProductReviewApiModel?.rateStar != null &&
              getProductReviewApiModel!.rateStar!.isNotEmpty) {
            rateStarList = getProductReviewApiModel!.rateStar!;
          }

          if (getProductReviewApiModel?.reviewList != null &&
              getProductReviewApiModel!.reviewList!.isNotEmpty) {
            reviewList = getProductReviewApiModel!.reviewList!;
          }

          if (getProductReviewApiModel?.bestReview != null) {
            bestReview = getProductReviewApiModel?.bestReview;
          }

          if (getProductReviewApiModel?.ratingAverage != null) {
            rattingAverage = getProductReviewApiModel?.ratingAverage;
          }
        }
      }
    }
    increment();
  }

  void clickOnBackIcon({required BuildContext context}) {
    Get.back();
  }

  void clickOnReviewImageList({required int index}) {}

  onRefresh() async {
    await onInit();
  }
}
