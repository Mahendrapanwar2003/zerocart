import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../progress_bar.dart';
import '../../../custom/custom_appbar.dart';
import '../controllers/my_orders_controller.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.response.value,
        child: GestureDetector(
          onTap: () => MyCommonMethods.unFocsKeyBoard(),
          child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: const MyCustomContainer().myAppBar(
                  isIcon: true,
                  backIconOnPressed: () =>
                      controller.clickOnBackIcon(context: context),
                  text: 'My Previous Orders',
                  buttonText: "Filter",
                  buttonOnPressed: () => controller.clickOnFilterButton(),
                  buttonIcon: Icons.keyboard_arrow_down_rounded),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Zconstant.margin16),
                child: Column(
                  children: [
                    SizedBox(
                      height: Zconstant.margin / 2,
                    ),
                    Theme.of(context).brightness == Brightness.dark
                        ? Container(
                            height: 36.px,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              color: Colors.white,
                            ),
                            child: searchTextFieldView(),
                          )
                        : Container(
                            height: 36.px,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                              color: Colors.white,
                              gradient:
                                  CommonWidgets.commonLinearGradientView(),
                            ),
                            child: Container(
                              height: 36.px,
                              margin: EdgeInsets.all(1.px),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.px),
                                color: Colors.white,
                              ),
                              child: searchTextFieldView(),
                            ),
                          ),
                    SizedBox(height: Zconstant.margin / 2),
                    CommonWidgets.profileMenuDash(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            if (CommonMethods.isConnect.value) {
                              if (controller.getOrderListModal.value != null) {
                                if (controller.orderList.isNotEmpty) {
                                  return Expanded(
                                    child: ListView(
                                      controller: controller.scrollController,
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      children: [
                                        SizedBox(
                                            height: Zconstant.margin16 / 2),
                                        listOfOrder(),
                                        SizedBox(height: Zconstant.margin16),
                                        Obx(() {
                                          if (controller.isLoading.value) {
                                            return CommonWidgets
                                                .progressBarView();
                                          } else if (controller
                                                  .getOrderListModal
                                                  .value
                                                  ?.orderList
                                                  ?.isEmpty ??
                                              false) {
                                            return CommonWidgets.noDataTextView(
                                                text: "No more data!");
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                        SizedBox(
                                          height: Zconstant.margin16,
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return CommonWidgets.noDataTextView();
                                }
                              } else {
                                return CommonWidgets
                                    .somethingWentWrongTextView();
                              }
                            } else {
                              return CommonWidgets.noInternetTextView();
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget searchTextFieldView() => TextFormField(
        cursorColor: MyColorsLight().primary,
        controller: controller.searchOrderController,
        style: Theme.of(Get.context!)
            .textTheme
            .caption
            ?.copyWith(color: MyColorsLight().onText),
        maxLines: 1,
        onChanged: (value) => controller.onChangeSearchTextField(value: value),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Search Order",
          contentPadding: EdgeInsets.only(
            left: Zconstant.margin,
          ),
          hintStyle: Theme.of(Get.context!)
              .textTheme
              .headline4
              ?.copyWith(color: MyColorsLight().onText, fontSize: 10.px),
          suffixIcon: Icon(
            Icons.search,
            color: MyColorsLight().textGrayColor,
            size: 16.px,
          ),
        ),
      );

  Widget listOfOrder() => ListView.builder(
      itemCount: controller.orderList.value.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        controller.orderListObject.value = controller.orderList.value[index];
        if (controller.orderListObject.value?.createdDate != null) {
          controller.dateTime =
              DateTime.parse(controller.orderListObject.value!.createdDate!);
        }
        String? productId=controller.orderListObject.value?.productId;
        return Container(
          padding: EdgeInsets.only(bottom: Zconstant.margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.orderListObject.value?.createdDate != null &&
                  controller.dateTime != null)
                orderPlacedOnDateTextView(
                    value: "Order Placed On: ${getDayOfMonthSuffix(controller.dateTime!.day)} ${DateFormat.MMMM().format(controller.dateTime!)} ${controller.dateTime?.year}"),
              if (controller.orderListObject.value?.ordNo != null)
                orderNumberTextView(value: controller.orderListObject.value?.ordNo),
              SizedBox(height: Zconstant.margin16),
              InkWell(
                borderRadius: BorderRadius.circular(10.px),
                onTap: ()=> controller.clickOnOrderDetails(productId:productId.toString()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (controller.orderListObject.value?.thumbnailImage != null)
                      Padding(
                        padding: EdgeInsets.only(right: Zconstant.margin16),
                        child: productImageView(
                            imageUrl: controller.orderListObject.value?.thumbnailImage),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.orderListObject.value?.productName != null &&
                              controller.orderListObject.value?.brandName != null)
                            productDescription(
                                productDescription: "${controller.orderListObject.value?.brandName} ${controller.orderListObject.value?.productName}"),
                          SizedBox(height: 0.5.h),
                          itemPriceView(),
                          SizedBox(height: 0.5.h),
                          Row(
                            children: [
                              if (controller.orderListObject.value?.variantAbbreviation != null &&
                                  controller.orderListObject.value!.variantAbbreviation!.isNotEmpty)
                                Expanded(
                                  child: Row(
                                    children: [
                                      sizeTextView(),
                                      Expanded(
                                        child: sizeUnitTextView(
                                            value: controller.orderListObject.value?.variantAbbreviation),
                                      )
                                    ],
                                  ),
                                ),
                              if (controller.orderListObject.value!.colorCode != null &&
                                  controller.orderListObject.value!.colorCode!.isNotEmpty)
                                Expanded(
                                    child: Row(
                                  children: [
                                    colorTextView(),
                                    colorTypeTextView(
                                        colorCode: int.parse(controller.orderListObject.value!.colorCode.toString().replaceAll("#", "0xff"))),
                                  ],
                                ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Zconstant.margin16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cancelOrderButtonView(context: context, index: index),
                    SizedBox(
                      width: Zconstant.margin16,
                    ),
                    trackButtonView(),
                  ],
                ),
              ),
              CommonWidgets.profileMenuDash(),
            ],
          ),
        );
      });

  Widget orderPlacedOnDateTextView({String? value}) => Text(
        value ?? "",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget orderNumberTextView({String? value}) => Text(
        "Order No.: $value",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(fontSize: 10.px),
      );

  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return '${dayNum}th';
    }

    switch (dayNum % 10) {
      case 1:
        return '${dayNum}st';
      case 2:
        return '${dayNum}nd';
      case 3:
        return '${dayNum}rd';
      default:
        return '${dayNum}th';
    }
  }

  Widget productImageView({String? imageUrl}) => Container(
        height: 100.px,
        width: 95.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.px),
            image: DecorationImage(
                image: NetworkImage(
                    CommonMethods.imageUrl(url: imageUrl.toString())),
                fit: BoxFit.cover,
                alignment: Alignment.center)),
      );

  Widget productDescription({String? productDescription}) => Text(
        productDescription ?? "",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget itemPriceView() {
    if (controller.orderListObject.value?.isOffer != null &&
        controller.orderListObject.value?.isOffer != "0") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.orderListObject.value?.productDisPrice != null)
            itemPriceTextView(
                value: controller.orderListObject.value?.productDisPrice),
          Row(
            children: [
              if (controller.orderListObject.value?.productPrice != null)
                Flexible(
                    child: itemOriginalPriceTextView(
                        value: controller.orderListObject.value?.productPrice)),
              howManyPercentOffTextView(),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          if (controller.orderListObject.value?.productPrice != null)
            itemPriceTextView(
                value: controller.orderListObject.value?.productPrice),
        ],
      );
    }
  }

  Widget itemPriceTextView({String? value}) => GradientText(
        '$curr$value',
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(overflow: TextOverflow.ellipsis),
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget itemOriginalPriceTextView({String? value}) => Text("$curr$value",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style:
          Theme.of(Get.context!).textTheme.headline3?.copyWith(fontSize: 8.px));

  Widget howManyPercentOffTextView({String? value}) => Text(" (100% Off)",
      style:
          Theme.of(Get.context!).textTheme.headline3?.copyWith(fontSize: 8.px));

  Widget sizeTextView() => Text(
        "Size: ",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget sizeUnitTextView({String? value}) => Text(
        value ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget colorTextView() => Text(
        "Color: ",
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget colorTypeTextView({int? colorCode}) => Container(
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
      );

  Widget cancelOrderButtonView(
          {required BuildContext context, required int index}) =>
      CommonWidgets.myOutlinedButton(
          text: cancelOrderTextView(),
          onPressed: () =>
              controller.clickOnCancelButton(context: context, index: index),
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
}
