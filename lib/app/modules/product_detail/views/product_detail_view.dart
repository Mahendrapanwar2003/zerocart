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
import '../controllers/product_detail_controller.dart';

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
        body: Obx(() => AbsorbPointer(
              absorbing: controller.absorbing.value,
              child: Obx(
                () {
                  if (CommonMethods.isConnect.value) {
                    if (controller.getProductDetailsModel.value != null) {
                      if ((controller.productDetail.value != null &&
                              controller.initialIndexOfInventoryArray.value !=
                                  -1) &&
                          (controller.listOfInventoryArr.value != null &&
                              controller
                                  .listOfInventoryArr.value!.isNotEmpty)) {
                        return ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              //CommonWidgets.mySizeBox(height: 18.h),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  bannerImageView(context: context),
                                  //addToWishListHeartIconView(context: context),
                                  //backButtonView(context),
                                ],
                              ),
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
                                                          child:
                                                              addToCartButton(
                                                                  context:
                                                                      context)),
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
                                                          child:
                                                              buyNowOrCustomizeButton(
                                                                  buttonText: controller
                                                                              .productDetail
                                                                              .value!
                                                                              .vendorType
                                                                              .toString() ==
                                                                          'Tailor'
                                                                      ? 'Customize'
                                                                      : controller
                                                                              .isViewToOutfitRoomVisible
                                                                              .value
                                                                          ? 'View Outfit'
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
                                      ? (controller.recentProductsList !=
                                                  null &&
                                              controller.recentProductsList!
                                                  .isNotEmpty)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Zconstant.margin),
                                                  child:
                                                      youMayAlsoLikeTextView(),
                                                ),
                                                SizedBox(height: 1.h),
                                                relatedProductsList(),
                                              ],
                                            )
                                          : CommonWidgets.noDataTextView(
                                              text: '')
                                      : controller
                                              .getProductDetailRecentApiValue
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
            )),
      ),
    );
  }

  Widget backButtonView(BuildContext context) {
    return Positioned(
      top: 10.px,
      left: 15.px,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => controller.clickOnBackButton(),
        child: Image.asset(
          "assets/back_button.png",
          color: Theme.of(Get.context!).textTheme.subtitle1?.color,
        ),
      ),
    );
  }

  Widget addToWishListHeartIconView({required BuildContext context}) {
    return Obx(() {
      if (controller.isClickOnAddToWishList.value) {
        return IconButton(
            onPressed: () => controller.clickOnRemoveWishListIconButton(),
            icon: const Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            ));
      } else {
        return IconButton(
            onPressed: () =>
                controller.clickOnWishListIconButton(context: context),
            icon: const Icon(
              Icons.favorite_border,
            ));
      }
    });
  }

  Widget bannerImageView({required BuildContext context}) {
    return Obx(() {
      print("${controller.isClickedColorOrSize.value}");
      if (controller.bannerImagesList.isNotEmpty) {
        return Stack(
          children: [
            InkWell(
              onTap: () => controller.clickOnBannerImage(context: context),
              child: CarouselSlider(
                items: controller.bannerImagesList
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
                    aspectRatio: 1.7,
                    onPageChanged: (index, reason) {
                      controller.currentIndexOfDotIndicator.value = index;
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 25.h,
              ),
              child: Center(child: customDotIndicatorList()),
            )
          ],
        );
      } else {
        return AspectRatio(
          aspectRatio: 1.7,
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
        itemCount: controller.bannerImagesList.length,
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
          if (inventoryArr.colorCode == null &&
              inventoryArr.colorCode!.isEmpty) {
            return const SizedBox();
          }
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
                  if (controller.variant.value?.isCustom.toString() == '1')
                    SizedBox(width: 4.px),
                if (controller.variant.value?.isCustom.toString() == '1')
                  customButton(buttonText: 'Custom')
                /* if (controller.isVariant.value == "1")
                  if (controller.productDetail.value!.vendorType.toString() ==
                      'Tailor')
                    SizedBox(width: 4.px),
                if (controller.productDetail.value!.vendorType.toString() ==
                    'Tailor')
                  customButton(buttonText: 'Custom')*/
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
    if (controller.isVariant.value == "1" && controller.isColor.value == "0") {
      if (controller.listOfInventoryArr.value != null &&
          controller.listOfInventoryArr.value!.isNotEmpty) {
        return MyListView(
            listOfData: (index) {
              return Obx(
                () {
                  InventoryArr inventoryArr =
                      controller.listOfInventoryArr.value![index];
                  if (inventoryArr.variantAbbreviation == null &&
                      inventoryArr.variantAbbreviation!.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.px),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4.px),
                        onTap: () => controller.clickOnSizeButton(index: index),
                        child: index == controller.isClickOnSize.value
                            ? selectedSizeView(
                                index: index,
                                selectedSize: inventoryArr.variantAbbreviation!,
                              )
                            : unselectedSizeView(
                                index: index,
                                unselectedSize:
                                    inventoryArr.variantAbbreviation!),
                      ),
                    );
                  }
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
    } else {
      if (controller.listOfVariant.value != null &&
          controller.listOfVariant.value!.isNotEmpty) {
        return MyListView(
            listOfData: (index) {
              return Obx(
                () {
                  VarientList variant = controller.listOfVariant.value![index];
                  if (variant.variantAbbreviation == null &&
                      variant.variantAbbreviation!.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.px),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5.px),
                        onTap: () => controller.clickOnSizeButton(index: index),
                        child: index == controller.isClickOnSize.value
                            ? selectedSizeView(
                                index: index,
                                selectedSize: variant.variantAbbreviation!,
                              )
                            : unselectedSizeView(
                                index: index,
                                unselectedSize: variant.variantAbbreviation!),
                      ),
                    );
                  }
                },
              );
            },
            physics: const ClampingScrollPhysics(),
            itemCount: controller.listOfVariant.value!.length,
            shrinkWrap: true,
            isVertical: false);
      } else {
        return const SizedBox();
      }
    }
  }

  Widget selectedSizeView({required int index, required String selectedSize}) =>
      productSizeView(
        text: selectedSize,
        color: Theme.of(Get.context!).textTheme.subtitle1!.color!,
      );

  Widget unselectedSizeView(
          {required int index, required String unselectedSize}) =>
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
            gradient: controller.addToCartButtonStateId.value !=
                    AddToCartButtonStateId.done
                ? CommonWidgets.commonLinearGradientView()
                : null,
          ),
          child: controller.isViewToCartVisible.value
              ? addAndViewToCartButton(
                  context: context, buttonText: "View Cart")
              : /*AddToCartButton(
                trolley: Image.asset(
                  'assets/shopping_cart.png',
                  width: 24,
                  height: 24,
                  color: MyColorsLight().secondary,
                ),
                streetLineColor: MyColorsLight().secondary,
                text: Text(
                  'Add To Cart',
                  textAlign: TextAlign.center,
                  style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
                      fontSize: 14.px, color: MyColorsLight().secondary),
                  maxLines: 1,
                ),
                onPressed: (id) =>
                    controller.clickOnAddToCartButton(context: context, id: id),
                stateId: controller.addToCartButtonStateId.value!,
                check: Icon(Icons.check, color: MyColorsLight().secondary),
              ),*/
              addAndViewToCartButton(
                  context: context, buttonText: 'Add To Cart'));
    });
  }

  Widget addAndViewToCartButton(
      {required BuildContext context, required String buttonText}) {
    return CommonWidgets.myElevatedButton(
      height: 42.px,
      margin: EdgeInsets.zero,
      text: Obx(() {
        controller.count.value;
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
              : buttonText == 'View Outfit'
                  ? controller.clickOnViewOutfitButton()
                  : controller.clickOnBuyNowButton(),
    );
  }

  // Widget addToWishlistButton({required BuildContext context}) {
  //   return Obx(() {
  //     if (!controller.isClickOnAddToWishList.value) {
  //       return CommonWidgets.myOutlinedButton(
  //           height: 42.px,
  //           width: 86.w,
  //           radius: 5.px,
  //           text: Text(
  //             "Add To WishList",
  //             style: Theme.of(Get.context!)
  //                 .textTheme
  //                 .subtitle1
  //                 ?.copyWith(fontSize: 14.px),
  //           ),
  //           onPressed: () =>
  //               controller.clickOnWishListButton(context: context));
  //     } else {
  //       return CommonWidgets.myOutlinedButton(
  //           height: 42.px,
  //           width: 128.px,
  //           radius: 5.px,
  //           text: CommonWidgets.buttonProgressBarView(),
  //           // ignore: avoid_returning_null_for_void
  //           onPressed: () => null);
  //     }
  //   });
  // }

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

  Widget ratingsTextView() => Text(
        "ratings",
        maxLines: 1,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget rateButtonView() => CommonWidgets.myOutlinedButton(
      text: Text(
        "RATE",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      ),
      onPressed: () => controller.clickOnRateButton(),
      height: 28.px,
      width: 23.w,
      radius: 3.px);

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
                            /* if (controller.recentProductsList![index].isColor != null &&
                                controller.recentProductsList![index].isColor != "0")
                              relatedProductColorListView(index: index),*/
                            // SizedBox(height: 1.4.h),
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

/*
  Widget relatedProductColorListView({required int index}) =>
      controller.recentProductsList![index].colorsList != null &&
              controller.recentProductsList![index].colorsList!.isNotEmpty
          ? SizedBox(
              height: 25.px,
              child: MyListView(
                listOfData: (colorIndex) {
                  String? color = controller
                      .recentProductsList![index].colorsList![colorIndex].colorCode
                      .toString();
                  String replaceColor = color.replaceAll("#", "0xff");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.px,
                        width: 15.px,
                        child: Container(
                          height: 30.px,
                          width: 15.px,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(
                              int.parse(replaceColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w)
                    ],
                  );
                },
                horizontalPadding: 4.w,
                physics: const ScrollPhysics(),
                itemCount: controller.recentProductsList![index].colorsList!.length,
                shrinkWrap: true,
                isVertical: false,
              ),
            )
          : const SizedBox();
*/

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
          /* SizedBox(width: .5.w),
          if (controller.recentProductsList![index].percentageDis != null &&
              controller.recentProductsList![index].percentageDis!.isNotEmpty)
            Flexible(
              child: relatedProductOfferPercentsTextView(index: index),
            ),*/
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

  Widget outOfStockTextView({String? value}) => Text(
        "Out of stock",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 14.px, color: MyColorsDark().error),
      );

/* Widget relatedProductOfferPercentsTextView({required int index}) => Text(
        ("(${controller.recentProductsList![index].percentageDis.toString()}% Off)"),
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px, overflow: TextOverflow.ellipsis),
      );*/

/* Widget relatedProductImageView({required int index}) =>
      controller.products![index].thumbnailImage != null &&
              controller.products![index].thumbnailImage.toString().isNotEmpty
          ? Image.network(CommonMethods.imageUrl(url: controller.products![index].thumbnailImage.toString()),
              fit: BoxFit.fill,
              height: 150.px,
              errorBuilder: (context, error, stackTrace) =>
                  CommonWidgets.defaultImage(),
            )
          : CommonWidgets.progressBarView();

  Widget relatedProductColorListView({required int index}) =>
      controller.products![index].colorsList != null &&
              controller.products![index].colorsList!.isNotEmpty
          ? SizedBox(
              height: 25.px,
              child: MyListView(
                listOfData: (colorIndex) {
                  String? color = controller
                      .products![index].colorsList![colorIndex].colorCode
                      .toString();
                  String replaceColor = color.replaceAll("#", "0xff");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.px,
                        width: 15.px,
                        child: Container(
                          height: 30.px,
                          width: 15.px,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(
                              int.parse(replaceColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w)
                    ],
                  );
                },
                horizontalPadding: 4.w,
                physics: const ScrollPhysics(),
                itemCount: controller.products![index].colorsList!.length,
                shrinkWrap: true,
                isVertical: false,
              ),
            )
          : const SizedBox();

  Widget relatedProductBrandNameTextView({required int index}) => Text(
        controller.products![index].brandName.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget relatedProductNameTextView({required int index}) =>
      Text(controller.products![index].productName.toString(),
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
    if ((controller.products![index].isOffer != null &&
            controller.products![index].isOffer!.isNotEmpty) &&
        controller.products![index].isOffer != "0") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.products![index].offerPrice != null &&
              controller.products![index].offerPrice!.isNotEmpty)
            Flexible(
              flex: 2,
              child: relatedProductPriceTextView(
                  index: index,
                  text: controller.products![index].offerPrice.toString()),
            ),
          SizedBox(width: .5.w),
          if (controller.products![index].productPrice != null &&
              controller.products![index].productPrice!.isNotEmpty)
            Flexible(
              child: relatedProductOfferPriceTextView(index: index),
            ),
          SizedBox(width: .5.w),
          if (controller.products![index].percentageDis != null &&
              controller.products![index].percentageDis!.isNotEmpty)
            Flexible(
              child: relatedProductOfferPercentsTextView(index: index),
            ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.products![index].productPrice != null &&
              controller.products![index].productPrice!.isNotEmpty)
            Flexible(
              flex: 2,
              child: relatedProductPriceTextView(
                  index: index,
                  text: controller.products![index].productPrice.toString()),
            ),
        ],
      );
    }
  }

  Widget relatedProductOfferPriceTextView({required int index}) => Text(
        "$curr${controller.products![index].productPrice.toString()}",
        maxLines: 1,
        style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
            fontSize: 8.px,
            overflow: TextOverflow.ellipsis,
            decoration: TextDecoration.lineThrough),
        overflow: TextOverflow.ellipsis,
      );

  Widget relatedProductOfferPercentsTextView({required int index}) => Text(
        ("(${controller.products![index].percentageDis.toString()}% Off)"),
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px, overflow: TextOverflow.ellipsis),
      );
*/
}

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
import 'package:zerocart/app/modules/product_detail/controllers/product_detail_controller.dart';
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
        body: Obx(() => AbsorbPointer(
              absorbing: controller.absorbing.value,
              child: Obx(
                () {
                  if (CommonMethods.isConnect.value) {
                    if (controller.getProductDetailsModel.value != null) {
                      if (controller.productDetail.value != null &&
                          (controller.listOfInventoryArr.value != null &&
                              controller
                                  .listOfInventoryArr.value!.isNotEmpty)) {
                        return ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  bannerImageView(context: context),
                                  //addToWishListHeartIconView(context: context),
                                  //backButtonView(context),
                                ],
                              ),
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
                                                          child:
                                                              addToCartButton(
                                                                  context:
                                                                      context)),
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
                                      ? (controller.recentProductsList !=
                                                  null &&
                                              controller.recentProductsList!
                                                  .isNotEmpty)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Zconstant.margin),
                                                  child:
                                                      youMayAlsoLikeTextView(),
                                                ),
                                                SizedBox(height: 1.h),
                                                relatedProductsList(),
                                              ],
                                            )
                                          : CommonWidgets.noDataTextView(
                                              text: '')
                                      : controller
                                              .getProductDetailRecentApiValue
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
            )),
      ),
    );
  }

  Widget backButtonView(BuildContext context) {
    return Positioned(
      top: 10.px,
      left: 15.px,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => controller.clickOnBackButton(),
        child: Image.asset(
          "assets/back_button.png",
          color: Theme.of(Get.context!).textTheme.subtitle1?.color,
        ),
      ),
    );
  }

  Widget addToWishListHeartIconView({required BuildContext context}) {
    return Obx(() {
      if (controller.isClickOnAddToWishList.value) {
        return IconButton(
            onPressed: () => controller.clickOnRemoveWishListIconButton(),
            icon: const Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            ));
      } else {
        return IconButton(
            onPressed: () =>
                controller.clickOnWishListIconButton(context: context),
            icon: const Icon(
              Icons.favorite_border,
            ));
      }
    });
  }

  Widget bannerImageView({required BuildContext context}) {
    return Obx(() {
      print("${controller.isClickedColorOrSize.value}");
      if (controller.bannerImagesList.isNotEmpty) {
        return Stack(
          children: [
            InkWell(
              onTap: () => controller.clickOnBannerImage(context: context),
              child: CarouselSlider(
                items: controller.bannerImagesList
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
                    aspectRatio: 1.7,
                    onPageChanged: (index, reason) {
                      controller.currentIndexOfDotIndicator.value = index;
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 25.h,
              ),
              child: Center(child: customDotIndicatorList()),
            )
          ],
        );
      } else {
        return AspectRatio(
          aspectRatio: 1.7,
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
        itemCount: controller.bannerImagesList.length,
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
              if (controller.isColor.value == "1")
                colorsView()
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
                */
/* if (controller.isVariant.value == "1")
                  if (controller.productDetail.value!.vendorType.toString() ==
                      'Tailor')
                    SizedBox(width: 4.px),
                if (controller.productDetail.value!.vendorType.toString() ==
                    'Tailor')
                  customButton(buttonText: 'Custom')*/ /*

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
    */
/* if (controller.isVariant.value == "1" && controller.isColor.value == "0") {*/ /*

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
                  print("sizes::::inventoryArr${sizes}");
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
    //}
    */
/*else {
      if (controller.listOfVariant.value != null &&
          controller.listOfVariant.value!.isNotEmpty) {
        return MyListView(
            listOfData: (index) {
              return Obx(
                () {
                  VarientList variant = controller.listOfVariant.value![index];
                  if (variant.variantAbbreviation == null &&
                      variant.variantAbbreviation!.isEmpty) {
                    return const SizedBox();
                  } else {
                    String listOfSize = variant.variantAbbreviation!;
                    List<dynamic> sizes = json.decode(listOfSize);
                    print("sizes::::variant${sizes}");
                    return MyListView(
                        listOfData: (ind) {
                          print("indexxxx::::::::::$ind::::::$index")
                          Future.delayed(Duration.zero, () async {
                            controller.sellPrice.value =
                            sizes[ind]['sellPrice'];
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
                },
              );
            },
            physics: const ClampingScrollPhysics(),
            itemCount: controller.listOfVariant.value!.length,
            shrinkWrap: true,
            isVertical: false);
      } else {
        return const SizedBox();
      }
    }*/ /*

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
            gradient: controller.addToCartButtonStateId.value !=
                    AddToCartButtonStateId.done
                ? CommonWidgets.commonLinearGradientView()
                : null,
          ),
          child: controller.isViewToCartVisible.value
              ? addAndViewToCartButton(
                  context: context, buttonText: "View Cart")
              : */
/*AddToCartButton(
                trolley: Image.asset(
                  'assets/shopping_cart.png',
                  width: 24,
                  height: 24,
                  color: MyColorsLight().secondary,
                ),
                streetLineColor: MyColorsLight().secondary,
                text: Text(
                  'Add To Cart',
                  textAlign: TextAlign.center,
                  style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
                      fontSize: 14.px, color: MyColorsLight().secondary),
                  maxLines: 1,
                ),
                onPressed: (id) =>
                    controller.clickOnAddToCartButton(context: context, id: id),
                stateId: controller.addToCartButtonStateId.value!,
                check: Icon(Icons.check, color: MyColorsLight().secondary),
              ),*/ /*

              addAndViewToCartButton(
                  context: context, buttonText: 'Add To Cart'));
    });
  }

  Widget addAndViewToCartButton(
      {required BuildContext context, required String buttonText}) {
    return CommonWidgets.myElevatedButton(
      height: 42.px,
      margin: EdgeInsets.zero,
      text: Obx(() {
        controller.count.value;
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

  // Widget addToWishlistButton({required BuildContext context}) {
  //   return Obx(() {
  //     if (!controller.isClickOnAddToWishList.value) {
  //       return CommonWidgets.myOutlinedButton(
  //           height: 42.px,
  //           width: 86.w,
  //           radius: 5.px,
  //           text: Text(
  //             "Add To WishList",
  //             style: Theme.of(Get.context!)
  //                 .textTheme
  //                 .subtitle1
  //                 ?.copyWith(fontSize: 14.px),
  //           ),
  //           onPressed: () =>
  //               controller.clickOnWishListButton(context: context));
  //     } else {
  //       return CommonWidgets.myOutlinedButton(
  //           height: 42.px,
  //           width: 128.px,
  //           radius: 5.px,
  //           text: CommonWidgets.buttonProgressBarView(),
  //           // ignore: avoid_returning_null_for_void
  //           onPressed: () => null);
  //     }
  //   });
  // }

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

  Widget ratingsTextView() => Text(
        "ratings",
        maxLines: 1,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget rateButtonView() => CommonWidgets.myOutlinedButton(
      text: Text(
        "RATE",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      ),
      onPressed: () => controller.clickOnRateButton(),
      height: 28.px,
      width: 23.w,
      radius: 3.px);

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
                            */
/* if (controller.recentProductsList![index].isColor != null &&
                                controller.recentProductsList![index].isColor != "0")
                              relatedProductColorListView(index: index),*/ /*

                            // SizedBox(height: 1.4.h),
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

*/
/*
  Widget relatedProductColorListView({required int index}) =>
      controller.recentProductsList![index].colorsList != null &&
              controller.recentProductsList![index].colorsList!.isNotEmpty
          ? SizedBox(
              height: 25.px,
              child: MyListView(
                listOfData: (colorIndex) {
                  String? color = controller
                      .recentProductsList![index].colorsList![colorIndex].colorCode
                      .toString();
                  String replaceColor = color.replaceAll("#", "0xff");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.px,
                        width: 15.px,
                        child: Container(
                          height: 30.px,
                          width: 15.px,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(
                              int.parse(replaceColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w)
                    ],
                  );
                },
                horizontalPadding: 4.w,
                physics: const ScrollPhysics(),
                itemCount: controller.recentProductsList![index].colorsList!.length,
                shrinkWrap: true,
                isVertical: false,
              ),
            )
          : const SizedBox();
*/ /*


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
          */
/* SizedBox(width: .5.w),
          if (controller.recentProductsList![index].percentageDis != null &&
              controller.recentProductsList![index].percentageDis!.isNotEmpty)
            Flexible(
              child: relatedProductOfferPercentsTextView(index: index),
            ),*/ /*

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

  Widget outOfStockTextView({String? value}) => Text(
        "Out of stock",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 14.px, color: MyColorsDark().error),
      );

*/
/* Widget relatedProductOfferPercentsTextView({required int index}) => Text(
        ("(${controller.recentProductsList![index].percentageDis.toString()}% Off)"),
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px, overflow: TextOverflow.ellipsis),
      );*/ /*


*/
/* Widget relatedProductImageView({required int index}) =>
      controller.products![index].thumbnailImage != null &&
              controller.products![index].thumbnailImage.toString().isNotEmpty
          ? Image.network(CommonMethods.imageUrl(url: controller.products![index].thumbnailImage.toString()),
              fit: BoxFit.fill,
              height: 150.px,
              errorBuilder: (context, error, stackTrace) =>
                  CommonWidgets.defaultImage(),
            )
          : CommonWidgets.progressBarView();

  Widget relatedProductColorListView({required int index}) =>
      controller.products![index].colorsList != null &&
              controller.products![index].colorsList!.isNotEmpty
          ? SizedBox(
              height: 25.px,
              child: MyListView(
                listOfData: (colorIndex) {
                  String? color = controller
                      .products![index].colorsList![colorIndex].colorCode
                      .toString();
                  String replaceColor = color.replaceAll("#", "0xff");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.px,
                        width: 15.px,
                        child: Container(
                          height: 30.px,
                          width: 15.px,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(
                              int.parse(replaceColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w)
                    ],
                  );
                },
                horizontalPadding: 4.w,
                physics: const ScrollPhysics(),
                itemCount: controller.products![index].colorsList!.length,
                shrinkWrap: true,
                isVertical: false,
              ),
            )
          : const SizedBox();

  Widget relatedProductBrandNameTextView({required int index}) => Text(
        controller.products![index].brandName.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget relatedProductNameTextView({required int index}) =>
      Text(controller.products![index].productName.toString(),
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
    if ((controller.products![index].isOffer != null &&
            controller.products![index].isOffer!.isNotEmpty) &&
        controller.products![index].isOffer != "0") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.products![index].offerPrice != null &&
              controller.products![index].offerPrice!.isNotEmpty)
            Flexible(
              flex: 2,
              child: relatedProductPriceTextView(
                  index: index,
                  text: controller.products![index].offerPrice.toString()),
            ),
          SizedBox(width: .5.w),
          if (controller.products![index].productPrice != null &&
              controller.products![index].productPrice!.isNotEmpty)
            Flexible(
              child: relatedProductOfferPriceTextView(index: index),
            ),
          SizedBox(width: .5.w),
          if (controller.products![index].percentageDis != null &&
              controller.products![index].percentageDis!.isNotEmpty)
            Flexible(
              child: relatedProductOfferPercentsTextView(index: index),
            ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.products![index].productPrice != null &&
              controller.products![index].productPrice!.isNotEmpty)
            Flexible(
              flex: 2,
              child: relatedProductPriceTextView(
                  index: index,
                  text: controller.products![index].productPrice.toString()),
            ),
        ],
      );
    }
  }

  Widget relatedProductOfferPriceTextView({required int index}) => Text(
        "$curr${controller.products![index].productPrice.toString()}",
        maxLines: 1,
        style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
            fontSize: 8.px,
            overflow: TextOverflow.ellipsis,
            decoration: TextDecoration.lineThrough),
        overflow: TextOverflow.ellipsis,
      );

  Widget relatedProductOfferPercentsTextView({required int index}) => Text(
        ("(${controller.products![index].percentageDis.toString()}% Off)"),
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px, overflow: TextOverflow.ellipsis),
      );
*/ /*

}
*/
