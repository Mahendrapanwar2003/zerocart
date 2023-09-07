import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../controllers/confirm_cancel_controller.dart';

class ConfirmCancelView extends GetView<ConfirmCancelController> {
  const ConfirmCancelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        /*appBar: const MyCustomContainer().myAppBar(
        text: 'Confirm Cancel Order',
        isIcon: true,
        backIconOnPressed: () => controller.clickOnBackIcon(),
      ),*/
        body: Container(
          /*height: 30.h,*/
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: CommonWidgets.commonLinearGradientView()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.px,
                width: 100.px,
                decoration: BoxDecoration(
                  color: MyColorsLight().secondary,
                  border: Border.all(
                      color: MyColorsLight().primary, width: 10.px),
                  borderRadius: BorderRadius.circular(50.px),
                ),
                child: GradientIconColor(Icons.check,
                    size: 55.px,
                    gradient: CommonWidgets.commonLinearGradientView()),
              ),
              SizedBox(height: 3.h),
              confirmTextView(text: 'Cancellation Confirmed'),
            ],
          ),
        ),
      );
    });
  }

  Widget backIconView() => Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: () => controller.clickOnBackIcon(),
          icon: Icon(
            Icons.close,
            color: MyColorsLight().secondary,
          ),
          splashRadius: 24.px,
          iconSize: 18.px,
        ),
      );

  Widget textViewForOrdersFilter({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
              fontSize: 14.px,
            ),
      );

  Widget arrowRightIcon() => Icon(
        Icons.keyboard_arrow_right_outlined,
        color: Theme.of(Get.context!).brightness == Brightness.dark
            ? MyColorsLight().secondary
            : MyColorsDark().secondary,
      );

  Widget confirmTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(color: MyColorsLight().secondary, fontSize: 18.px),
      );

  Widget checkStatusButtonView() => OutlinedButton(
        style: OutlinedButton.styleFrom(
            minimumSize: Size(30.w, 4.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.px))),
        onPressed: () {},
        child: Text(
          'Check Status',
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle2
              ?.copyWith(color: MyColorsLight().secondary),
        ),
      );

  Widget backButtonView() => CommonWidgets.myElevatedButton(
      text: Text('Back', style: Theme.of(Get.context!).textTheme.button),
      onPressed: () => controller.clickOnBackIcon(),
      height: 52.px,
      width: 80.w,
      borderRadius: 5.px);
}
