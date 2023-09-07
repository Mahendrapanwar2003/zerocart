import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';
import 'package:zerocart/model_progress_bar/model_progress_bar.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../common_widgets/common_widgets.dart';
import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const MyCustomContainer().myAppBar(
            text: "Filters",
            isIcon: true,
            backIconOnPressed: () =>
                controller.clickOnCloseButton(context: context),
            buttonText: "Close",
            buttonOnPressed: () =>
                controller.clickOnCloseButton(context: context),
          ),
          extendBodyBehindAppBar: true,
          body: Obx(
            () {
              controller.count.value;
              if (CommonMethods.isConnect.value) {
                if (controller.getFilterModal != null &&
                    controller.responseCode == 200) {
                  if (controller.filterList.isNotEmpty) {
                    return CommonWidgets.commonRefreshIndicator(
                      onRefresh: () => controller.onRefresh(),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          customFilterTabView(context: context),
                          SizedBox(height: 8.px),
                        ],
                      ),
                    );
                  } else {
                    return CommonWidgets.commonNoDataFoundImage(
                      onRefresh: () => controller.onRefresh(),
                    );
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
            },
          ),
        ),
      );
    });
  }

  Widget filtersTextView() => Text(
        "Filters",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget closeButtonView({required BuildContext context}) => TextButton(
        onPressed: () => controller.clickOnCloseButton(context: context),
        child: Text(
          "Close",
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 14.px),
        ),
      );

  Widget customFilterTabView({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 34.w,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.filterList.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 5.px);
              },
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Row(
                    children: [
                      SizedBox(width: 2.w),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: (controller.initialIndex.value == index)
                            ? 28.px
                            : 0,
                        width:
                            (controller.initialIndex.value == index) ? 3.px : 0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.px),
                            gradient: CommonWidgets.commonLinearGradientView()),
                      ),
                      SizedBox(width: 5.px),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.px),
                              child: filtersTextButtonView(
                                text:
                                    controller.filterList[index].filterCatName!,
                                onPressed: () =>
                                    controller.clickOnParticularFilterButton(
                                        index: index),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: 75.h,
            ),
            child: verticalDivider(),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 75.h,
              ),
              child: PageView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: [
                  Obx(
                    () {
                      controller.count.value;
                      if (CommonMethods.isConnect.value) {
                        if (controller.getFilterList != null &&
                            controller.responseCode == 200) {
                          if (controller.filterDetailList.isNotEmpty) {
                            return CommonWidgets.commonRefreshIndicator(
                              onRefresh: () => controller.onRefresh(),
                              child: chooseFilter(context: context),
                            );
                          } else {
                            if (controller.filterDetailList.isEmpty) {
                              return const SizedBox();
                            }
                            return CommonWidgets.commonNoDataFoundImage(
                              onRefresh: () => controller.onRefresh(),
                            );
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget verticalDivider() {
    return Container(
      height: double.infinity,
      width: .8.px,
      color: Colors.white,
    );
  }

  Widget chooseFilter({required BuildContext context}) {
    return Obx(() {
      print("${controller.isFilterUpdate.value}");
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 14.px),
            child: SizedBox(
              height: 60.h,
              child: ListView.separated(
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.filterDetailList![index].filterValue != null
                        ? Container(
                            height: 30.px,
                            decoration: BoxDecoration(
                              gradient: controller.filterDetailList![index]
                                          .filterValue ==
                                      controller.filterData[controller
                                          .filterList![
                                              controller.initialIndex.value]
                                          .filterId
                                          .toString()]
                                  ? CommonWidgets.commonLinearGradientView()
                                  : null,
                              color: controller.filterDetailList![index]
                                          .filterValue ==
                                      controller.filterData[controller
                                          .filterList![
                                              controller.initialIndex.value]
                                          .filterId
                                          .toString()]
                                  ? null
                                  : MyColorsLight().backgroundFilterColor,
                              borderRadius: BorderRadius.circular(5.px),
                            ),
                            child: ElevatedButton(
                              onPressed: () =>
                                  controller.clickOnFilterList(index: index),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              child: Text(
                                controller
                                        .filterDetailList![index].filterValue ??
                                    "",
                                style:
                                    Theme.of(Get.context!).textTheme.subtitle2,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.px),
                itemCount: controller.filterDetailList!.length,
                physics: const ScrollPhysics(),
              ),
            ),
          ),
          if (controller.filterData.isNotEmpty)
            applyButtonView(
                text: "Apply Filter",
                onPressed: () =>
                    controller.clickOnApplyFilterButton(context: context))
        ],
      );
    });
  }

  Widget starIcon() => Image.asset(
        "assets/star.png",
      );

  Widget filtersTextButtonView({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(
          text,
          style: Theme.of(Get.context!).textTheme.subtitle1,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget applyButtonView({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 40.px,
      width: 40.w,
      child: CustomOutlineButton(
        onPressed: onPressed,
        strokeWidth: 1.px,
        radius: 25.px,
        gradient: CommonWidgets.commonLinearGradientView(),
        child: Text(
          text,
          style: Theme.of(Get.context!).textTheme.subtitle1,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
