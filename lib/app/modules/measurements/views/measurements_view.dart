import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../custom/custom_appbar.dart';
import '../controllers/measurements_controller.dart';

class MeasurementsView extends GetView<MeasurementsController> {
  const MeasurementsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const MyCustomContainer().myAppBar(
              isIcon: true,
              backIconOnPressed: () =>
                  controller.clickOnBackIcon(context: context),
              text: 'Measurements'),
          body: Obx(() {
            if (CommonMethods.isConnect.value) {
              if (controller.getCustomerMeasurementApiModel != null &&
                  controller.responseCode == 200) {
                return CommonWidgets.commonRefreshIndicator(
                  onRefresh: () => controller.onRefresh(),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 2.h),
                          addVrScanAndConfirmButtonView(text: "ADD VR SCAN"),
                          SizedBox(height: 3.h),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child:
                                          measurementItemTextView(text: 'Chest'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            subtractIconVIew(index: 0),
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.chest
                                                    .toDouble()
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                              ),
                                            ),
                                            addIconView(index: 0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        resetButtonView(index: 0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child: measurementItemTextView(text: 'Arm'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            subtractIconVIew(index: 1),
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.arm
                                                    .toDouble()
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                              ),
                                            ),
                                            addIconView(index: 1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        resetButtonView(index: 1),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child: measurementItemTextView(
                                          text: 'Shoulder'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            subtractIconVIew(index: 2),
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.shoulder
                                                    .toDouble()
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                              ),
                                            ),
                                            addIconView(index: 2),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        resetButtonView(index: 2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child:
                                          measurementItemTextView(text: 'Waist'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            subtractIconVIew(index: 3),
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.waist
                                                    .toDouble()
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                              ),
                                            ),
                                            addIconView(index: 3),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        resetButtonView(index: 3),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child:
                                          measurementItemTextView(text: 'Neck'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            subtractIconVIew(index: 4),
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.neck
                                                    .toDouble()
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                              ),
                                            ),
                                            addIconView(index: 4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        resetButtonView(index: 4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child: measurementItemTextView(
                                          text: 'Height(cm)'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            subtractIconVIew(index: 5),
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.height
                                                    .toDouble()
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                              ),
                                            ),
                                            addIconView(index: 5),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        resetButtonView(index: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child: measurementItemTextView(
                                          text: 'Weight(kg)'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            subtractIconVIew(index: 6),
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.weight
                                                    .toDouble()
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                              ),
                                            ),
                                            addIconView(index: 6),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        resetButtonView(index: 6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 2.w),
                                      child: measurementItemTextView(text: "BMI"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                    width: 42.w,
                                    child: UnicornOutline(
                                      strokeWidth: 1,
                                      radius: 2,
                                      gradient: CommonWidgets
                                          .commonLinearGradientView(),
                                      child: Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: sizeTextView(
                                                text: controller.height == 0.0 &&
                                                        controller.weight == 0.0
                                                    ? "0.0"
                                                    : controller.bMI
                                                        .toDouble()
                                                        .toStringAsFixed(2)
                                                        .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Text(""),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          addVrScanAndConfirmButtonView(text: "CONFIRM"),
                        ],
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                );
              } else if (controller.responseCode == 0) {
                return const SizedBox();
              }
              return CommonWidgets.commonSomethingWentWrongImage(
                onRefresh: () => controller.onRefresh(),
              );
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

  Widget backIconView({required BuildContext context}) => Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: () => controller.clickOnBackIcon(context: context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(Get.context!).textTheme.subtitle1?.color,
          ),
          splashRadius: 24.px,
          iconSize: 18.px,
        ),
      );

  Widget measurementTextView() => Text(
        "Measurements",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget addVrScanAndConfirmButtonView({required String text}) =>
      CommonWidgets.myOutlinedButton(
          radius: 5.px,
          text: addVrScanConfirmTextView(text: text),
          onPressed: () => text == "CONFIRM"
              ? controller.clickOnConfirmButton()
              : controller.clickOnAddVrScanTextViewButton(),
          height: 40.px,
          width: 60.w);

  Widget addVrScanConfirmTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.headline3,
      );

  Widget measurementItemTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.caption,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
      );

  Widget addIconView({required int index}) => InkWell(
        onTap: () => controller.clickOnAddIconView(index: index),
        child: SizedBox(
          width: 12.w,
          height: 30.px,
          child: Center(
            child: GradientText(
              "+",
              gradient: CommonWidgets.commonLinearGradientView(),
              style: Theme.of(Get.context!).textTheme.subtitle1,
            ),
          ),
        ),
      );

  Widget sizeTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );

  Widget subtractIconVIew({required int index}) => InkWell(
        onTap: () => controller.clickOnSubtractIconView(index: index),
        child: SizedBox(
          width: 12.w,
          height: 30.px,
          child: Center(
            child: GradientText(
              "-",
              gradient: CommonWidgets.commonLinearGradientView(),
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontSize: 18.px),
            ),
          ),
        ),
      );

  Widget resetButtonView({required int index}) => InkWell(
        onTap: () => controller.clickOnResetButton(index: index),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.px),
          child: Text(
            "Reset",
            maxLines: 1,
            style: Theme.of(Get.context!)
                .textTheme
                .headline3
                ?.copyWith(fontSize: 10.px),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      );
}
