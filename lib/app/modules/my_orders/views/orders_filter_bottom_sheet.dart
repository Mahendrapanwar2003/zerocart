import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/modules/my_orders/controllers/my_orders_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class OderFilterBottomSheet extends GetView<MyOrdersController> {
  const OderFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.orderFilterType.value == "-1" ||
              controller.orderFilterType.value != "-1"
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: Zconstant.margin16),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Zconstant.margin16/3 ),
                      /* Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.20.px,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 8.px,
                            ),
                            child: Container(
                              height: 3.5.px,
                              decoration: BoxDecoration(
                                color: MyColorsLight().dashMenuColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.5.px)),
                              ),
                            ),
                          ),
                        ),
                      ),*/
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          filtersTextView(),
                          clearFiltersTextButtonView(),
                        ],
                      ),
                      SizedBox(
                        height: Zconstant.margin - 12,
                      ),
                      orderStatusTextView(),
                      SizedBox(
                        height: Zconstant.margin16,
                      ),
                      orderStatusGridView(),
                      SizedBox(
                        height: Zconstant.margin16,
                      ),
                      CommonWidgets.profileMenuDash(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Zconstant.margin16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            cancelButtonView(),
                            applyButtonView(context: context),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Zconstant.margin16,
                      )
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox();
    });
  }

  Widget filtersTextView() => Text(
        "Filters",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(color: MyColorsDark().secondary),
      );

  Widget clearFiltersTextButtonView() =>
      controller.isClearFiltersButtonClicked.value
          ? Text(
              "Clear Filters",
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: MyColorsDark().textGrayColor),
            )
          : InkWell(
              borderRadius: BorderRadius.circular(4.px),
              onTap: () => controller.clickOnClearFilterButton(),
              child: Text(
                "Clear Filters",
                style: Theme.of(Get.context!)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: MyColorsDark().secondary),
              ),
            );

  Widget orderStatusTextView() => Text(
        "Order Status",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(color: MyColorsDark().secondary),
      );

  Widget orderStatusGridView() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4.5,
          mainAxisSpacing: Zconstant.margin16,
          crossAxisSpacing: Zconstant.margin16,
        ),
        itemBuilder: (context, index) {
          return index.toString() == controller.orderFilterType.value
              ? selectedOrderStatusButtonView(index: index)
              : orderStatusButtonView(index: index);
        },
        itemCount: controller.orderStatusList.length,
        padding: EdgeInsets.zero,
      );

  Widget orderStatusContentTextView({required String text}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
                  color: MyColorsLight().onText,
                ),
          ),
          SizedBox(width: 1.w),
          Icon(Icons.add, size: 16.px, color: MyColorsLight().onText),
        ],
      );

  Widget selectedOrderStatusContentTextView({required String text}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientText(
            text,
            style: Theme.of(Get.context!).textTheme.subtitle2,
            gradient: CommonWidgets.commonLinearGradientView(),
          ),
          SizedBox(width: 1.w),
          GradientIconColor(
            Icons.check,
            size: 16.px,
            gradient: CommonWidgets.commonLinearGradientView(),
          )
        ],
      );

  Widget orderStatusButtonView({required int index}) =>
      CommonWidgets.myOutlinedButton(
        text:
            orderStatusContentTextView(text: controller.orderStatusList[index]),
        onPressed: () => controller.clickOnOrderStatus(index: index),
        height: 35.px,
        radius: 17.px,
        margin: EdgeInsets.zero,
        wantFixedSize: false,
        strokeWidth: 0.8.px,
        linearGradient: commonLinearGradient(),
      );

  Widget selectedOrderStatusButtonView({required int index}) =>
      CommonWidgets.myOutlinedButton(
        text: selectedOrderStatusContentTextView(
            text: controller.orderStatusList[index]),
        onPressed: () => controller.clickOnOrderStatus(index: index),
        height: 35.px,
        radius: 17.px,
        margin: EdgeInsets.zero,
        wantFixedSize: false,
        strokeWidth: 1.2.px,
        linearGradient: CommonWidgets.commonLinearGradientView(),
      );

  //  Widget onTheWayButtonView() => CommonWidgets.myOutlinedButton(
  //         text: onTheWayTextView(text: 'on the way'),
  //         onPressed: () => controller.clickOnTheWayButton(),
  //         width: 35.w,
  //         height: 35.px,
  //         radius: 17.px,
  //         strokeWidth: controller.orderFilterType.value == "OnTheWay" ? 1.5 : 1,
  //         linearGradient: controller.orderFilterType.value == "OnTheWay"
  //             ? CommonWidgets.commonLinearGradientView()
  //             : commonLinearGradient(),
  //       );
  // Widget deliveredButtonView() => CommonWidgets.myOutlinedButton(
  //       text: onTheWayTextView(text: 'Delivered'),
  //       onPressed: () => controller.clickOnDelivered(),
  //       width: 35.w,
  //       height: 35.px,
  //       radius: 17.px,
  //       strokeWidth: controller.orderFilterType.value == "Delivered" ? 1.5 : 1,
  //       linearGradient: controller.orderFilterType.value == "Delivered"
  //           ? CommonWidgets.commonLinearGradientView()
  //           : commonLinearGradient(),
  //     );
  //
  // Widget cancelledButtonView() => CommonWidgets.myOutlinedButton(
  //       text: onTheWayTextView(text: 'Cancelled'),
  //       onPressed: () => controller.clickOnCancelled(),
  //       width: 35.w,
  //       height: 35.px,
  //       radius: 17.px,
  //       strokeWidth: controller.orderFilterType.value == "Cancelled" ? 1.5 : 1,
  //       linearGradient: controller.orderFilterType.value == "Cancelled"
  //           ? CommonWidgets.commonLinearGradientView()
  //           : commonLinearGradient(),
  //     );
  //
  // Widget returnedButtonView() => CommonWidgets.myOutlinedButton(
  //       text: onTheWayTextView(text: 'Returned'),
  //       onPressed: () => controller.clickOnReturned(),
  //       width: 35.w,
  //       height: 35.px,
  //       strokeWidth: controller.orderFilterType.value == "Returned" ? 1.5 : 1,
  //       radius: 17.px,
  //       linearGradient: controller.orderFilterType.value == "Returned"
  //           ? CommonWidgets.commonLinearGradientView()
  //           : commonLinearGradient(),
  //     );
  //
  // Widget onTheWayTextView({required String text}) => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           text,
  //           style: Theme.of(Get.context!).textTheme.subtitle2,
  //         ),
  //         SizedBox(width: 1.w),
  //         Icon(Icons.add,
  //             size: 16.px,
  //             color: Theme.of(Get.context!).textTheme.subtitle2?.color),
  //       ],
  //     );

  /* Widget myOutLineButton(
      {required String text, required VoidCallback onPressed}) =>
      OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: MyColorsLight().primary),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme
                    .of(Get.context!)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: MyColorsDark().secondary),
              ),
              SizedBox(width: 1.w),
              Icon(Icons.add,
                  size: 16.px,
                  color: Theme
                      .of(Get.context!)
                      .textTheme
                      .subtitle2
                      ?.color),
            ],
          ),
        ),
      );*/

  Widget cancelButtonView() => CommonWidgets.myOutlinedButton(
      text: cancelTextView(),
      onPressed: () => controller.clickOnCancelFiltersBottomSheetButton(),
      width: 43.w,
      height: 40.px,
      margin: EdgeInsets.zero,
      radius: 5.px);

  Widget applyButtonView({required BuildContext context}) => Obx(() {
        if (!controller.isApplyButtonClicked.value) {
          return CommonWidgets.myElevatedButton(
              text: applyTextView(),
              onPressed: () => controller.clickOnApplyButton(context: context),
              width: 43.w,
              margin: EdgeInsets.zero,
              height: 40.px,
              borderRadius: 5.px);
        } else {
          return CommonWidgets.myElevatedButton(
              text: CommonWidgets.buttonProgressBarView(),
              // ignore: avoid_returning_null_for_void
              onPressed: () => null,
              width: 43.w,
              margin: EdgeInsets.zero,
              height: 40.px,
              borderRadius: 5.px);
        }
      });

  Widget cancelTextView() => Text(
        "CANCEL",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(color: MyColorsDark().secondary),
      );

  Widget applyTextView() => Text(
        "Apply",
        style: Theme.of(Get.context!)
            .textTheme
            .headline3
            ?.copyWith(color: MyColorsLight().text),
      );

  LinearGradient commonLinearGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(Get.context!).brightness == Brightness.dark
            ? MyColorsDark().secondary
            : MyColorsDark().secondary,
        Theme.of(Get.context!).brightness == Brightness.dark
            ? MyColorsDark().secondary
            : MyColorsDark().secondary,
      ],
    );
  }
}
