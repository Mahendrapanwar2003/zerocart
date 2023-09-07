import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../custom/custom_gradient_text.dart';

class ModelBottomSheet extends GetView<ProductDetailController> {
  const ModelBottomSheet({super.key});

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
                SizedBox(height: 1.h),
                ratingTextView(),
                SizedBox(height: 1.h),
                CommonWidgets.zeroCartImage(),
                SizedBox(height: .5.h),
                setRatingTextView(),
                SizedBox(height: 2.h),
                ratingBuilderView(),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: reviewTextView(),
                    ),
                  ],
                ),
                if (controller.selectedImageForRating.isNotEmpty)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: SizedBox(
                      height: 50.px,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding:  EdgeInsets.only(right:5.px ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: ()=>controller.clickOnRemoveReviewImage(index: index),
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
                                          height: 45.px,
                                          width: 45.px,
                                        )),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 16.px),
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 16.px,
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
                          controller: controller.descriptionController,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 2.w),
                            hintText: 'description',
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
                      SizedBox(height: 2.h),
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
