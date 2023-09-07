import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/app/modules/my_order_details/controllers/my_order_details_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../custom/custom_gradient_text.dart';
import '../../../validator/form_validator.dart';

class RatingBottomSheet extends GetView<MyOrderDetailsController> {
  const RatingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    /* return MyAlertDialog(
      title:
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            //controller.ratingCount.value="0";
            Get.back();
          },
          isDefaultAction: true,
          child: cancelledTextButtonView(),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Get.back();
          },
          isDefaultAction: true,
          child: submitTextButtonView(),
        ),
      ],
    );*/
    return Obx(() {
      print("${controller.count.value}");
      return GestureDetector(
        onTap: () => controller.clickOnBottomSheet(),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(2.5.px)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.px),
                ratingTextView(),
                SizedBox(height: 5.px),
                CommonWidgets.zeroCartImage(),
                SizedBox(height: 2.px),
                setRatingTextView(),
                SizedBox(height: 15.px),
                ratingBuilderView(),
                SizedBox(height: 10.px),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.px),
                      child: reviewTextView(),
                    ),
                  ],
                ),
                if (controller.selectedImageForRating.isNotEmpty)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: Container(
                      height: 60.px,
                      padding: EdgeInsets.symmetric(horizontal: 4.px),
                      decoration: BoxDecoration(
                          color: MyColorsDark().secondary.withOpacity(.1),
                          border: Border.all(
                            color: MyColorsLight().onPrimary,
                            width: 1.px,
                          ),
                          borderRadius: BorderRadius.circular(5.px)),
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(right: 5.px),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => controller
                                      .clickOnRemoveReviewImage(index: index),
                                  borderRadius: BorderRadius.circular(5.px),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.px),
                                        child: Image.file(
                                          File(controller
                                              .selectedImageForRating[index]
                                              .path),
                                          fit: BoxFit.cover,
                                          height: 50.px,
                                          width: 50.px,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 16.px),
                                          child: Icon(
                                            Icons.cancel,
                                            color: Theme.of(Get.context!)
                                                .textTheme
                                                .subtitle2
                                                ?.color,
                                            size: 14.px,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          physics: const ScrollPhysics(),
                          itemCount: controller.selectedImageForRating.length,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 5,
                          validator: (value) =>
                              FormValidator.isEmptyField(value: value),
                          controller: controller.descriptionController,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 2.w),
                            hintText: 'Description',
                            fillColor: MyColorsDark().secondary.withOpacity(.1),
                            filled: true,
                            suffixIcon: Container(
                              height: 28.px,
                              width: 28.px,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(25.px)),
                              child: InkWell(
                                onTap: () =>
                                    controller.clickOnAddAttachmentIcon(),
                                borderRadius: BorderRadius.circular(25.px),
                                child: GradientIconColor(Icons.attach_file,
                                    gradient: CommonWidgets
                                        .commonLinearGradientView(),
                                    size: 24.px),
                              ),
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyColorsDark().primary),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.px),
                      submitButtonView()
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget ratingTextView() => Text(
        "Rating Dialog",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 16.px, fontWeight: FontWeight.normal),
      );

  Widget pleaseEnterSomeDescriptionTextView() => Text(
        "Please Enter Some Description",
        style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
            fontSize: 16.px,
            fontWeight: FontWeight.normal,
            color: MyColorsLight().error),
      );

  Widget setRatingTextView() => Text(
        "Tap a star to set product rating.",
        style: Theme.of(Get.context!).textTheme.subtitle2,
      );

  Widget ratingBuilderView() => RatingBar.builder(
        initialRating: 1,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemSize: 35,
        itemCount: 5,
        itemBuilder: (context, _) => GradientIconColor(
          gradient: CommonWidgets.commonLinearGradientView(),
          Icons.star,
        ),
        glowColor: MyColorsLight().primary,
        onRatingUpdate: (rating) {
          controller.ratingCount = rating.toString();
        },
      );

  Widget reviewTextView() => Text(
        "Review",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px, fontWeight: FontWeight.normal),
      );

  Widget cancelledTextButtonView() => Text(
        "Cancel",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(color: MyColorsLight().error),
      );

  Widget submitButtonView() {
    return Obx(() {
      if (controller.isSubmitButtonVisible.value) {
        return CommonWidgets.myElevatedButton(
          onPressed: () => controller.clickOnSubmitButton(),
          text: submitTextButtonView(),
        );
      } else {
        return CommonWidgets.myElevatedButton(
          // ignore: avoid_returning_null_for_void
          onPressed: () => null,
          text: CommonWidgets.buttonProgressBarView(),
        );
      }
    });
  }

  Widget submitTextButtonView() => Text(
        "Submit",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(color: MyColorsLight().secondary),
      );
}
