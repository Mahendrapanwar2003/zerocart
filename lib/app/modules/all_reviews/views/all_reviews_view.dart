import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../controllers/all_reviews_controller.dart';

class AllReviewsView extends GetView<AllReviewsController> {
  const AllReviewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyCustomContainer().myAppBar(text: 'All Reviews', isIcon: true,backIconOnPressed: () =>
          controller.clickOnBackIcon(context: context)),
      body: Obx(() {
        if (CommonMethods.isConnect.value) {
          if (controller.getReviewModal.value != null) {
            if ((controller.reviewList.value != null &&
                    controller.reviewList.value!.isNotEmpty) &&
                (controller.rateStarList.value != null &&
                    controller.rateStarList.value!.isNotEmpty) &&
                (controller.rattingAverage.value != null)) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [

                  SizedBox(height: 1.h),
                /*  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: CommonWidgets.profileMenuDash(),
                  ),*/
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.rattingAverage.value != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (controller.rattingAverage.value
                                              ?.rateAverage !=
                                          null &&
                                      controller.rattingAverage.value!
                                          .rateAverage!.isNotEmpty)
                                    avgRatingView(),
                                  if (controller.rattingAverage.value
                                              ?.totalReview !=
                                          null &&
                                      controller.rattingAverage.value
                                              ?.totalRating !=
                                          null)
                                    ratingAndReviewsTexView()
                                ],
                              ),
                            SizedBox(
                              height: 18.h,
                              child: VerticalDivider(
                                color: MyColorsLight().textGrayColor,
                                thickness: 1.px,
                              ),
                            ),
                            if (controller.rateStarList.value != null &&
                                controller.rateStarList.value!.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(right: 6.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonRatingPercentageGraph(
                                        graphNumber: controller.rateStarList
                                                .value?[0].rating ??
                                            "",
                                        graphRatedCount: controller.rateStarList
                                                .value?[0].ratingCount ??
                                            "",
                                        percentOfGraph: controller.rateStarList
                                                .value?[0].ratePer ??
                                            ""),
                                    commonRatingPercentageGraph(
                                        graphNumber: controller.rateStarList
                                                .value?[1].rating ??
                                            "",
                                        graphRatedCount: controller.rateStarList
                                                .value?[1].ratingCount ??
                                            "",
                                        percentOfGraph: controller.rateStarList
                                                .value?[1].ratePer ??
                                            ""),
                                    commonRatingPercentageGraph(
                                        graphNumber: controller.rateStarList
                                                .value?[2].rating ??
                                            "",
                                        graphRatedCount: controller.rateStarList
                                                .value?[2].ratingCount ??
                                            "",
                                        percentOfGraph: controller.rateStarList
                                                .value?[2].ratePer ??
                                            ""),
                                    commonRatingPercentageGraph(
                                        graphNumber: controller.rateStarList
                                                .value?[3].rating ??
                                            "",
                                        graphRatedCount: controller.rateStarList
                                                .value?[3].ratingCount ??
                                            "",
                                        percentOfGraph: controller.rateStarList
                                                .value?[3].ratePer ??
                                            ""),
                                    commonRatingPercentageGraph(
                                        graphNumber: controller.rateStarList
                                                .value?[4].rating ??
                                            "",
                                        graphRatedCount: controller.rateStarList
                                                .value?[4].ratingCount ??
                                            "",
                                        percentOfGraph: controller.rateStarList
                                                .value?[4].ratePer ??
                                            ""),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        if (controller.reviewList.value != null &&
                            controller.reviewList.value!.isNotEmpty)
                          reviewListView()
                      ],
                    ),
                  )
                ],
              );
            } else {
              return CommonWidgets.noDataTextView();
            }
          } else {
            return CommonWidgets.progressBarView();
          }
        } else {
          return CommonWidgets.progressBarView();
        }
      }),
    );
  }

  Widget backIconView({required BuildContext context}) => IconButton(
        onPressed: () => controller.clickOnBackIcon(context: context),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Theme.of(Get.context!).textTheme.subtitle1?.color,
        ),
        splashRadius: 24.px,
        iconSize: 18.px,
      );

  Widget allReviewsTextView() => Text(
        "All Reviews",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget avgRatingView() => RatingBar.builder(
        initialRating:
            double.parse(controller.rattingAverage.value!.rateAverage!),
        minRating: 0,
        itemSize: 20.px,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemBuilder: (context, _) => GradientIconColor(
          gradient: CommonWidgets.commonLinearGradientView(),
          Icons.star,
        ),
        ignoreGestures: true,
        onRatingUpdate: (rating) {},
      );

  Widget ratingAndReviewsTexView() => Text(
        "${controller.rattingAverage.value?.totalRating} ratings and\n ${controller.rattingAverage.value?.totalRating}  reviews",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(fontSize: 14.px),
      );

  Widget commonRatingPercentageGraph(
          {required String graphNumber,
          required String graphRatedCount,
          required String percentOfGraph}) =>
      Row(
        children: [
          ratingPercentageTextView(text: graphNumber),
          ratingIconView(),
          SizedBox(
            width: 25.w,
            child: LinearProgressIndicator(
              value: double.parse(percentOfGraph) / 100.0,
              backgroundColor: MyColorsLight().textGrayColor,
              color: MyColorsLight().primary,
            ),
          ),
          SizedBox(width: 1.w),
          totalRatingTextView(text: graphRatedCount)
        ],
      );

  Widget ratingPercentageTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget ratingIconView() => GradientIconColor(
        Icons.star,
        size: 20.px,
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget totalRatingTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .headline5
            ?.copyWith(fontSize: 14.px),
      );

  Widget reviewListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        controller.review.value = controller.reviewList.value![index];
        if(controller.reviewList.value?[index].reviewFile != null&& controller.reviewList.value![index].reviewFile!.isNotEmpty)
          {
            controller.reviewFileList.value=controller.reviewList.value![index].reviewFile;
          }
        if (controller.review.value?.createdDate != null &&
            controller.review.value!.createdDate!.isNotEmpty) {
          controller.dateTime =
              DateTime.parse(controller.review.value!.createdDate!);
        }
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidgets.profileMenuDash(),
                SizedBox(height: 2.h),
                if (controller.review.value?.rating != null &&
                    controller.review.value!.rating!.isNotEmpty)
                  avgRatingViewForList(
                      index: index,
                      howManyStarRating: controller.review.value?.rating ?? ""),
                if (controller.review.value?.rating != null &&
                    controller.review.value!.rating!.isNotEmpty)
                  SizedBox(height: 1.h),
                if (controller.review.value?.review != null &&
                    controller.review.value!.review!.isNotEmpty)
                  customerReviewTextView(
                      value: controller.review.value?.review ?? ""),
                if (controller.review.value?.review != null &&
                    controller.review.value!.review!.isNotEmpty)
                  SizedBox(height: 1.h),
                if (controller.reviewFileList.value != null &&
                    controller.reviewFileList.value!.isNotEmpty)
                  SizedBox(height: 50.px,child: customerProductRatingPictureListView(),),
                if (controller.review.value?.reviewFile != null &&
                    controller.review.value!.reviewFile!.isNotEmpty)
                  SizedBox(height: 1.h),
                if (controller.review.value?.customerName != null && controller.dateTime != null)
                  Row(
                    children: [
                      GradientIconColor(
                        Icons.verified_sharp,
                        gradient: CommonWidgets.commonLinearGradientView(),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customerNameTextViewOrTime(
                                text:
                                    "${controller.review.value?.customerName} ${controller.dateTime?.day}-${controller.dateTime?.month}-${controller.dateTime?.year} "),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 2.h),
                CommonWidgets.profileMenuDash(),
              ],
            )
          ],
        );
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.reviewList.value?.length,
    );
  }

  Widget avgRatingViewForList(
          {required int index, required String howManyStarRating}) =>
      RatingBar.builder(
        initialRating: double.parse(howManyStarRating),
        minRating: 0,
        itemSize: 20.px,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemBuilder: (context, _) => GradientIconColor(
          gradient: CommonWidgets.commonLinearGradientView(),
          Icons.star,
        ),
        ignoreGestures: true,
        onRatingUpdate: (rating) {},
      );

  Widget customerReviewTextView({required String value}) =>
      Text(value, style: Theme.of(Get.context!).textTheme.subtitle1);

  Widget customerProductRatingPictureListView() => ListView.builder(
    itemBuilder: (context, index) {
      controller.reviewFile.value=controller.reviewFileList.value![index];
      if(controller.reviewFile.value?.revPhoto != null && controller.reviewFile.value!.revPhoto!.isNotEmpty)
        {
          return Padding(
            padding:  EdgeInsets.only(right:5.px ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(right: 10.px),
                  child: InkWell(
                      onTap: ()=>controller.clickOnReviewImageList(index:index),
                      borderRadius: BorderRadius.circular(5.px),
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(5.px),
                          child: Image.network(
                            ApiConstUri.baseUrl+ controller.reviewFile.value!.revPhoto!,
                            fit: BoxFit.cover,
                            height: 45.px,
                            width: 45.px,
                          ))
                  ),
                ),
              ],
            ),
          );
        }
      else
        {
          return const SizedBox();
        }
    },
    physics: const BouncingScrollPhysics(),
    itemCount: controller.reviewFileList.value?.length,
    padding: EdgeInsets.zero,
    scrollDirection: Axis.horizontal,
  );

  Widget iconButton(
          {required IconData icon,
          required VoidCallback onPressed,
          Color? color}) =>
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 18.px,
          color: color,
        ),
        splashRadius: 20.px,
      );

  Widget customerNameTextViewOrTime({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
              fontSize: 14.px,
            ),
      );
}
