import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_modals/get_cart_details_model.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/custom/my_dropdown_menu.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../controllers/my_cart_controller.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class MyCartView extends GetView<MyCartController> {
  const MyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgress(
          inAsyncCall: controller.absorbing.value,
          child: GestureDetector(
            onTap: () => MyCommonMethods.unFocsKeyBoard(),
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: const MyCustomContainer().myAppBar(
                  text: 'My Cart',
                  backIconOnPressed: () => controller.clickOnBackButton(),
                  isIcon: controller.wantBackButton),
              body: Obx(() {
                if (CommonMethods.isConnect.value) {
                  if (controller.getCartDetailsModel.value != null) {
                    if (controller.checkedCarItemList.isNotEmpty ||
                        controller.unCheckedCartItemList.isNotEmpty) {
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(height: 8.px),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.px),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (controller.addressDetail.value != null)
                                      deliverToTextView(),
                                    SizedBox(height: 4.px),
                                    if (controller.addressDetail.value != null)
                                      CommonWidgets.profileMenuDash(),
                                    SizedBox(height: 4.px),
                                    addressView(context: context),
                                  ],
                                ),
                              ),
                              if (controller.checkedCarItemList.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.px, right: 16.px, top: 8.px),
                                  child: readyToCheckOutItemListview(),
                                ),
                              if (controller.checkedCarItemList.isNotEmpty)
                                Center(
                                  child: applyCouponView(context),
                                ),
                              if(!controller.isCouponRange.value)
                                SizedBox(height: 20.px),
                              if(!controller.isCouponRange.value)
                                couponRangeText(),
                              if(!controller.isCouponRange.value)
                                SizedBox(height: 10.px),
                              if (controller.checkedCarItemList.isNotEmpty)
                                SizedBox(height: 8.px),
                              if (controller.checkedCarItemList.isNotEmpty)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.px),
                                  child: CommonWidgets.profileMenuDash(),
                                ),
                              if (controller.checkedCarItemList.isNotEmpty)
                                SizedBox(height: 8.px),
                              if (controller.checkedCarItemList.isNotEmpty)
                                cartBillView(),
                              if (controller.checkedCarItemList.isNotEmpty)
                                SizedBox(height: 16.px),
                              if (controller.checkedCarItemList.isNotEmpty)
                                proceedToPaymentButton(context: context),
                              if (controller.unCheckedCartItemList.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 16.px, left: 16.px, top: 16.px),
                                  child: uncheckedItemListView(),
                                ),
                              if (controller.unCheckedCartItemList.isEmpty)
                                SizedBox(height: 8.px),
                              if (!controller.wantBackButton)
                                Center(
                                  child: continueShoppingButtonView(
                                      context: context),
                                ),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],
                      );
                    } else {
                      return CommonWidgets.noDataTextView();
                    }
                  } else {
                    if (!controller.absorbing.value) {
                      return CommonWidgets.somethingWentWrongTextView();
                    } else {
                      return const SizedBox();
                    }
                  }
                } else {
                  return CommonWidgets.noInternetTextView();
                }
              }),
            ),
          ),
        ));
  }

  Widget couponRangeText() => (controller.discountPrice.value == 0.0)
      ? gradientText(
      text: 'Total price should be between coupon range')
      : const SizedBox();

  Widget deliverToTextView() {
    return Text(
      "Deliver to:",
      style:
          Theme.of(Get.context!).textTheme.headline6?.copyWith(fontSize: 12.px),
    );
  }

  Widget addressView({required BuildContext context}) {
    if (controller.addressDetail.value != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.addressDetail.value?.name != null)
                  personNameTextView(
                      value: controller.addressDetail.value?.name ?? ""),
                Padding(
                  padding: EdgeInsets.only(right: 12.px),
                  child: addressDetailView(),
                ),
              ],
            ),
          ),
          changeAddressButtonView(context: context),
        ],
      );
    } else {
      return addAddressButtonView(context: context);
    }
  }

  Widget addAddressButtonView({required BuildContext context}) =>
      CommonWidgets.myOutlinedButton(
          radius: 5.px,
          text: addAddressTextView(),
          onPressed: () => controller.clickOnAddAddressButton(context: context),
          height: 40.px,
          width: 60.w);

  Widget addAddressTextView() => Text(
        "ADD ADDRESS",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

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
        //width: 20.w,
        wantFixedSize: false,
        margin: EdgeInsets.zero,
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

  Widget readyToCheckOutItemListview() => ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: controller.checkedCarItemList.length,
      itemBuilder: (BuildContext context, int index) {
        controller.cartItem.value = controller.checkedCarItemList[index];
        return Padding(
          padding: EdgeInsets.only(bottom: Zconstant.margin16 / 2),
          child: InkWell(
            /*onTap: () => controller.clickedOnReadyToCheckOutListParticularItem(
                index: index),*/
            borderRadius: BorderRadius.circular(10.px),
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
                  padding: EdgeInsets.all(8.px),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (controller.cartItem.value?.thumbnailImage != null)
                        readyToCheckOutItemImageView(
                            index: index,
                            path: controller.cartItem.value?.thumbnailImage ??
                                ''),
                      SizedBox(width: 8.px),
                      Expanded(
                        child: Column(
                          children: [
                            if (controller.cartItem.value?.brandName != null &&
                                controller.cartItem.value?.productName != null)
                              Padding(
                                padding: EdgeInsets.only(right: 12.px),
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.px),
                                  child: readyToCheckOutItemDescriptionTextView(
                                      index: index,
                                      value:
                                          "${controller.cartItem.value?.brandName} ${controller.cartItem.value?.productName}"),
                                ),
                              ),
                            if (controller.cartItem.value?.brandName != null &&
                                controller.cartItem.value?.productName != null)
                              SizedBox(height: 0.75.h),
                            readyToCheckOutItemPriceView(index: index),
                            SizedBox(height: 8.px),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (controller.checkedListItemQuantity[
                                index] ==
                                    null ||
                                    controller
                                        .cartItem.value?.availability ==
                                        "0")
                                /*if (controller.checkedListItemQuantity[index] >
                                    int.parse(controller
                                        .checkedListItemAvalibility[index]))*/
                                  outOfStockTextView(),
                                if (controller.cartItem.value?.varientList !=
                                        null &&
                                    controller.cartItem.value!.varientList!
                                        .isNotEmpty)
                                  readyToCheckOutItemSizeView(index: index),
                                readyToCheckOutItemQuantityView(index: index),
                                readyToCheckOutItemDeleteItemFromCartView(
                                    index: index),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                filledCheckedBox(index: index),
              ],
            ),
          ),
        );
      });

  Widget readyToCheckOutItemImageView(
          {required int index, required String path}) =>
      Container(
        height: 125.px,
        width: 95.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.px),
          image: DecorationImage(
            image: NetworkImage(CommonMethods.imageUrl(url: path)),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      );

  Widget readyToCheckOutItemDescriptionTextView(
          {required int index, required String value}) =>
      Row(
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

  Widget readyToCheckOutItemPriceView({required int index}) {
    if (controller.cartItem.value?.isOffer != null &&
        controller.cartItem.value?.isOffer == "1") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.cartItem.value?.offerPrice != null)
            readyToCheckOutItemPriceTextView(
                index: index,
                value: controller.cartItem.value?.offerPrice ?? ""),
          SizedBox(
            width: 8.px,
          ),
          Row(
            children: [
              if (controller.cartItem.value?.sellPrice != null)
                readyToCheckOutItemOriginalPriceTextView(
                    index: index,
                    value: controller.cartItem.value?.sellPrice ?? ""),
              SizedBox(
                width: 8.px,
              ),
              if (controller.cartItem.value?.percentageDis != null)
                readyToCheckOutItemHowManyPercentOffTextView(
                    index: index,
                    value: controller.cartItem.value?.percentageDis ?? "")
            ],
          )
        ],
      );
    } else {
      return Row(
        children: [
          if (controller.cartItem.value?.sellPrice != null)
            Flexible(
              child: readyToCheckOutItemPriceTextView(
                  index: index,
                  value: controller.cartItem.value?.sellPrice ?? ""),
            ),
        ],
      );
    }
  }

  Widget readyToCheckOutItemPriceTextView(
          {required int index, required String value}) =>
      GradientText(
        '$curr$value',
        style: Theme.of(Get.context!).textTheme.subtitle1,
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget readyToCheckOutItemOriginalPriceTextView(
          {required int index, required String value}) =>
      Text(
        "$curr$value",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px, decoration: TextDecoration.lineThrough),
      );

  Widget readyToCheckOutItemHowManyPercentOffTextView(
          {required int index, required String value}) =>
      Text(
        " ($value% Off)",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px),
      );

/*  Widget elevatedButtonForItemList(
          {required VoidCallback onPressed,
          required Widget child,
          double? height}) =>
      Container(
        height: height ?? 3.5.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.px),
            gradient: CommonWidgets.commonLinearGradientView()),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.px),
              ),
              padding: EdgeInsets.zero),
          child: child,
        ),
      );*/

  Widget elevatedButtonForItemList(
          {required VoidCallback onPressed,
          required Widget child,
          double? height}) =>
      Container(
        height: height ?? 3.5.h,
        width: 32.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.px),
            /*gradient: CommonWidgets.commonLinearGradientView()*/
            border: Border.all(
                color: Theme.of(Get.context!).colorScheme.onSurface)),
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

  Widget readyToCheckOutItemSizeView({required int index}) => SizedBox(
        height: 28.px,
        child: UnicornOutline(
          gradient: CommonWidgets.commonLinearGradientView(),
          radius: 2.px,
          strokeWidth: 1.px,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        readyToCheckOutItemSizeTextView(index: index),
                        readyToCheckOutItemSizeUnitTextView(index: index),
                        readyToCheckOutItemSizeDownIconView(index: index),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 28.px,
                      width: 75.px,
                      child: MyDropdownMenu(
                        width: 75.px,
                        trailingIcon: const SizedBox(),
                        dropdownMenuEntries: controller
                            .cartItem.value!.varientList!
                            .map((VarientList value) {
                          return MyDropdownMenuEntry(
                              value: value,
                              label: value.variantAbbreviation ?? "");
                        }).toList(),
                        onSelected: (value) async {
                          controller.absorbing.value = true;
                          int v = controller.checkedListItemQuantity[index];
                          if (int.parse(value!.availability!) < v) {
                            controller.checkedListItemQuantity[index] =
                                int.parse(value.availability!);
                          }
                          http.Response? response =
                              await controller.manageCartApiCalling(
                                  cartQty:
                                      controller.checkedListItemQuantity[index],
                                  cartItem:
                                      controller.checkedCarItemList[index],
                                  inventoryId: value.inventoryId);
                          if (response != null) {
                            controller.checkedListItemVariant[index] = value;
                            controller.checkedListItemAvalibility[index] =
                                value.availability;
                          }
                          controller.absorbing.value = false;
                        },
                      ),
                    ),
                  ),
                  /* Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 28.px,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: PopupMenuButton<VarientList>(
                              padding: EdgeInsets.zero,
                              splashRadius: 45.px,
                              icon: Icon(Icons.add,
                                  color: Colors.transparent, size: 5.px),
                              color:
                                  const Color.fromARGB(255, 95, 115, 231),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onSelected: (value) {
                                controller.checkedListItemVariant[index] =
                                    value;
                              },
                              itemBuilder: (BuildContext context) {
                                return controller
                                    .cartItem.value!.varientList!
                                    .map((VarientList value) {
                                  return PopupMenuItem<VarientList>(
                                    value: value,
                                    child: Text(value.variantAbbreviation ?? ""),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ),
                      ),*/
                ],
              )),
        ),
      );

  Widget readyToCheckOutItemSizeTextView({required int index}) => Text(
        "Size ",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontWeight: FontWeight.w300),
      );

  Widget readyToCheckOutItemSizeUnitTextView({required int index}) {
    String string = '';
    if (controller.checkedListItemVariant1.isEmpty) {
      controller.checkedListItemVariant1.value =
          controller.checkedListItemVariant;
      for (int i = 0;
          i <
                  controller.getCartDetailsModel.value!.cartItemList![index]
                      .selectedSize!.length &&
              i < 5;
          i++) {
        string += controller
            .getCartDetailsModel.value!.cartItemList![index].selectedSize![i];
      }
    } else {
      if (controller.checkedListItemVariant1[index].variantAbbreviation ==
          controller.checkedListItemVariant[index].variantAbbreviation) {
        for (int i = 0;
            i <
                    controller.checkedListItemVariant[index].variantAbbreviation
                        .length &&
                i < 5;
            i++) {
          string +=
              controller.checkedListItemVariant[index].variantAbbreviation[i];
        }
      } else {
        if (controller.checkedListItemVariant1[index].variantAbbreviation <
            controller.checkedListItemVariant[index].variantAbbreviation) {
          for (int i = 0;
              i <
                      controller.checkedListItemVariant[index]
                          .variantAbbreviation.length &&
                  i < 5;
              i++) {
            string += controller
                .checkedListItemVariant1[index].variantAbbreviation[i];
          }
        }
      }
    }
    return Text(
      string ?? "",
      style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
            fontSize: 12.px,
          ),
      maxLines: 1,
    );
  }

  Widget readyToCheckOutItemSizeDownIconView({required int index}) => Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Theme.of(Get.context!).colorScheme.onSurface,
        size: 20.px,
      );

  Widget readyToCheckOutItemQuantityView({required int index}) => SizedBox(
        height: 28.px,
        // width: 44.px,
        child: UnicornOutline(
          strokeWidth: 1.px,
          radius: 2.px,
          gradient: CommonWidgets.commonLinearGradientView(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              readyToCheckOutItemSubtractButtonView(index: index),
              readyToCheckOutItemQuantityCountTextView(index: index),
              readyToCheckOutItemAddButtonView(index: index),
            ],
          ),
        ),
      );

  Widget readyToCheckOutItemSubtractButtonView({required int index}) =>
      SizedBox(
        height: 28.px,
        width: 32.px,
        child: InkWell(
          onTap: () => controller.checkedListItemQuantity[index] != 1
              ? controller.clickOnReadyToCheckOutItemDownIcon(index: index)
              : null,
          child: readyToCheckOutItemDecreaseQuantityOfItemView(index: index),
        ),
      );

  Widget readyToCheckOutItemDecreaseQuantityOfItemView({required int index}) =>
      Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 16.px,
        color: controller.checkedListItemQuantity[index] != 1
            ? Theme.of(Get.context!).colorScheme.onSurface
            : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
      );

  Widget readyToCheckOutItemQuantityCountTextView({required int index}) => Text(
        controller.checkedListItemQuantity[index].toString(),
        style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
              fontSize: 12.px,
            ),
      );

  Widget readyToCheckOutItemAddButtonView({required int index}) => SizedBox(
        height: 28.px,
        width: 32.px,
        child: InkWell(
            onTap: () => controller.checkedListItemQuantity[index] <
                    int.parse(controller.checkedListItemAvalibility[index])
                ? controller.clickOnReadyToCheckOutItemUpIcon(index: index)
                : null,
            child: readyToCheckOutItemIncreaseQuantityOfItemView(index: index)),
      );

  Widget readyToCheckOutItemIncreaseQuantityOfItemView({required int index}) =>
      Icon(
        Icons.keyboard_arrow_up_rounded,
        size: 16.px,
        color: controller.checkedListItemQuantity[index] <
                int.parse(controller.checkedListItemAvalibility[index])
            ? Theme.of(Get.context!).colorScheme.onSurface
            : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
      );

  Widget readyToCheckOutItemDeleteItemFromCartView(
          {required int index}) =>
      InkWell(
          onTap: () => controller.clickOnReadyToCheckOutItemDeleteIcon(
              itemIndex: index,
              cartUuid: controller.checkedCarItemList[index].uuid),
          borderRadius: BorderRadius.circular(22.px),
          child: readyToCheckOutItemDeleteIconView());

  Widget readyToCheckOutItemDeleteIconView() => SizedBox(
        height: 28.px,
        width: 28.px,
        child: UnicornOutline(
          strokeWidth: 1.px,
          radius: 2.px,
          gradient: CommonWidgets.commonLinearGradientView(),
          child: Icon(
            Icons.delete_outline_rounded,
            color: Theme.of(Get.context!).colorScheme.onSurface,
            size: 18.px,
          ),
        ),
      );

  Widget applyCouponView(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        child: Container(
          height: 42.px,
          //width: 92.w,
          padding: EdgeInsets.symmetric(horizontal: 8.px),
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
                        : controller.clickOnRemoveCouponButtonView(),
                    borderRadius: BorderRadius.all(Radius.circular(4.px)),
                    child: Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.px),
                          child: applyCouponButtonView(
                              context: context,
                              text: controller.isApplyCoupon.value
                                  ? 'Apply Coupon'
                                  : 'Remove Coupon'),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      );

  Widget addCouponTextFieldView() => TextFormField(
        style: Theme.of(Get.context!).textTheme.subtitle1,
        controller: controller.applyCouponController,
        cursorColor: Theme.of(Get.context!).colorScheme.onSurface,
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

  Widget applyCouponButtonView(
          {required BuildContext context, required String text}) =>
      Obx(() {
        controller.count.value;
        return GradientText(
          text,
          style: Theme.of(Get.context!).textTheme.headline3,
          gradient: CommonWidgets.commonLinearGradientView(),
        );
      });

  Widget cartBillView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          priceDetailsTextView(
              text:
                  'Price Details (${controller.checkedCarItemList.length} Items)'),
          SizedBox(height: 5.px),
          if (controller.sellPrice.value != 0.0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                priceTextView(text: 'Total Price'),
                priceTextView(text: "Rs. ${controller.sellPrice.value}")
              ],
            ),
          if (controller.sellPrice.value != 0.0) SizedBox(height: 2.px),
          if (controller.discountPrice.value != 0.0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gradientText(text: 'Discount'),
                gradientText(text: 'Rs. ${controller.discountPrice.value}'),
              ],
            ),
          if (controller.deliveryPrice.value != 0.0) SizedBox(height: 2.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              priceTextView(text: 'Delivery'),
              controller.deliveryPrice.value != 0.0
                  ? priceTextView(text: 'Rs. ${controller.deliveryPrice.value}')
                  : priceTextView(text: 'Free Delivery'),
            ],
          ),
          SizedBox(height: 8.px),
          CommonWidgets.profileMenuDash(),
          SizedBox(height: 8.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              priceDetailsTextView(text: 'Total'),
              priceDetailsTextView(
                  text:
                      'Rs. ${controller.sellPrice.value - controller.discountPrice.value + controller.deliveryPrice.value}'),
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

  Widget gradientText({required String text}) => GradientText(
        text,
        style: Theme.of(Get.context!).textTheme.subtitle1,
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget savingMoneyText() => (controller.discountPrice.value != 0.0)
      ? gradientText(
          text: 'Your Saving Rs: ${controller.discountPrice} On This Order')
      : const SizedBox();

  Widget filledCheckedBox({required int index}) => Positioned(
        top: 10.px,
        right: 10.px,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.clickOnFilledCheckedBox(
                  index: index,
                  cartUuid: controller.checkedCarItemList[index].uuid),
              borderRadius: BorderRadius.circular(8.px),
              child: Container(
                height: 20.px,
                width: 20.px,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: CommonWidgets.commonLinearGradientView(),
                ),
                child: Center(
                    child: Icon(
                  Icons.check,
                  size: 15.px,
                  color: Colors.white,
                )),
              ),
            ),
          ),
        ),
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
          margin: EdgeInsets.symmetric(horizontal: Zconstant.margin16),
          borderRadius: 5.px);

  Widget uncheckedItemListView() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.unCheckedCartItemList.length,
        itemBuilder: (BuildContext context, int index) {
          controller.cartItem.value = controller.unCheckedCartItemList[index];
          return Column(
            children: [
              InkWell(
                /* onTap: () =>
                  controller.clickedOnUncheckedListParticularItem(index: index),*/
                borderRadius: BorderRadius.circular(10.px),
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
                      padding: EdgeInsets.all(8.px),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.cartItem.value?.thumbnailImage != null)
                            uncheckedItemImageView(
                                index: index,
                                value:
                                    controller.cartItem.value?.thumbnailImage ??
                                        ""),
                          SizedBox(width: 8.px),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.cartItem.value?.brandName !=
                                        null &&
                                    controller.cartItem.value?.productName !=
                                        null)
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.px),
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.px),
                                      child: uncheckedItemDescriptionTextView(
                                          index: index,
                                          value:
                                              "${controller.cartItem.value?.brandName} ${controller.cartItem.value?.productName}"),
                                    ),
                                  ),
                                SizedBox(height: 8.px),
                                uncheckedItemPriceView(index: index),
                                SizedBox(height: 8.px),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (controller
                                                .cartItem.value?.varientList !=
                                            null &&
                                        controller.cartItem.value!.varientList!
                                            .isNotEmpty &&
                                        controller
                                                .cartItem.value?.availability !=
                                            null &&
                                        controller
                                                .cartItem.value?.availability !=
                                            "0")
                                      uncheckedItemSizeView(index: index),
                                    if (controller.unCheckedListItemQuantity[
                                                index] ==
                                            null ||
                                        controller
                                                .cartItem.value?.availability ==
                                            "0")
                                      outOfStockTextView(),
                                    if (controller
                                                .cartItem.value?.availability !=
                                            null &&
                                        controller
                                                .cartItem.value?.availability !=
                                            "0")
                                      uncheckedItemQuantityView(index: index),
                                    uncheckedItemDeleteItemFromCartView(
                                        index: index),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (controller.cartItem.value?.availability != null &&
                        controller.cartItem.value?.availability != '0')
                      unFilledCheckBox(index: index),
                  ],
                ),
              ),
              SizedBox(height: 8.px)
            ],
          );
        });
  }

  Widget uncheckedItemImageView({required int index, required String value}) =>
      Container(
        height: 125.px,
        width: 95.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.px),
            image: DecorationImage(
                image: NetworkImage(CommonMethods.imageUrl(url: value)),
                fit: BoxFit.cover,
                alignment: Alignment.center)),
      );

  Widget uncheckedItemDescriptionTextView(
          {required int index, required String value}) =>
      Row(
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

  Widget uncheckedItemPriceView({required int index}) {
    if (controller.cartItem.value?.isOffer != null &&
        controller.cartItem.value?.isOffer == "1") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.cartItem.value?.offerPrice != null)
            uncheckedItemPriceTextView(
                index: index,
                value: controller.cartItem.value?.offerPrice ?? ""),
          SizedBox(
            width: 8.px,
          ),
          Row(
            children: [
              if (controller.cartItem.value?.sellPrice != null)
                uncheckedItemOriginalPriceTextView(
                    index: index,
                    value: controller.cartItem.value?.sellPrice ?? ""),
              SizedBox(
                width: 8.px,
              ),
              if (controller.cartItem.value?.percentageDis != null)
                uncheckedItemHowManyPercentOffTextView(
                    index: index,
                    value: controller.cartItem.value?.percentageDis ?? "")
            ],
          )
        ],
      );
    } else {
      return Row(
        children: [
          if (controller.cartItem.value?.sellPrice != null)
            Flexible(
              child: uncheckedItemPriceTextView(
                  index: index,
                  value: controller.cartItem.value?.sellPrice ?? ""),
            ),
        ],
      );
    }
  }

  Widget uncheckedItemPriceTextView(
          {required int index, required String value}) =>
      GradientText(
        '$curr$value',
        style: Theme.of(Get.context!).textTheme.subtitle1,
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget uncheckedItemOriginalPriceTextView(
          {required int index, required String value}) =>
      Text(
        "$curr$value",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px, decoration: TextDecoration.lineThrough),
      );

  Widget uncheckedItemHowManyPercentOffTextView(
          {required int index, required String value}) =>
      Text(
        " ($value% Off)",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 8.px),
      );

  Widget uncheckedItemSizeView({required int index}) => SizedBox(
        height: 28.px,
        child: UnicornOutline(
          gradient: CommonWidgets.commonLinearGradientView(),
          radius: 2.px,
          strokeWidth: 1.px,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Row(
              children: [
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            uncheckedItemSizeTextView(index: index),
                            uncheckedItemSizeUnitTextView(index: index),
                            uncheckedItemSizeDownIconView(index: index),
                          ],
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 28.px,
                        width: 75.px,
                        child: MyDropdownMenu(
                          width: 75.px,
                          trailingIcon: const SizedBox(),
                          dropdownMenuEntries: controller
                              .cartItem.value!.varientList!
                              .map((VarientList value) {
                            return MyDropdownMenuEntry(
                                value: value,
                                label: value.variantAbbreviation ?? "");
                          }).toList(),
                          /*onSelected: (value) async {
                        controller.absorbing.value = true;
                        http.Response? response =
                        await controller.manageCartApiCalling(
                            cartQty: controller
                                .unCheckedListItemQuantity[index],
                            cartItem:
                            controller.unCheckedCartItemList[index],
                            inventoryId: value?.inventoryId);
                        if (response != null) {
                          controller.uncheckedListItemVariant[index] =
                              value;
                        } else {}
                        controller.absorbing.value = false;
                      },*/

                          onSelected: (value) async {
                            controller.absorbing.value = true;
                            int v = controller.unCheckedListItemQuantity[index];
                            if (int.parse(value!.availability!) < v) {
                              controller.unCheckedListItemQuantity[index] =
                                  int.parse(value.availability!);
                            }
                            http.Response? response =
                                await controller.manageCartApiCalling(
                                    cartQty: controller
                                        .unCheckedListItemQuantity[index],
                                    cartItem:
                                        controller.unCheckedCartItemList[index],
                                    inventoryId: value.inventoryId);
                            if (response != null) {
                              controller.uncheckedListItemVariant[index] =
                                  value;
                              controller.unCheckedListItemAvalibility[index] =
                                  value.availability;
                            }
                            controller.absorbing.value = false;
                          },
                        ),
                      ),
                    ),
                    /*Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 28.px,
                        child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                onChanged: (value) async {
                                  controller.absorbing.value = true;
                                  await controller.manageCartApiCalling(
                                      cartQty: controller
                                          .unCheckedListItemQuantity[index],
                                      cartItem: controller
                                          .unCheckedCartItemList[index],
                                      inventoryId: value?.inventoryId);
                                  controller.uncheckedListItemVariant[index] =
                                      value;
                                  controller.absorbing.value = false;
                                },
                                items: controller.cartItem.value!.varientList!
                                    .map((VarientList value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Text(value.variantAbbreviation ?? ""));
                                }).toList(),
                                iconEnabledColor: Colors.transparent,
                                iconDisabledColor: Colors.transparent,
                              ),
                            ) */
                    /*PopupMenuButton<VarientList>(
                                  padding: EdgeInsets.zero,
                                  splashRadius: 45.px,
                                  icon: Icon(Icons.add,
                                      color: Colors.transparent, size: 5.px),
                                  color:
                                      const Color.fromARGB(255, 95, 115, 231),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onSelected: (value) {
                                    controller.uncheckedListItemVariant[index] = value;
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return controller
                                        .cartItem.value!.varientList!
                                        .map((VarientList value) {
                                      return PopupMenuItem<VarientList>(
                                        value: value,
                                        child: Text(value.variantAbbreviation ?? ""),
                                      );
                                    }).toList();
                                  },
                                )*/ /*
                            ),
                      ),
                    ),*/
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget uncheckedItemSizeTextView({required int index}) => Text(
        "Size ",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontWeight: FontWeight.w300),
      );

  Widget uncheckedItemSizeUnitTextView({required int index}) {
    String string = '';
    if (controller.uncheckedListItemVariant1.isEmpty) {
      controller.uncheckedListItemVariant1.value =
          controller.uncheckedListItemVariant;
      for (int i = 0;
          i < controller.unCheckedCartItemList[index].selectedSize!.length &&
              i < 5;
          i++) {
        string += controller.unCheckedCartItemList[index].selectedSize![i];
      }
    } else {
      if (controller.uncheckedListItemVariant1[index].variantAbbreviation ==
          controller.uncheckedListItemVariant[index].variantAbbreviation) {
        for (int i = 0;
            i <
                    controller.uncheckedListItemVariant[index]
                        .variantAbbreviation.length &&
                i < 5;
            i++) {
          string +=
              controller.uncheckedListItemVariant[index].variantAbbreviation[i];
        }
      }
    }
    return Text(
      string ?? "",
      style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
            fontSize: 12.px,
          ),
      maxLines: 1,
    );
  }

  Widget uncheckedItemSizeDownIconView({required int index}) => Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Theme.of(Get.context!).colorScheme.onSurface,
        size: 20.px,
      );

  Widget uncheckedItemQuantityView({required int index}) => SizedBox(
      height: 3.5.h,
      // width: 44.px,
      child: UnicornOutline(
        radius: 2.px,
        gradient: CommonWidgets.commonLinearGradientView(),
        strokeWidth: 1.px,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            uncheckedItemSubtractButtonView(index: index),
            uncheckedItemQuantityCountTextView(index: index),
            uncheckedItemAddButtonView(index: index),
          ],
        ),
      ));

  Widget outOfStockTextView({String? value}) => Text(
        "Out of stock",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 14.px, color: MyColorsDark().error),
      );

  Widget uncheckedItemSubtractButtonView({required int index}) => SizedBox(
        height: 28.px,
        width: 32.px,
        child: InkWell(
          onTap: () => controller.unCheckedListItemQuantity[index] != 1
              ? controller.clickOnUncheckedItemDownIcon(index: index)
              : null,
          child: uncheckedItemDecreaseQuantityOfItemView(index: index),
        ),
      );

  Widget uncheckedItemDecreaseQuantityOfItemView({required int index}) => Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 16.px,
        color: controller.unCheckedListItemQuantity[index] != 1
            ? Theme.of(Get.context!).colorScheme.onSurface
            : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
      );

  Widget uncheckedItemQuantityCountTextView({required int index}) => Text(
        controller.unCheckedListItemQuantity[index].toString(),
        style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
              fontSize: 12.px,
            ),
      );

  Widget uncheckedItemAddButtonView({required int index}) => SizedBox(
        height: 28.px,
        width: 32.px,
        child: InkWell(
            onTap: () => controller.unCheckedListItemQuantity[index] <
                    int.parse(controller.unCheckedListItemAvalibility[index])
                ? controller.clickOnUncheckedItemUpIcon(index: index)
                : null,
            child: uncheckedItemIncreaseQuantityOfItemView(index: index)),
      );

  Widget uncheckedItemIncreaseQuantityOfItemView({required int index}) => Icon(
        Icons.keyboard_arrow_up_rounded,
        size: 16.px,
        color: controller.unCheckedListItemQuantity[index] <
                int.parse(controller.unCheckedListItemAvalibility[index])
            ? Theme.of(Get.context!).colorScheme.onSurface
            : Theme.of(Get.context!).colorScheme.onSurface.withOpacity(0.2),
      );

  Widget uncheckedItemDeleteItemFromCartView({required int index}) {
    return InkWell(
        onTap: () {
          controller.clickOnUncheckedItemDeleteIcon(
              itemIndex: index,
              cartUuid: controller.unCheckedCartItemList[index].uuid);
        },
        borderRadius: BorderRadius.circular(22.px),
        child: uncheckedItemDeleteIconView());
  }

  Widget uncheckedItemDeleteIconView() => SizedBox(
        height: 28.px,
        width: 28.px,
        child: UnicornOutline(
          strokeWidth: 1.px,
          radius: 2.px,
          gradient: CommonWidgets.commonLinearGradientView(),
          child: Icon(
            Icons.delete_outline_rounded,
            color: Theme.of(Get.context!).colorScheme.onSurface,
            size: 18.px,
          ),
        ),
      );

  Widget unFilledCheckBox({required int index}) {
    return Positioned(
      top: 10,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.clickOnUnFilledCheckBox(
                index: index,
                cartUuid: controller.unCheckedCartItemList[index].uuid),
            borderRadius: BorderRadius.circular(8.px),
            child: Container(
              height: 20.px,
              width: 20.px,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: UnicornOutline(
                strokeWidth: 1,
                radius: 100,
                gradient: CommonWidgets.commonLinearGradientView(),
                child: const Text(
                  "",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget continueShoppingButtonView({required BuildContext context}) =>
      CommonWidgets.myOutlinedButton(
        radius: 5.px,
        text: Text('Continue Shopping',
            style: Theme.of(Get.context!).textTheme.subtitle1),
        onPressed: () => controller.clickOnContinueShopping(context: context),
        height: 42.px,
        margin: EdgeInsets.symmetric(horizontal: Zconstant.margin16),
      );
}
