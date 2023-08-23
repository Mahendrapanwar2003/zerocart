/*
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_modals/get_product_detail_modal.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../common_widgets/common_widgets.dart';
import '../controllers/product_detailss_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(context: context),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: const MyCustomContainer().myAppBar(
            text: 'Product Detail',
            backIconOnPressed: () => controller.clickOnBackButton(),
            isIcon: true),
        body: Obx(
          () => AbsorbPointer(
            absorbing: controller.absorbing.value,
            child: Obx(
              () {
                if (CommonMethods.isConnect.value) {
                  if (controller.getProductDetailsModel.value != null) {
                    if (controller.productDetail.value != null &&
                        (controller.listOfInventoryArr.value != null &&
                            controller.listOfInventoryArr.value!.isNotEmpty)) {
                      return ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            bannerImageView(context: context),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Zconstant.margin,
                                      vertical: 2.h),
                                  child: Column(
                                    children: [
                                               productInfo(),
                                      if (controller.isVariant.value != "1")
                                        SizedBox(height: 8.px),
                                      productSize(),
                                      SizedBox(height: 10.px),
                                      (controller.productDetail.value!
                                                      .inStock !=
                                                  null &&
                                              controller.productDetail.value!
                                                  .inStock!.isNotEmpty)
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                        child: addToCartButton(
                                                            context: context)),
                                                    SizedBox(width: 16.px),
                                                    if (controller
                                                                .productDetail
                                                                .value!
                                                                .vendorType !=
                                                            null &&
                                                        controller
                                                            .productDetail
                                                            .value!
                                                            .vendorType!
                                                            .isNotEmpty)
                                                      Expanded(
                                                        child: buyNowOrCustomizeButton(
                                                            buttonText: controller
                                                                        .productDetail
                                                                        .value!
                                                                        .vendorType
                                                                        .toString() ==
                                                                    'Tailor'
                                                                ? 'Customize'
                                                                : 'Add to Outfit'),
                                                      ),
                                                  ],
                                                ),
                                                SizedBox(height: 1.h),
                                                buyNowOrCustomizeButton(
                                                    buttonText: "Buy Now"),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                outOfStockTextView(),
                                              ],
                                            ),
                                      // addToWishlistButton(context: context),
                                      SizedBox(height: 4.px),
                                      productAndSellerDescription(),
                                      SizedBox(height: 4.px),
                                      reviewsAndRatings(context: context),
                                    ],
                                  ),
                                ),
                                (controller.getProductApiModel.value != null)
                                    ? (controller.recentProductsList != null &&
                                            controller
                                                .recentProductsList!.isNotEmpty)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Zconstant.margin),
                                                child: youMayAlsoLikeTextView(),
                                              ),
                                              SizedBox(height: 1.h),
                                              relatedProductsList(),
                                            ],
                                          )
                                        : CommonWidgets.noDataTextView(text: '')
                                    : controller.getProductDetailRecentApiValue
                                            .value
                                        ? CommonWidgets.progressBarView()
                                        : const SizedBox()
                              ],
                            ),
                            SizedBox(height: 6.h),
                          ],
                        ),
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
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget bannerImageView({required BuildContext context}) {
    return Obx(() {
      controller.current.value;
      if (controller.productImageList.isNotEmpty) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              onTap: () => controller.clickOnProductImage(context: context),
              child: CarouselSlider(
                items: controller.productImageList
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              item,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                carouselController: controller.myController,
                options: CarouselOptions(
                    aspectRatio: 1.2.px,
                    onPageChanged: (index, reason) {
                      controller.currentIndexOfDotIndicator.value = index;
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.px),
              child: customDotIndicatorList(),
            ),
          ],
        );
      } else {
        return AspectRatio(
          aspectRatio: 16.px / 9.px,
          child: controller.bannerValue.value
              ? CommonWidgets.commonShimmerViewForImage()
              : Container(
                  color: MyColorsLight().onPrimary.withOpacity(.2),
                  child: CommonWidgets.noDataTextView(text: 'No Image Found!'),
                ),
        );
      }
    });
  }

  Widget customDotIndicatorList() {
    return SizedBox(
      height: 10.px,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.productImageList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Obx(() {
            return controller.currentIndexOfDotIndicator.value == index
                ? customDot(true)
                : customDot(false);
          });
        },
      ),
    );
  }

  Widget customDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.px),
      width: 10.px,
      child: UnicornOutline(
        strokeWidth: 1.px,
        radius: 5.px,
        gradient: CommonWidgets.commonLinearGradientView(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 8.px,
          width: 8.px,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? MyColorsLight().secondary : Colors.transparent,
          ),
        ),
      ),
    );
  }

*/
/*  Widget banner() {
    return bannerImage();
  }

   Widget bannerImage() {
    return AspectRatio(
      aspectRatio: 16.px / 9.px,
      child: LightCarousel(
        images: controller.productImageList,
        dotSize: 0,
        autoPlay: true,
        onImageChange: (reason, index) {
          controller.current.value = index;
        },
        boxFit: BoxFit.cover,
        dotBgColor: Colors.transparent,
        defaultImage: CommonWidgets.defaultImage(),
      ),
    );
  }

  Widget customDotIndicatorList() {
    return SizedBox(
      height: 10.px,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.productImageList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Obx(() {
            return controller.current.value == index
                ? customDot(true)
                : customDot(false);
          });
        },
      ),
    );
  }

  Widget customDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.px),
      width: 10.px,
      child: UnicornOutline(
        strokeWidth: 1.px,
        radius: 5.px,
        gradient: CommonWidgets.commonLinearGradientView(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 8.px,
          width: 8.px,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? MyColorsLight().secondary : Colors.transparent,
          ),
        ),
      ),
    );
  }*//*


  Widget productInfo() {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.productDetail.value?.brandName != null &&
                  controller.productDetail.value!.brandName!.isNotEmpty)
                brandNameTextView(),
              if (controller.productDetail.value?.productName != null &&
                  controller.productDetail.value!.productName!.isNotEmpty)
                brandProductNameTextView(),
              SizedBox(height: 2.px),
              if (controller.isColor.value == "1") colorsView()
            ],
          ),
        ),
        SizedBox(height: 2.px, width: 3.w),
        Expanded(
          flex: 5,
          child: productPriceView(),
        )
      ],
    );
  }

  Widget brandNameTextView() => Text(
        controller.productDetail.value!.brandName!,
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
        controller.productDetail.value!.productName!,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget colorsView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        colorTextView(),
        SizedBox(width: 12.px),
        SizedBox(
          height: 32.px,
          child: listOfColor(),
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

  Widget youMayAlsoLikeTextView() => Text(
        "You May Also Like",
        style: Theme.of(Get.context!)
            .textTheme
            .headline5
            ?.copyWith(fontSize: 14.px),
      );

  Widget listOfColor() => MyListView(
        listOfData: (index) {
          InventoryArr inventoryArr =
              controller.listOfInventoryArr.value![index];
          if (inventoryArr.colorCode != null &&
              inventoryArr.colorCode!.isNotEmpty) {
            String color = inventoryArr.colorCode ?? "";
            if (color.isNotEmpty) {
              String colorCode = color.replaceAll("#", "0xff");
              return Obx(
                () {
                  return Row(
                    children: [
                      InkWell(
                          onTap: () =>
                              controller.clickOnColorButton(index: index),
                          child: index == controller.isClickOnColor.value
                              ? selectedColorView(replaceColor: colorCode)
                              : unselectedColorView(replaceColor: colorCode)),
                      SizedBox(width: 8.px)
                    ],
                  );
                },
              );
            }
            return const SizedBox();
          }
        },
        physics: const ScrollPhysics(),
        itemCount: controller.listOfInventoryArr.value!.length,
        shrinkWrap: true,
        isVertical: false,
      );

  Widget productPriceView() {
    return Obx(() {
      if (controller.isOffer.value.isNotEmpty &&
          controller.isOffer.value == "0") {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (controller.sellPrice.value.isNotEmpty)
              itemPriceTextView(gradientText: controller.sellPrice.value),
            SizedBox(height: .5.h),
            if ((controller.productDetail.value?.totalReview != null &&
                    controller.productDetail.value!.totalReview!.isNotEmpty) &&
                controller.productDetail.value?.totalReview != "0")
              reviewsTextView(),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (controller.offerPrice.value.isNotEmpty)
              itemPriceTextView(gradientText: controller.offerPrice.value),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (controller.sellPrice.value.isNotEmpty)
                  Flexible(
                    child: itemOriginalPriceTextView(
                        originalPrice: controller.sellPrice.value),
                  ),
                SizedBox(width: 8.px),
                if (controller.percentageDis.value.isNotEmpty)
                  howManyPercentOffTextView()
              ],
            ),
            SizedBox(height: 4.px),
            if (controller.productDetail.value?.totalReview != null &&
                controller.productDetail.value!.totalReview!.isNotEmpty)
              reviewsTextView(),
          ],
        );
      }
    });
  }

  Widget selectedColorView({required String replaceColor}) => SizedBox(
        height: 22.px,
        width: 22.px,
        child: UnicornOutline(
          strokeWidth: 1.px,
          radius: 11.px,
          gradient: CommonWidgets.commonLinearGradientView(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.px, horizontal: 2.px),
            child: Container(
              height: 16.px,
              width: 16.px,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse(replaceColor)),
              ),
            ),
          ),
        ),
      );

  Widget unselectedColorView({required String replaceColor}) => Container(
        height: 16.px,
        width: 16.px,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(int.parse(replaceColor)),
        ),
      );

  Widget itemPriceTextView({required String gradientText}) => GradientText(
        '$curr$gradientText',
        gradient: CommonWidgets.commonLinearGradientView(),
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(overflow: TextOverflow.ellipsis),
      );

  Widget itemOriginalPriceTextView({required String originalPrice}) => Text(
        '$curr$originalPrice',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 10.px, decoration: TextDecoration.lineThrough),
      );

  Widget howManyPercentOffTextView() => Text(
        '${controller.percentageDis.value}% off',
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 10.px),
      );

  Widget ratingElevatedButtonView() => CommonWidgets.myOutlinedButton(
      height: 20.px,
      margin: EdgeInsets.zero,
      width: 50.px,
      radius: 2.px,
      text: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 2.px),
          Image.asset("assets/star_white.png",
              width: 10.px,
              height: 10.px,
              color: Theme.of(Get.context!).primaryColor),
          SizedBox(width: 4.px),
          ratingTextView(),
        ],
      ),
      linearGradient: CommonWidgets.commonLinearGradientView(),
      onPressed: () {});

  Widget ratingTextView() => Flexible(
        child: Text(
          double.parse(controller.productDetail.value!.totalRating.toString())
              .toStringAsFixed(1)
              .toString(),
          style: Theme.of(Get.context!)
              .textTheme
              .headline3
              ?.copyWith(fontSize: 10.px),
        ),
      );

  Widget reviewsTextView() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if ((controller.productDetail.value?.totalRating != null &&
                  controller.productDetail.value!.totalRating!.isNotEmpty) &&
              controller.productDetail.value?.totalRating != "0.0")
            ratingElevatedButtonView(),
          if ((controller.productDetail.value?.totalRating != null &&
                  controller.productDetail.value!.totalRating!.isNotEmpty) &&
              controller.productDetail.value?.totalRating != "0.0")
            SizedBox(width: 4.px),
          Flexible(
            child: Text(
              "${controller.productDetail.value?.totalReview}",
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
          if (controller.isVariant.value == "1") SizedBox(height: 5.px),
          if (controller.isVariant.value == "1")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sizeTextView(),
                (controller.productDetail.value?.brandChartImg != null &&
                        controller
                            .productDetail.value!.brandChartImg!.isNotEmpty)
                    ? textButton(
                        text: 'Size Chart',
                        onPressed: () =>
                            controller.clickOnSizeChartTextButton())
                    : const SizedBox(),
              ],
            ),
          SizedBox(
            height: 35.px,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (controller.isVariant.value == "1")
                  Expanded(child: listOfSizeView()),
                if (controller.isVariant.value == "1")
                  if (controller.inventoryArr.value?.isCustom.toString() == '1')
                    SizedBox(width: 4.px),
                if (controller.inventoryArr.value?.isCustom.toString() == '1')
                  customButton(buttonText: 'Custom')
              ],
            ),
          )
        ],
      );

  Widget sizeTextView() => Text(
        "Size:",
        style: Theme.of(Get.context!)
            .textTheme
            .headline5
            ?.copyWith(fontSize: 14.px),
      );

  Widget listOfSizeView() {
    if (controller.listOfInventoryArr.value != null &&
        controller.listOfInventoryArr.value!.isNotEmpty) {
      return MyListView(
          listOfData: (index) {
            return Obx(
              () {
                InventoryArr inventoryArr =
                    controller.listOfInventoryArr.value![index];
                if (inventoryArr.variantAbbreviation != null &&
                    inventoryArr.variantAbbreviation!.isNotEmpty) {
                  String listOfSize = inventoryArr.variantAbbreviation!;
                  List<dynamic> sizes = json.decode(listOfSize);
                  return MyListView(
                      listOfData: (ind) {
                        Future.delayed(Duration.zero, () async {
                          controller.sellPrice.value = sizes[ind]['sellPrice'];
                          controller.isOffer.value = sizes[ind]['isOffer'];
                          controller.offerPrice.value =
                              sizes[ind]['offerPrice'];
                        });
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.px),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.px),
                            onTap: () => controller.clickOnSizeButton(
                                index: ind, index2: index, sizes: sizes),
                            child: ind == controller.isClickOnSize.value
                                ? selectedSizeView(
                                    selectedSize: sizes[ind]
                                        ['variantAbbreviation'],
                                  )
                                : unselectedSizeView(
                                    unselectedSize: sizes[ind]
                                        ['variantAbbreviation'],
                                  ),
                          ),
                        );
                      },
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      isVertical: false,
                      itemCount: sizes.length);
                }
                return const SizedBox();
              },
            );
          },
          physics: const ClampingScrollPhysics(),
          itemCount: controller.listOfInventoryArr.value!.length,
          shrinkWrap: true,
          isVertical: false);
    } else {
      return const SizedBox();
    }
  }

  Widget selectedSizeView({required String selectedSize}) => productSizeView(
        text: selectedSize,
        color: Theme.of(Get.context!).textTheme.subtitle1!.color!,
      );

  Widget unselectedSizeView({required String unselectedSize}) =>
      productSizeView(
        text: unselectedSize,
        color: Theme.of(Get.context!).textTheme.headline5!.color!,
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

  Widget productSizeView({required String text, required Color color}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.px),
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            style: Theme.of(Get.context!)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: 14.px, color: color),
            text,
          ),
        ),
      );

  Widget addToCartButton({required BuildContext context}) {
    return Obx(() {
      return Container(
          height: 42.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.px),
          ),
          child: controller.isViewToCartVisible.value
              ? addAndViewToCartButton(
                  context: context, buttonText: "View Cart")
              : addAndViewToCartButton(
                  context: context, buttonText: 'Add To Cart'));
    });
  }

  Widget addAndViewToCartButton(
      {required BuildContext context, required String buttonText}) {
    return CommonWidgets.myElevatedButton(
      height: 42.px,
      margin: EdgeInsets.zero,
      text: Obx(() {
        return controller.isAddToCartValue.value
            ? Text(
                buttonText,
                style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
                    fontSize: 14.px, color: MyColorsLight().secondary),
              )
            : SizedBox(
                width: 30.px,
                height: 30.px,
                child: CommonWidgets.buttonProgressBarView());
      }),
      borderRadius: 5.px,
      onPressed: () => (buttonText == 'Add To Cart')
          ? controller.clickOnAddToCartButton(context: context)
          : controller.clickOnViewToCartButton(context: context),
    );
  }

  Widget customButton({required String buttonText}) {
    return CommonWidgets.myOutlinedButton(
        height: 30.px,
        margin: EdgeInsets.zero,
        width: 124.px,
        radius: 5.px,
        text: Text(
          buttonText,
          style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
              fontSize: 14.px,
              color: Theme.of(Get.context!).textTheme.headline5?.color),
        ),
        linearGradient: LinearGradient(colors: [
          Theme.of(Get.context!).textTheme.headline5?.color ??
              Theme.of(Get.context!).colorScheme.onSurface,
          Theme.of(Get.context!).textTheme.headline5?.color ??
              Theme.of(Get.context!).colorScheme.onSurface,
        ]),
        onPressed: () => controller.clickOnCustomButton());
  }

  Widget buyNowOrCustomizeButton({required String buttonText}) {
    return CommonWidgets.myOutlinedButton(
        height: 42.px,
        margin: EdgeInsets.zero,
        radius: 5.px,
        text: Text(
          buttonText,
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 14.px),
        ),
        onPressed: () => buttonText == 'Customize'
            ? controller.clickOnCustomizeButton()
            : buttonText == 'Add to Outfit'
                ? controller.clickOnAddToOutfitButton()
                : controller.clickOnBuyNowButton());
  }

  Widget productAndSellerDescription() {
    return Obx(() {
      print(controller.productDescription.value);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.productDescription.value.isNotEmpty)
            SizedBox(height: 8.px),
          if (controller.productDescription.value.isNotEmpty)
            productAndSellerDescriptionTextView(text: "Product Description"),
          if (controller.productDescription.value.isNotEmpty)
            removeHtmlTagsProductAndSellerDescription(
              string: controller.productDescription.value,
            ),
          if (controller.sellerDescription.value.isNotEmpty)
            SizedBox(height: 8.px),
          if (controller.sellerDescription.value.isNotEmpty)
            productAndSellerDescriptionTextView(text: "Seller Description"),
          if (controller.sellerDescription.value.isNotEmpty)
            SizedBox(height: 2.px),
          if (controller.sellerDescription.value.isNotEmpty)
            removeHtmlTagsProductAndSellerDescription(
              string: controller.sellerDescription.value,
            ),
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

  Widget descriptionTextView({required String text}) => Text(
        Bidi.stripHtmlIfNeeded(text).trim(),
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
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
            fontWeight: FontWeight.w600,
            color: Theme.of(Get.context!).textTheme.subtitle2?.color),
      },
    );
  }

  Widget reviewsAndRatings({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.bestReview.value != null)
          productAndSellerDescriptionTextView(text: 'Reviews & Ratings:'),
        if ((controller.reviewList.value != null &&
                controller.reviewList.value!.isNotEmpty) &&
            controller.reviewList.value!.length > 1)
          SizedBox(height: 4.px),
        Row(
          children: [
            if ((controller.productDetail.value?.totalRating != null &&
                    controller.productDetail.value!.totalRating!.isNotEmpty) &&
                controller.productDetail.value?.totalRating != "0.0")
              Text(
                "${double.parse(controller.productDetail.value!.totalRating.toString()).toStringAsFixed(1).toString()}/5",
                style: Theme.of(Get.context!)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 14.px),
              ),
            if (controller.productDetail.value?.totalRating != null &&
                controller.productDetail.value?.totalRating != "0.0")
              SizedBox(width: 10.px),
            if (controller.productDetail.value?.totalReview != null &&
                controller.productDetail.value?.totalReview != "0")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  overAllRatingTextView(),
                  Text(
                    "${controller.productDetail.value?.totalReview} Ratings",
                    maxLines: 1,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .caption
                        ?.copyWith(fontSize: 10.px),
                  ),
                ],
              ),
          ],
        ),
        if (controller.bestReview.value != null) SizedBox(height: 4.px),
        if (controller.bestReview.value != null)
          CommonWidgets.profileMenuDash(),
        if (controller.bestReview.value != null) SizedBox(height: 4.px),
        if (controller.bestReview.value != null) bestReviewView(),
        if (controller.bestReview.value != null) SizedBox(height: 4.px),
        if (controller.bestReview.value != null)
          CommonWidgets.profileMenuDash(),
        if (controller.bestReview.value != null) SizedBox(height: 4.px),
        if ((controller.reviewList.value != null &&
                controller.reviewList.value!.isNotEmpty) &&
            controller.reviewList.value!.length > 1)
          viewAllReviewsButtonView(context: context),
      ],
    );
  }

  Widget bestReviewView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((controller.bestReview.value?.rating != null &&
                controller.bestReview.value!.rating!.isNotEmpty) &&
            (controller.bestReview.value?.rating != "0" &&
                controller.bestReview.value?.rating != "0.0"))
          Row(
            children: [
              RatingBar.builder(
                initialRating:
                    double.parse(controller.bestReview.value!.rating!),
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
              )
            ],
          ),
        SizedBox(height: 1.4.h),
        if (controller.bestReview.value?.review != null &&
            controller.bestReview.value!.review!.isNotEmpty)
          bestReviewDescriptionText(),
        if (controller.bestReview.value?.review != null &&
            controller.bestReview.value!.review!.isNotEmpty)
          SizedBox(height: 1.h),
        if (controller.bestReview.value?.reviewFile != null &&
            controller.bestReview.value!.reviewFile!.isNotEmpty)
          customerReviewImagesList(),
        if (controller.bestReview.value?.reviewFile != null &&
            controller.bestReview.value!.reviewFile!.isNotEmpty)
          SizedBox(height: 1.h),
        if (controller.bestReview.value?.customerName != null &&
            controller.bestReview.value!.customerName!.isNotEmpty)
          bestReviewCustomerNameText(),
      ],
    );
  }

  Widget starIcon() {
    return Image.asset(
      "assets/star.png",
    );
  }

  Widget bestReviewDescriptionText() => Text(
        "${controller.bestReview.value!.review}",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget customerReviewImagesList() {
    return Row(
      children: [
        Image.network(
          CommonMethods.imageUrl(
            url: controller.bestReview.value!.reviewFile.toString(),
          ),
        ),
      ],
    );
  }

  Widget bestReviewCustomerNameText() => Text(
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
        "${controller.bestReview.value?.customerName} ${controller.dateTime?.day ?? ""}-${controller.dateTime?.month ?? ""}-${controller.dateTime?.year ?? ""}",
      );

  Widget viewAllReviewsButtonView({required BuildContext context}) => InkWell(
        borderRadius: BorderRadius.circular(4.px),
        onTap: () => controller.clickOnViewAllReviews(context: context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.px, vertical: 4.px),
          child: Text(
            "View All ${controller.reviewList.value!.length} Reviews",
            style: Theme.of(Get.context!)
                .textTheme
                .subtitle1
                ?.copyWith(fontSize: 14.px),
          ),
        ),
      );

  Widget overAllRatingTextView() => Text(
        "Overall Ratings",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget outOfStockTextView({String? value}) => Text(
        "Item Out of stock",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 14.px, color: MyColorsDark().error),
      );

  Widget relatedProductsList() {
    return SizedBox(
      height: 36.h,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentProductsList?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: InkWell(
                  onTap: () => controller.clickOnRelatedProduct(
                      productId: controller.recentProductsList![index].productId
                          .toString()),
                  child: Container(
                    width: 40.w,
                    decoration: BoxDecoration(
                        color:
                            Theme.of(Get.context!).brightness == Brightness.dark
                                ? MyColorsLight().secondary.withOpacity(0.15)
                                : MyColorsDark().secondary.withOpacity(0.03),
                        border: Border.all(
                          width: .5,
                          color: Theme.of(Get.context!).brightness ==
                                  Brightness.dark
                              ? MyColorsLight().secondary.withOpacity(0.3)
                              : MyColorsDark().secondary.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(4.px)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (controller.recentProductsList![index]
                                        .thumbnailImage !=
                                    null &&
                                controller.recentProductsList![index]
                                    .thumbnailImage!.isNotEmpty)
                              relatedProductImageView(index: index),
                            SizedBox(height: 8.px),
                            if (controller
                                        .recentProductsList![index].brandName !=
                                    null &&
                                controller.recentProductsList![index].brandName!
                                    .isNotEmpty)
                              relatedProductBrandNameTextView(index: index),
                            SizedBox(height: .5.h),
                            if (controller.recentProductsList![index]
                                        .productName !=
                                    null &&
                                controller.recentProductsList![index]
                                    .productName!.isNotEmpty)
                              relatedProductNameTextView(index: index),
                            SizedBox(height: .6.h),
                            relatedProductPriceView(index: index),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget relatedProductImageView({required int index}) =>
      controller.recentProductsList![index].thumbnailImage != null &&
              controller.recentProductsList![index].thumbnailImage
                  .toString()
                  .isNotEmpty
          ? Image.network(
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CommonWidgets.commonShimmerViewForImage();
              },
              CommonMethods.imageUrl(
                  url: controller.recentProductsList![index].thumbnailImage
                      .toString()),
              fit: BoxFit.fill,
              height: 150.px,
              errorBuilder: (context, error, stackTrace) =>
                  CommonWidgets.defaultImage(),
            )
          : CommonWidgets.progressBarView();

  Widget relatedProductBrandNameTextView({required int index}) => Text(
        controller.recentProductsList![index].brandName.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget relatedProductNameTextView({required int index}) =>
      Text(controller.recentProductsList![index].productName.toString(),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(Get.context!).textTheme.headline3);

  Widget relatedProductPriceTextView(
          {required int index, required String text}) =>
      GradientText(
        '$curr$text',
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(overflow: TextOverflow.ellipsis),
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget relatedProductPriceView({required int index}) {
    if ((controller.recentProductsList![index].isOffer != null &&
        controller.recentProductsList![index].isOffer != 0)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.recentProductsList![index].offerPrice != null &&
              controller.recentProductsList![index].offerPrice != 0)
            Flexible(
              flex: 2,
              child: relatedProductPriceTextView(
                  index: index,
                  text: controller.recentProductsList![index].offerPrice
                      .toString()),
            ),
          SizedBox(width: .5.w),
          if (controller.recentProductsList![index].productPrice != null &&
              controller.recentProductsList![index].productPrice != 0)
            Flexible(
              child: relatedProductOfferPriceTextView(index: index),
            ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.recentProductsList![index].productPrice != null &&
              controller.recentProductsList![index].productPrice != 0)
            Flexible(
              flex: 2,
              child: relatedProductPriceTextView(
                  index: index,
                  text: controller.recentProductsList![index].productPrice
                      .toString()),
            ),
        ],
      );
    }
  }

  Widget relatedProductOfferPriceTextView({required int index}) => Text(
        "$curr${controller.recentProductsList![index].productPrice.toString()}",
        maxLines: 1,
        style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
            fontSize: 8.px,
            overflow: TextOverflow.ellipsis,
            decoration: TextDecoration.lineThrough),
        overflow: TextOverflow.ellipsis,
      );
}
*/
