import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/model_progress_bar/model_progress_bar.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../custom/custom_gradient_text.dart';
import '../../../custom/scroll_splash_gone.dart';
import '../controllers/my_order_details_controller.dart';

class MyOrderDetailsView extends GetView<MyOrderDetailsController> {
  const MyOrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: appBarView(),
          body: Obx(() {
            if (CommonMethods.isConnect.value) {
              controller.count.value;
              if (controller.myOrderDetailsModel != null &&
                  controller.responseCode == 200) {
                if (controller.productDetailsList.isNotEmpty) {
                  return CommonWidgets.commonRefreshIndicator(
                    onRefresh: () => controller.onRefresh(),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          AspectRatio(
                            aspectRatio: 1.7,
                            child: Container(
                              color: MyColorsLight().onPrimary.withOpacity(.2),
                              child: (controller.productDetailsList[0]
                                              .thumbnailImage !=
                                          null &&
                                      controller.productDetailsList[0]
                                          .thumbnailImage!.isNotEmpty)
                                  ? Image.network(
                                      CommonMethods.imageUrl(
                                        url: controller.productDetailsList[0]
                                            .thumbnailImage
                                            .toString(),
                                      ),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return CommonWidgets
                                            .commonShimmerViewForImage();
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              CommonWidgets.defaultImage(),
                                    )
                                  : /*controller.bannerValue.value
                                  ? CommonWidgets.commonShimmerViewForImage()
                                  :*/
                                  CommonWidgets.defaultImage(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Zconstant.margin, vertical: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                productInfo(),
                                productSize(),
                                SizedBox(height: 20.px),
                                productAndSellerDescription(),
                                SizedBox(height: 1.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Zconstant.margin16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      cancelOrderButtonView(),
                                      trackButtonView(),
                                    ],
                                  ),
                                ),
                                rateButton(),
                                SizedBox(height: 20.px),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: CommonWidgets.commonNoDataFoundImage(
                      onRefresh: () => controller.onRefresh(),
                    ),
                  );
                }
              } else {
                if (controller.responseCode == 0) {
                  return const SizedBox();
                }
                return Expanded(
                    child: CommonWidgets.commonSomethingWentWrongImage(
                  onRefresh: () => controller.onRefresh(),
                ));
              }
            } else {
              return CommonWidgets.commonNoInternetImage(
                onRefresh: () => controller.onRefresh(),
              );
            }
          }),
        ),
      );
    });
  }

  PreferredSizeWidget appBarView() => const MyCustomContainer().myAppBar(
      isIcon: true,
      backIconOnPressed: () => controller.clickOnBackIcon(),
      text: 'My Order Details');

  Widget productInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.productDetailsList[0].brandName != null &&
                  controller.productDetailsList[0].brandName!.isNotEmpty)
                brandNameTextView(),
              if (controller.productDetailsList[0].productName != null &&
                  controller.productDetailsList[0].productName!.isNotEmpty)
                brandProductNameTextView(),
              SizedBox(height: 1.h),
              if (controller.productDetailsList[0].colorCode != null &&
                  controller.productDetailsList[0].colorCode!.isNotEmpty)
                colorsView()
            ],
          ),
        ),
        SizedBox(height: 1.6.h, width: 3.w),
        Expanded(
          flex: 5,
          child: productPriceView(),
        )
      ],
    );
  }

  Widget brandNameTextView() => Text(
        controller.productDetailsList[0].brandName.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
            color: Theme.of(Get.context!)
                .textTheme
                .headline3
                ?.color
                ?.withOpacity(.85)),
      );

  Widget brandProductNameTextView() => Text(
        controller.productDetailsList[0].productName.toString(),
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget colorsView() {
    String color = controller.productDetailsList[0].colorCode.toString();
    String colorCode = color.replaceAll("#", "0xff");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        colorTextView(),
        SizedBox(width: 15.px),
        if (color.isNotEmpty)
          SizedBox(
            height: 16.px,
            width: 16.px,
            child: unselectedColorView(replaceColor: colorCode),
          ),
      ],
    );
  }

  Widget colorTextView() => Text(
        "Color:",
        style: Theme.of(Get.context!)
            .textTheme
            .headline5
            ?.copyWith(fontSize: 14.px),
      );

  Widget unselectedColorView({required String replaceColor}) => Container(
    decoration: const BoxDecoration(shape: BoxShape.circle),
    height: 20.px,
    width: 17.px,
    child: UnicornOutline(
      strokeWidth: 1.5.px,
      radius: 10.px,
      gradient: CommonWidgets.commonLinearGradientView(),
      child: Container(
        height: 20.px,
        width: 15.px,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(int.parse(replaceColor)),
        ),
      ),
    ),
  );

  Widget productPriceView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        priceView(),
        SizedBox(height: .5.h),
        if (controller.productDetailsList[0].rateAverage != null &&
            controller.productDetailsList[0].rateAverage!.isNotEmpty)
          ratingElevatedButtonView(),
        SizedBox(height: 6.px),
        reviewsTextView(),
      ],
    );
  }

  Widget priceView() {
    if (controller.productDetailsList[0].isOffer != null &&
        controller.productDetailsList[0].isOffer != "0") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          itemPriceTextView(
              value: controller.productDetailsList[0].offerPrice.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (controller.productDetailsList[0].productPrice != null &&
                  controller.productDetailsList[0].productPrice!.isNotEmpty)
                Flexible(child: itemOriginalPriceTextView()),
              SizedBox(width: 8.px),
              if (controller.productDetailsList[0].percentageDis != null &&
                  controller.productDetailsList[0].percentageDis!.isNotEmpty)
                howManyPercentOffTextView()
            ],
          ),
        ],
      );
    } else {
      return itemPriceTextView(
          value: controller.productDetailsList[0].productPrice.toString(),);
    }
  }

  Widget itemPriceTextView({required String value}) => GradientText(
        'Rs $value',
        gradient: CommonWidgets.commonLinearGradientView(),
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(overflow: TextOverflow.ellipsis),
      );

  Widget itemOriginalPriceTextView() => Text(
        controller.productDetailsList[0].productPrice.toString(),
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 10.px, decoration: TextDecoration.lineThrough),
      );

  Widget howManyPercentOffTextView() => Text(
        '${controller.productDetailsList[0].percentageDis}% off',
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 10.px),
      );

  Widget ratingElevatedButtonView() => Container(
        height: 21.px,
        width: 13.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.px),
          gradient: CommonWidgets.commonLinearGradientView(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 13.px,
              width: 13.px,
              child: Image.asset(
                "assets/star_white.png",
              ),
            ),
            ratingTextView(),
          ],
        ),
      );

  Widget ratingTextView() => Flexible(
        child: Text(
          controller.productDetailsList[0].rateAverage.toString(),
          style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
                color: MyColorsLight().secondary,
              ),
          maxLines: 1,
        ),
      );

  Widget reviewsTextView() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              controller.productDetailsList[0].totalReview.toString(),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(Get.context!)
                  .textTheme
                  .headline3
                  ?.copyWith(fontSize: 10.px),
            ),
          ),
          SizedBox(width: 2.px),
          Text(
            "Reviews",
            textAlign: TextAlign.start,
            maxLines: 1,
            style: Theme.of(Get.context!)
                .textTheme
                .headline3
                ?.copyWith(fontSize: 10.px),
          ),
        ],
      );

  Widget productSize() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (controller.productDetailsList[0].variantAbbreviation !=
                      null &&
                  controller
                      .productDetailsList[0].variantAbbreviation!.isNotEmpty)
                sizeTextView(),
              if (controller.productDetailsList[0].variantAbbreviation !=
                      null &&
                  controller
                      .productDetailsList[0].variantAbbreviation!.isNotEmpty)
                SizedBox(width: 12.px),
              if (controller.productDetailsList[0].variantAbbreviation !=
                      null &&
                  controller
                      .productDetailsList[0].variantAbbreviation!.isNotEmpty)
                selectedSizeView(),
              if (controller.productDetailsList[0].brandChartImg != null &&
                  controller.productDetailsList[0].brandChartImg!.isNotEmpty)
                const Spacer(),
              if (controller.productDetailsList[0].brandChartImg != null &&
                  controller.productDetailsList[0].brandChartImg!.isNotEmpty)
                textButton(
                    text: 'Size Chart',
                    onPressed: () => controller.clickOnSizeChartTextButton()),
            ],
          ),
        ],
      );

  Widget textButton({required String text, required VoidCallback onPressed}) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 14.px, decoration: TextDecoration.underline),
          textAlign: TextAlign.right,
        ),
      );

  Widget sizeTextView() => Text(
        "Size:",
        style: Theme.of(Get.context!)
            .textTheme
            .headline5
            ?.copyWith(fontSize: 14.px),
      );

  Widget quantityTextView() => Text(
        "Quantity:",
        style: Theme.of(Get.context!)
            .textTheme
            .headline5
            ?.copyWith(fontSize: 14.px),
      );

  Widget selectedSizeView() => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.px),
          border: Border.all(
            color: Theme.of(Get.context!).textTheme.subtitle1!.color!,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color!),
            controller.productDetailsList[0].variantAbbreviation.toString(),
          ),
        ),
      );

  Widget productAndSellerDescription() {
    return Obx(() {
      print(controller.count.value);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.productDetailsList[0].productDescription != null &&
              controller.productDetailsList[0].productDescription!.isNotEmpty)
            productAndSellerDescriptionTextView(text: "Product Description"),
          if (controller.productDetailsList[0].productDescription != null &&
              controller.productDetailsList[0].productDescription!.isNotEmpty)
            removeHtmlTagsProductAndSellerDescription(
                string: controller.productDetailsList[0].productDescription
                    .toString()),
          if (controller.productDetailsList[0].sellerDescription != null &&
              controller.productDetailsList[0].sellerDescription!.isNotEmpty)
            SizedBox(height: 10.px),
          if (controller.productDetailsList[0].sellerDescription != null &&
              controller.productDetailsList[0].sellerDescription!.isNotEmpty)
            productAndSellerDescriptionTextView(text: "Seller Description"),
          if (controller.productDetailsList[0].sellerDescription != null &&
              controller.productDetailsList[0].sellerDescription!.isNotEmpty)
            removeHtmlTagsProductAndSellerDescription(
                string: controller.productDetailsList[0].sellerDescription
                    .toString()),
        ],
      );
    });
  }

  Widget productAndSellerDescriptionTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .headline5
            ?.copyWith(fontSize: 14.px),
      );

  Widget removeHtmlTagsProductAndSellerDescription({required String string}) {
    return Html(
      data: string.trim(),
      shrinkWrap: false,
      style: {
        "body": Style(
            fontFamily: "Nunito",
            fontSize: FontSize(14.px),
            fontWeight: FontWeight.bold,
            color: Theme.of(Get.context!).textTheme.subtitle2?.color),
        "li": Style(
          listStyleType: ListStyleType.circle,
        ),
      },
    );
  }

  Widget cancelOrderButtonView() => CommonWidgets.myOutlinedButton(
      text: cancelOrderTextView(),
      onPressed: () => controller.clickOnCancelButton(),
      height: 40.px,
      radius: 5.px,
      width: 43.w,
      margin: EdgeInsets.zero);

  Widget trackButtonView() => CommonWidgets.myOutlinedButton(
      text: trackTextView(),
      onPressed: () => controller.clickOnTrackButton(),
      margin: EdgeInsets.zero,
      height: 40.px,
      width: 43.w,
      radius: 5.px);

  Widget cancelOrderTextView() => Text(
        "CANCEL ORDER",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget trackTextView() => Text(
        "TRACK ORDER",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget rateButton() {
    return CommonWidgets.myOutlinedButton(
      height: 42.px,
      margin: EdgeInsets.zero,
      text: Text(
        'Rate',
        style: Theme.of(Get.context!).textTheme.headline3,
      ),
      radius: 5.px,
      onPressed: () => controller.clickOnRateButton(),
    );
  }
}
