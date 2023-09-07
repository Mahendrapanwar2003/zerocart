import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/model_progress_bar/model_progress_bar.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../controllers/buy_now_controller.dart';

class BuyNowView extends GetView<BuyNowController> {
  const BuyNowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: GestureDetector(
          onTap: () => MyCommonMethods.unFocsKeyBoard(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const MyCustomContainer().myAppBar(
              text: 'Buy Now',
              isIcon: true,
              backIconOnPressed: () => controller.clickOnBackButton(),
            ),
            body: Obx(
              () {
                controller.count.value;
                if (CommonMethods.isConnect.value) {
                  if (controller.getProductByInventoryApiModal != null &&
                      controller.responseCode == 200) {
                    if (controller.productDetail != null) {
                      return CommonWidgets.commonRefreshIndicator(
                        onRefresh: () => controller.onRefresh(),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.w, bottom: 10.px, right: 4.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (controller.addressDetail != null)
                                        deliverToTextView(),
                                      SizedBox(height: 4.px),
                                      if (controller.addressDetail != null)
                                        CommonWidgets.profileMenuDash(),
                                      SizedBox(height: 4.px),
                                      controller.addressDetail != null
                                          ? addressView(context: context)
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.5.h),
                                              child: addAddressButtonView(
                                                  context: context),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: itemDetailsView(context),
                                ),
                                Center(
                                  child: applyCouponView(context),
                                ),
                                SizedBox(height: 20.px),
                                //if (!controller.isCouponRange.value)
                                //couponRangeText(),
                                SizedBox(height: 10.px),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: CommonWidgets.profileMenuDash(),
                                ),
                                SizedBox(height: 27.px),
                                itemBillView(),
                                SizedBox(height: 35.px),
                                proceedToPaymentButton(context: context),
                              ],
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                          child: addAddressButtonView(context: context));
                    }
                  } else {
                    if (controller.responseCode == 0) {
                      return const SizedBox();
                    }
                    return CommonWidgets.commonSomethingWentWrongImage(
                      onRefresh: () => controller.onRefresh(),
                    );
                  }
                } else {
                  return CommonWidgets.commonNoInternetImage(
                    onRefresh: () => controller.onRefresh(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget deliverToTextView() {
    return Text(
      "Deliver to:",
      style:
          Theme.of(Get.context!).textTheme.headline6?.copyWith(fontSize: 12.px),
    );
  }

  Widget addressView({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              personNameTextView(value: controller.addressDetail?.name ?? ""),
              addressDetailView(),
            ],
          ),
        ),
        SizedBox(width: 5.px),
        changeAddressButtonView(context: context),
      ],
    );
  }

  Widget personNameTextView({required String value}) => Text(
        value,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget addressDetailView() => Text(
        "${controller.addressDetail?.houseNo}"
        " ${controller.addressDetail?.colony}"
        " ${controller.addressDetail?.city}"
        " ${controller.addressDetail?.state}"
        " ${controller.addressDetail?.pinCode}",
        style:
            Theme.of(Get.context!).textTheme.caption?.copyWith(fontSize: 12.px),
      );

  Widget changeAddressButtonView({required BuildContext context}) =>
      CommonWidgets.myOutlinedButton(
        height: 32.px,
        width: 20.w,
        onPressed: () =>
            controller.clickOnChangeAddressButton(context: context),
        radius: 5,
        text: Text(
          "Change",
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 14.px),
        ),
      );

  Widget addAddressButtonView({required BuildContext context}) =>
      CommonWidgets.myOutlinedButton(
          radius: 5.px,
          text: addAddressTextView(),
          onPressed: () => controller.clickOnAddAddressButton(context: context),
          height: 40.px,
          //width: 60.w
          margin: EdgeInsets.zero);

  Widget addAddressTextView() => Text(
        "ADD ADDRESS",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget itemDetailsView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.px),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? MyColorsLight().secondary
                    : MyColorsDark().secondary,
                width: 1.px,
              ),
            ),
            padding: EdgeInsets.all(3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.productDetail?.thumbnailImage != null &&
                          controller.productDetail!.thumbnailImage!.isNotEmpty)
                        itemImageView(
                            path:
                                controller.productDetail?.thumbnailImage ?? ""),
                    ],
                  ),
                ),
                SizedBox(width: 10.px),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.5.h),
                      if (controller.productDetail?.brandName != null &&
                          controller.productDetail?.productName != null)
                        itemDescriptionTextView(
                            value: "${controller.productDetail?.brandName} "
                                "${controller.productDetail?.productName}"),
                      SizedBox(height: 0.75.h),
                      itemPriceView(),
                      SizedBox(height: 0.75.h),
                      Row(
                        children: [
                          if (controller.productDetail?.colorName != null &&
                                  controller
                                      .productDetail!.colorName!.isNotEmpty ||
                              controller.productDetail!.colorCode!.isNotEmpty &&
                                  controller.productDetail!.colorCode != null)
                            itemColorTextView(
                                value: controller.productDetail?.colorName,
                                colorCode: int.parse(controller
                                    .productDetail!.colorCode
                                    .toString()
                                    .replaceAll("#", "0xff"))),
                          if (controller.productDetail?.colorName != null &&
                                  controller
                                      .productDetail!.colorName!.isNotEmpty ||
                              controller.productDetail!.colorCode!.isNotEmpty &&
                                  controller.productDetail!.colorCode != null)
                            SizedBox(width: 1.75.w),
                          if (controller.productDetail?.variantAbbreviation !=
                                  null &&
                              controller.productDetail!.variantAbbreviation!
                                  .isNotEmpty)
                            itemSizeTextView(
                                value: controller
                                    .productDetail?.variantAbbreviation),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          if (controller.productDetail?.availability != null)
                            subtractButtonView(),
                          if (controller.productDetail?.availability != null)
                            SizedBox(width: 2.w),
                          totalItemQuantityView(),
                          if (controller.productDetail?.availability != null)
                            SizedBox(width: 2.w),
                          if (controller.productDetail?.availability != null)
                            addButtonView(),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 2.h),
              ],
            ),
          ),
          // filledCheckedBox(index: index),
        ],
      ),
    );
  }

  Widget itemImageView({required String path}) => Container(
        height: 125.px,
        width: 30.w,
        padding: EdgeInsets.all(2.px),
        decoration: BoxDecoration(
            color: Theme.of(Get.context!).brightness == Brightness.dark
                ? MyColorsLight().secondary.withOpacity(0.15)
                : MyColorsDark().secondary.withOpacity(0.03),
            border: Border.all(
              width: .5,
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? MyColorsLight().secondary.withOpacity(0.3)
                  : MyColorsDark().secondary.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(4.px),
            image: DecorationImage(
                image: NetworkImage(CommonMethods.imageUrl(url: path)),
                fit: BoxFit.cover,
                alignment: Alignment.center)),
      );

  Widget itemDescriptionTextView({required String value}) => Row(
        children: [
          Expanded(
            child: Text(
              value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(Get.context!).textTheme.headline3,
            ),
          ),
        ],
      );

  Widget itemPriceView(/*{required int index}*/) {
    if (controller.productDetail?.isOffer != null &&
        controller.productDetail?.isOffer == "1") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (controller.productDetail?.offerPrice != null)
            itemPriceTextView(
                value: controller.productDetail?.offerPrice ?? ""),
          if (controller.productDetail?.offerPrice != null)
            SizedBox(height: 4.px),
          Row(
            children: [
              if (controller.productDetail?.sellPrice != null)
                Flexible(
                  child: itemOriginalPriceTextView(
                      value: controller.productDetail?.sellPrice ?? ""),
                ),
              SizedBox(height: 4.px),
              if (controller.productDetail?.percentageDis != null)
                Flexible(
                  child: itemHowManyPercentOffTextView(
                      value: controller.productDetail?.percentageDis ?? ""),
                )
            ],
          )
        ],
      );
    } else {
      print(
          "controller.productDetail?.sellPrice:::::::::::::::::::::::${controller.productDetail?.sellPrice}");
      return Row(
        children: [
          itemPriceTextView(value: controller.productDetail?.sellPrice ?? ""),
        ],
      );
    }
  }

  Widget itemPriceTextView({required String value}) {
    return GradientText(
      "Rs. $value",
      style: Theme.of(Get.context!).textTheme.subtitle1,
      gradient: CommonWidgets.commonLinearGradientView(),
    );
  }

  Widget itemOriginalPriceTextView({required String value}) => Text(
        value,
        maxLines: 1,
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px, decoration: TextDecoration.lineThrough),
      );

  Widget itemHowManyPercentOffTextView({required String value}) => Text(
        " ($value% Off)",
        maxLines: 1,
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px),
      );

  Widget itemColorTextView({required String? value, int? colorCode}) {
    return Row(
      children: [
        Text('Color: ',
            textAlign: TextAlign.center,
            style: Theme.of(Get.context!).textTheme.headline3),
        SizedBox(
          width: 0.2.w,
        ),
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          height: 20.px,
          width: 20.px,
          child: UnicornOutline(
            strokeWidth: 1.5.px,
            radius: 10.px,
            gradient: CommonWidgets.commonLinearGradientView(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.px, horizontal: 2.px),
              child: Container(
                height: 30.px,
                width: 15.px,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(colorCode!),
                ),
              ),
            ),
          ),
        ),

        /*  Container(
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).brightness == Brightness.dark
                ? MyColorsLight().secondary.withOpacity(0.15)
                : MyColorsDark().secondary.withOpacity(0.03),
            border: Border.all(
              width: .5,
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? MyColorsLight().secondary.withOpacity(0.3)
                  : MyColorsDark().secondary.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: (colorCode != null)
              ? Text(
                  "$value",
                  textAlign: TextAlign.center,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .headline3
                      ?.copyWith(color: Color(colorCode)),
                )
              : Text(
                  "$value",
                  textAlign: TextAlign.center,
                  style: Theme.of(Get.context!).textTheme.headline3,
                ),
        ),*/
      ],
    );
  }

  Widget itemSizeTextView({required String? value}) => Text(
        "Size-$value",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget totalItemQuantityView() => Container(
        height: 3.5.h,
        width: 44.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.px),
            gradient: CommonWidgets.commonLinearGradientView()),
        child: Center(child: itemQuantityCountTextView()),
      );

  Widget subtractButtonView() => elevatedButtonForItemList(
        onPressed: () => (controller.itemQuantity.value == 1)
            ? null
            : controller.clickOnDecreaseQuantityButton(),
        color: (controller.itemQuantity.value == 1)
            ? Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2)
            : Theme.of(Get.context!).colorScheme.onSurface,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: decreaseButtonView()),
      );

  Widget decreaseButtonView() => Icon(Icons.remove,
      color: (controller.itemQuantity.value == 1)
          ? Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2)
          : Theme.of(Get.context!).colorScheme.onSurface);

  Widget itemQuantityCountTextView() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.px),
        child: (controller.itemQuantity.value < 10)
            ? Text(
                "0${controller.itemQuantity.value}",
                style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
                    fontSize: 12.px, color: MyColorsLight().secondary),
                maxLines: 1,
              )
            : Text(
                "${controller.itemQuantity.value}",
                style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
                    fontSize: 12.px, color: MyColorsLight().secondary),
                maxLines: 1,
              ),
      );

  Widget addButtonView() => elevatedButtonForItemList(
      onPressed: () => (controller.itemQuantity.value <
              int.parse(controller.productDetail!.availability!))
          ? controller.clickOnIncreaseQuantityButton()
          : null,
      color: (controller.itemQuantity.value <
              int.parse(controller.productDetail!.availability!))
          ? Theme.of(Get.context!).colorScheme.onSurface
          : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
      child: increaseQuantityOfItemView());

  Widget increaseQuantityOfItemView() => Icon(
        Icons.add,
        color: (controller.itemQuantity.value <
                int.parse(controller.productDetail!.availability!))
            ? Theme.of(Get.context!).colorScheme.onSurface
            : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
        size: 22.px,
      );

  Widget elevatedButtonForItemList(
          {required VoidCallback onPressed,
          required Widget child,
          Color? color,
          double? height}) =>
      Container(
        height: height ?? 3.5.h,
        width: 32.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.px),
            /*gradient: CommonWidgets.commonLinearGradientView()*/
            border: Border.all(
                color: color ?? Theme.of(Get.context!).colorScheme.onSurface)),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.px),
              ),
              padding: EdgeInsets.zero),
          child: child,
        ),
      );

  Widget applyCouponView(BuildContext context) => Container(
        height: 42.px,
        width: 92.w,
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(Get.context!).colorScheme.onSurface),
          borderRadius: BorderRadius.circular(5.px),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: addCouponTextFieldView(),
            ),
            Obx(() {
              if (controller.isClickOnApplyCouponVisible.value) {
                return InkWell(
                  onTap: () => controller.isApplyCoupon.value
                      ? controller.clickOnApplyCouponButtonView()
                      : controller.clickOnRemoveCouponButtonView(
                          context: context),
                  borderRadius: BorderRadius.all(Radius.circular(4.px)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.px),
                      child: applyCouponButtonView(
                          context: context,
                          text: controller.isApplyCoupon.value
                              ? 'Apply Coupon'
                              : 'Remove Coupon'),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      );

  Widget addCouponTextFieldView() => TextFormField(
        style: Theme.of(Get.context!).textTheme.subtitle1,
        controller: controller.applyCouponController,
        readOnly: !controller.isApplyCoupon.value,
        onChanged: (value) {
          if (value.trim().isEmpty ||
              value.trim().replaceAll(" ", "").isEmpty) {
            controller.applyCouponController.text = "";
            controller.isClickOnApplyCouponVisible.value = false;
          } else {
            controller.isClickOnApplyCouponVisible.value = true;
          }
        },
        cursorColor: Theme.of(Get.context!).colorScheme.onSurface,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 5.px, bottom: 8.px),
          hintText: "Enter Coupon Code",
          hintStyle: Theme.of(Get.context!).textTheme.headline5,
        ),
      );

  Widget gradientText({required String text}) => GradientText(
        text,
        style: Theme.of(Get.context!).textTheme.subtitle1,
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget applyCouponButtonView(
          {required BuildContext context, required String text}) =>
      Obx(
        () {
          print(controller.count.value);
          return GradientText(
            text,
            style: Theme.of(Get.context!).textTheme.headline3,
            gradient: CommonWidgets.commonLinearGradientView(),
          );
        },
      );

  Widget itemBillView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          priceDetailsTextView(text: 'Price Details'),
          SizedBox(height: 5.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              priceTextView(text: 'Total Price'),
              priceTextView(text: "Rs. ${controller.sellPrice.value}")
            ],
          ),
          SizedBox(height: 2.px),
          if (controller.discountPrice.value != 0.0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gradientText(text: 'Discount'),
                gradientText(text: 'Rs. ${controller.discountPrice.value}'),
              ],
            ),
          if (controller.discountPrice.value != 0.0) SizedBox(height: 2.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              priceTextView(text: 'Delivery'),
              controller.deliveryPrice.value != 0.0
                  ? priceTextView(text: 'Rs. ${controller.deliveryPrice.value}')
                  : priceTextView(text: 'Free Delivery'),
            ],
          ),
          SizedBox(height: 3.px),
          CommonWidgets.profileMenuDash(),
          SizedBox(height: 3.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              priceDetailsTextView(text: 'Total'),
              priceDetailsTextView(text: 'Rs. ${controller.totalPrice.value}'),
            ],
          ),
          SizedBox(height: 10.px),
          savingMoneyText(),
        ],
      ),
    );
  }

  Widget priceDetailsTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
              fontSize: 14.px,
            ),
      );

  Widget priceTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget proceedToPaymentButton({required BuildContext context}) =>
      CommonWidgets.myElevatedButton(
          text: Text('Proceed To Payment',
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: MyColorsLight().secondary)),
          onPressed: () =>
              controller.clickOnProceedToPaymentButton(context: context),
          height: 42.px,
          width: 92.w,
          borderRadius: 5.px);

  Widget savingMoneyText() => (controller.discountPrice.value != 0.0)
      ? gradientText(
          text: 'Your Saving ${controller.discountPrice} On This Order')
      : const SizedBox();

  Widget couponRangeText() => (controller.discountPrice.value == 0.0)
      ? gradientText(text: 'Total price should be between coupon range')
      : const SizedBox();
}
