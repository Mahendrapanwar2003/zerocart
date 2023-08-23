import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/my_colors/my_colors.dart';

import '../controllers/buy_now_controller.dart';

class BuyNowView extends GetView<BuyNowController> {
  const BuyNowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AbsorbPointer(
          absorbing: controller.absorbing.value,
          child: GestureDetector(
            onTap: () => MyCommonMethods.unFocsKeyBoard(),
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: const MyCustomContainer().myAppBar(
                text: 'Buy Now',
                isIcon: true,
                backIconOnPressed: () => controller.clickOnBackButton(),
              ),
              body: Obx(() {
                if (controller.getProductByInventoryApiModal.value != null) {
                  if (controller.productDetail.value != null) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, bottom: 10.px, right: 4.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (controller.addressDetail.value != null)
                                    deliverToTextView(),
                                  SizedBox(height: 4.px),
                                  if (controller.addressDetail.value != null)
                                    CommonWidgets.profileMenuDash(),
                                  SizedBox(height: 4.px),
                                  controller.addressDetail.value != null
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
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: itemDetailsView(context),
                            ),
                            Center(
                              child: applyCouponView(context),
                            ),
                            SizedBox(height: 27.px),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                    );
                  } else {
                    return CommonWidgets.noDataTextView();
                  }
                } else {
                  return CommonWidgets.progressBarView();
                }
              }),
            ),
          ),
        ));
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
              personNameTextView(
                  value: controller.addressDetail.value?.name ?? ""),
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
        "${controller.addressDetail.value?.houseNo}"
        " ${controller.addressDetail.value?.colony}"
        " ${controller.addressDetail.value?.city}"
        " ${controller.addressDetail.value?.state}"
        " ${controller.addressDetail.value?.pinCode}",
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
                      if (controller.productDetail.value?.thumbnailImage !=
                              null &&
                          controller
                              .productDetail.value!.thumbnailImage!.isNotEmpty)
                        itemImageView(
                            path: controller
                                    .productDetail.value?.thumbnailImage ??
                                ""),
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
                      if (controller.productDetail.value?.brandName != null &&
                          controller.productDetail.value?.productName != null)
                        itemDescriptionTextView(
                            value:
                                "${controller.productDetail.value?.brandName} "
                                "${controller.productDetail.value?.productName}"),
                      SizedBox(height: 0.75.h),
                      itemPriceView(),
                      SizedBox(height: 0.75.h),
                      Row(
                        children: [
                          if (controller.productDetail.value?.colorName !=
                                      null &&
                                  controller.productDetail.value!.colorName!
                                      .isNotEmpty ||
                              controller.productDetail.value!.colorCode!
                                      .isNotEmpty &&
                                  controller.productDetail.value!.colorCode !=
                                      null)
                            itemColorTextView(
                                value:
                                    controller.productDetail.value?.colorName,
                                colorCode: int.parse(controller
                                    .productDetail.value!.colorCode
                                    .toString()
                                    .replaceAll("#", "0xff"))),
                          if (controller.productDetail.value?.colorName !=
                                      null &&
                                  controller.productDetail.value!.colorName!
                                      .isNotEmpty ||
                              controller.productDetail.value!.colorCode!
                                      .isNotEmpty &&
                                  controller.productDetail.value!.colorCode !=
                                      null)
                            SizedBox(width: 1.75.w),
                          if (controller.productDetail.value
                                      ?.variantAbbreviation !=
                                  null &&
                              controller.productDetail.value!
                                  .variantAbbreviation!.isNotEmpty)
                            itemSizeTextView(
                                value: controller
                                    .productDetail.value?.variantAbbreviation),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          if (controller.productDetail.value?.availability !=
                              null)
                            subtractButtonView(),
                          if (controller.productDetail.value?.availability !=
                              null)
                            SizedBox(width: 2.w),
                          totalItemQuantityView(),
                          if (controller.productDetail.value?.availability !=
                              null)
                            SizedBox(width: 2.w),
                          if (controller.productDetail.value?.availability !=
                              null)
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
    if (controller.productDetail.value?.isOffer != null &&
        controller.productDetail.value?.isOffer == "1") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (controller.productDetail.value?.offerPrice != null)
            itemPriceTextView(
                value: controller.productDetail.value?.offerPrice ?? ""),
          if (controller.productDetail.value?.offerPrice != null)
            SizedBox(height: 4.px),
          Row(
            children: [
              if (controller.productDetail.value?.sellPrice != null)
                Flexible(
                  child: itemOriginalPriceTextView(
                      value: controller.productDetail.value?.sellPrice ?? ""),
                ),
              SizedBox(height: 4.px),
              if (controller.productDetail.value?.percentageDis != null)
                Flexible(
                  child: itemHowManyPercentOffTextView(
                      value:
                          controller.productDetail.value?.percentageDis ?? ""),
                )
            ],
          )
        ],
      );
    } else {
      print(
          "controller.productDetail.value?.sellPrice:::::::::::::::::::::::${controller.productDetail.value?.sellPrice}");
      return Row(
        children: [
          itemPriceTextView(
              value: controller.productDetail.value?.sellPrice ?? ""),
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
              int.parse(controller.productDetail.value!.availability!))
          ? controller.clickOnIncreaseQuantityButton()
          : null,
      color: (controller.itemQuantity.value <
          int.parse(controller.productDetail.value!.availability!))
          ? Theme.of(Get.context!).colorScheme.onSurface
          : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
      child: increaseQuantityOfItemView());

  Widget increaseQuantityOfItemView() => Icon(
        Icons.add,
        color: (controller.itemQuantity.value <
            int.parse(controller.productDetail.value!.availability!))
            ? Theme.of(Get.context!).colorScheme.onSurface
            : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
        size: 22.px,
      );

  Widget elevatedButtonForItemList(
          {required VoidCallback onPressed,
          required Widget child, Color? color,
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
                  onTap: () => controller.isClickOnApplyCoupon.value
                      ? null
                      : controller.clickOnApplyCouponButtonView(
                          context: context),
                  borderRadius: BorderRadius.all(Radius.circular(4.px)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.px),
                      child: applyCouponButtonView(context: context),
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

  Widget applyCouponButtonView({required BuildContext context}) => Obx(
        () {
          print(controller.count.value);
          return controller.isClickOnApplyCoupon.value
              ? SizedBox(
                  height: 25.px,
                  width: 25.px,
                  child: CommonWidgets.progressBarView())
              : applyCouponTextView();
        },
      );

  Widget applyCouponTextView() => GradientText(
        'Apply Coupon',
        style: Theme.of(Get.context!).textTheme.headline3,
        gradient: CommonWidgets.commonLinearGradientView(),
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
              priceDetailsTextView(
                  text: 'Rs.   ${controller.totalPrice.value}'),
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
}
