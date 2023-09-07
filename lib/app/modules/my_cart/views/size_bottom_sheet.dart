import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';

class SizeBottomSheet extends GetView<MyCartController> {
  int index;

  SizeBottomSheet({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.35.px,
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
                  ),
                  SizedBox(height: 8.px),
                  readyToCheckOutItemPleaseSelectSizeTextView(),
                  SizedBox(height: 8.px),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller
                        .cartItemList[index].varientList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      //mainAxisExtent: 2.px,
                      crossAxisSpacing: 4.px,
                    ),
                    itemBuilder: (context, ind) {
                      return Padding(
                        padding: EdgeInsets.all(4.px),
                        child: readyToCheckOutItemSizeView(ind: ind),
                      );
                    },
                  ),
                  SizedBox(height: 8.px),
                ],
              ),
            ),
          ],
        ));
  }

  Widget elevatedButtonForItemList(
          {required VoidCallback onPressed,
          required Widget child,
          double? height}) =>
      Container(
        //height: height ?? 3.5.h,
        //width: 32.px,
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

  Widget readyToCheckOutItemSizeView({required int ind}) =>
      elevatedButtonForItemList(
        onPressed: () => controller.readyToCheckOutClickOnSizeIndexButton(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: readyToCheckOutItemSizeIndexTextView(ind: ind),
        ),
      );

  Widget readyToCheckOutItemPleaseSelectSizeTextView() => Text(
        "Please Select Size",
        style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
            fontSize: 16.px,
            color: MyColorsLight().secondary,
            fontWeight: FontWeight.w300),
      );

  Widget readyToCheckOutItemSizeIndexTextView({required int ind}) => Text(
        controller
            .cartItemList[index].varientList![ind].variantAbbreviation
            .toString(),
        style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
            color: MyColorsLight().secondary, fontWeight: FontWeight.w300),
      );

  Widget textViewForChatFilter({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px, color: MyColorsDark().secondary),
      );

  Widget arrowRightIconButtonForChatFilter({required VoidCallback onPressed}) =>
      IconButton(
        onPressed: onPressed,
        splashRadius: 20.px,
        icon: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: MyColorsDark().secondary,
        ),
      );

  Widget dividerForBottomSheet() =>
      SizedBox(width: 90.w, child: CommonWidgets.profileMenuDash());
}
