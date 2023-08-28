import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/model_progress_bar/model_progress_bar.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../controllers/cancel_order_controller.dart';

class CancelOrderView extends GetView<CancelOrderController> {
  const CancelOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.inAsyncCall.value,
          child: AbsorbPointer(
            absorbing: controller.isSubmitVisible.value,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: const MyCustomContainer().myAppBar(
                  text: 'Product Cancellation',
                  backIconOnPressed: () => controller.clickOnBackIcon(),
                  isIcon: true),
              body: Obx(() {
                if (CommonMethods.isConnect.value) {
                  if (controller.getCancelOrderReasonList != null &&
                      controller.responseCode == 200) {
                    if (controller.cancelReasonList.isNotEmpty) {
                      return CommonWidgets.commonRefreshIndicator(
                        onRefresh: () => controller.onRefresh(),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          productDescriptionTextView(),
                                          if (controller.myOrderDetailPage != 'myOrderDetailPage')
                                            SizedBox(height: 1.h),
                                          if (controller.myOrderDetailPage != 'myOrderDetailPage')
                                            quantityTextView(),
                                          SizedBox(height: 2.h),
                                          productPriceTextView(),
                                        ],
                                      ),
                                    ),
                                    productImageView()
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                                    child: reasonForCancellationTextView(),
                                  ),
                                  ListView.builder(
                                    itemBuilder: (context, index) => Theme(
                                      data: Theme.of(Get.context!).copyWith(
                                        unselectedWidgetColor:
                                        MyColorsLight()
                                            .onText
                                            .withOpacity(.4),
                                      ),
                                      child: RadioListTile(
                                        visualDensity:
                                        VisualDensity(vertical: -4.px),
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                            horizontal: 5.px),
                                        title: issueTextView(index: index),
                                        value: controller.cancelReasonList[index].uuid,
                                        activeColor: Theme.of(Get.context!).primaryColor,
                                        groupValue: controller.checkValue.value,
                                        onChanged: (value) {
                                          controller.count.value;
                                          controller.checkValue.value = value ?? '';
                                          controller.orderItemUuid = value ?? '';
                                        },
                                      ),
                                    ),
                                    shrinkWrap: true,
                                    itemCount:
                                    controller.cancelReasonList.length,
                                    physics: const BouncingScrollPhysics(),
                                  ),
                                  SizedBox(height: 15.px),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                    child: commentTextFieldView(),
                                  ),
                                  SizedBox(height: 3.h),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() {
                                      if (controller.isSubmitVisible.value &&
                                          controller.checkValue.value.isNotEmpty) {
                                        if (controller.isClickOnSubmitButton.value) {
                                          return submitVisibleProgressBarView();
                                        } else {
                                          return submitVisibleButtonView();
                                        }
                                      } else {
                                        return submitNotVisibleButtonView();
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                          child: CommonWidgets.commonNoDataFoundImage(
                            onRefresh: () => controller.onRefresh(),
                          ),);
                    }
                  } else {
                    if (controller.responseCode == 0) {
                      return const SizedBox();
                    }
                    return CommonWidgets.commonSomethingWentWrongImage(
                      onRefresh: () => controller.onRefresh(),
                    );
                  }
                } else {
                  return CommonWidgets.commonNoInternetImage(
                    onRefresh: () => controller.onRefresh(),
                  );
                }

              }),
            ),
          ),
        );
      },
    );
  }

  Widget backIconView() => IconButton(
        splashRadius: 24.px,
        onPressed: () => controller.clickOnBackIcon(),
        icon: Icon(
          Icons.arrow_back_ios_sharp,
          color: Theme.of(Get.context!).textTheme.subtitle1?.color,
          size: 18.px,
        ),
      );

  Widget productDescriptionTextView() => Text(
        controller.myOrderDetailPage == 'myOrderDetailPage'
            ? '${controller.productDetails.productName} ${controller.productDetails.brandName} | Just $curr${controller.price}'
            : '${controller.orderListObject.productName} ${controller.orderListObject.brandName} | Just $curr${controller.price}',
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget quantityTextView() => Text(
        'Qty: ${controller.orderListObject.productQty ?? ""}',
        style: Theme.of(Get.context!).textTheme.subtitle2,
      );

  Widget productPriceTextView() => Text(
        '$curr${controller.price}',
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget productImageView() => Container(
        height: 75.px,
        width: 75.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.px),
          image: DecorationImage(
            image: NetworkImage(
              CommonMethods.imageUrl(
                url: controller.myOrderDetailPage == 'myOrderDetailPage'?controller.productDetails.thumbnailImage.toString():controller.orderListObject.thumbnailImage.toString(),
              ),
            ),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget reasonForCancellationTextView() => Text(
        "Reason For Cancellation",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget issueTextView({required int index}) => Text(
        '${controller.cancelReasonList?[index].reason}',
        style: Theme.of(Get.context!).textTheme.subtitle2,
      );

  Widget commentTextFieldView() => CommonWidgets.myTextField(
        labelText: 'Comment (Required)*',
        hintText: 'Please enter comment',
        controller: controller.commentTextField,
        icon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.verified, color: MyColorsLight().success, size: 20.px),
          splashRadius: 24.px,
        ),
        onChanged: (value) {
          if (value.toString().trim().isNotEmpty) {
            controller.isSubmitVisible.value = true;
          } else {
            controller.isSubmitVisible.value = false;
          }
        },
        iconVisible: false,
      );

  Widget submitVisibleButtonView() => CommonWidgets.myElevatedButton(
      text: Text('Submit Request',
      style: Theme.of(Get.context!).textTheme.button),
      onPressed: () => controller.clickOnSubmitButton(),
      height: 52.px,
      width: 80.w,
      borderRadius: 5.px);

  Widget submitNotVisibleButtonView(
          {BorderRadiusGeometry? borderRadius, String? text}) =>
      Container(
        height: 52.px,
        width: 80.w,
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(5.px),
            color: MyColorsLight().textGrayColor.withOpacity(.4),),
        child: Center(
          child: Text(text ?? 'Submit Request',
              style: Theme.of(Get.context!).textTheme.button,),
        ),
      );

  Widget submitVisibleProgressBarView() {
    return CommonWidgets.myElevatedButton(
        text: CommonWidgets.buttonProgressBarView(),
        onPressed: () => controller.clickOnSubmitButton(),
        height: 52.px,
        width: 80.w,
        borderRadius: 5.px);
  }

}
