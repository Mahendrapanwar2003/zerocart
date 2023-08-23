import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/modules/my_orders/controllers/my_orders_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';

// ignore: must_be_immutable
class MyOrdersCancelBottomSheet extends GetView<MyOrdersController> {
  int? index;
  double? price;

  MyOrdersCancelBottomSheet({super.key, this.index, this.price});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Zconstant.margin16/3 ),
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.1.px,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 8.px,
                  ),
                  child: Container(
                    height: 3.5.px,
                    decoration: BoxDecoration(
                      color: MyColorsLight().onPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(2.5.px)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.px),
            Padding(
              padding: EdgeInsets.only(left: 20.px),
              child: Text(
                "Cancel Order",
                style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
                    color: MyColorsDark().secondary, fontSize: 18.px),
              ),
            ),
            SizedBox(height: 10.px),
            CommonWidgets.profileMenuDash(
                height: 4.px, color: MyColorsLight().dashMenuColor),
            Container(
              height: 12.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: CommonWidgets.commonLinearGradientView(),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Zconstant.margin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        productImageView(index: index!),
                        SizedBox(width: 15.px),
                        Flexible(
                          child: savedPriceTextView(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            CommonWidgets.profileMenuDash(
                height: 4.px, color: MyColorsLight().dashMenuColor),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Zconstant.margin, vertical: 8.px),
              child: ifYouCancelTextView(),
            ),
            CommonWidgets.profileMenuDash(color: MyColorsLight().dashMenuColor),
            Row(
              children: [
                Expanded(
                  child: cancelTextButtonView(),
                ),
                SizedBox(height: 46.px, child: verticalDividerView()),
                Expanded(
                  child: okTextButtonView(context: context, index: index!),
                ),
              ],
            ),
            CommonWidgets.profileMenuDash(color: MyColorsLight().dashMenuColor),
            SizedBox(height: 1.h),
          ],
        ),
      ],
    );
  }

  Widget savedPriceTextView() => Text(
        "${controller.orderList[index!].productName} ${controller.orderList[index!].brandName} $curr$price",
        style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
              color: MyColorsLight().secondary,
            ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      );

  Widget productImageView({required int index}) => Container(
        height: 75.px,
        width: 75.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.px),
          image: DecorationImage(
            image: NetworkImage(
              CommonMethods.imageUrl(
                url: controller.orderList[index].thumbnailImage.toString(),
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget ifYouCancelTextView() => Text(
        "If you cancel now, you may not be able to available this deal again. Do you still want to cancel?",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px, color: MyColorsDark().secondary),
      );

  Widget cancelTextButtonView() => InkWell(
        onTap: () => controller.clickOnDoNotCancelButton(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.px),
          child: Center(
            child: Text(
              "Cancel",
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: MyColorsLight().textGrayColor),
            ),
          ),
        ),
      );

  Widget verticalDividerView() => VerticalDivider(
      width: 0.px, thickness: 1.px, color: MyColorsLight().dashMenuColor);

  Widget okTextButtonView(
          {required BuildContext context, required int index}) =>
      InkWell(
        onTap: () =>
            controller.clickOnCancelOrderButton(context: context, index: index),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.px),
          child: Center(
            child: Text(
              "Ok",
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: MyColorsDark().error),
            ),
          ),
        ),
      );
}
