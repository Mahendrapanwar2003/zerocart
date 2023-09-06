import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/load_more/load_more.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../constant/zconstant.dart';
import '../controllers/zerocart_wallet_controller.dart';

class ZerocartWalletView extends GetView<ZerocartWalletController> {
  const ZerocartWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.inAsyncCall.value,
          child: AbsorbPointer(
            absorbing: controller.absorbing.value,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: myWalletBalanceTextView(),
                shadowColor: Theme.of(Get.context!)
                    .scaffoldBackgroundColor
                    .withOpacity(.4),
                leadingWidth: 24.px,
                leading: IconButton(
                  onPressed: () => controller.clickOnBackIcon(context: context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18.px,
                    color: MyColorsLight().secondary,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(Get.context!).colorScheme.primary,
                      Theme.of(Get.context!).primaryColor,
                    ],
                  )),
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: WillPopScope(
                onWillPop: () => controller.onWillPop(),
                child: GestureDetector(
                  onTap: () => MyCommonMethods.unFocsKeyBoard(),
                  child: Obx(() {
                    if (CommonMethods.isConnect.value) {
                      if (controller.getWalletHistoryModel != null &&
                          controller.responseCode == 200) {
                        return Stack(
                          children: [
                            gradiantBackGround(),
                            Column(
                              children: [
                                SizedBox(height: 2.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Zconstant.margin),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (controller.userData != null)
                                            controller.userData?.customer
                                                        ?.walletAmount !=
                                                    null
                                                ? Expanded(
                                                    child: howManyBalanceInWalletTextView(
                                                        value:
                                                            "$curr${double.parse(double.parse(controller.userData!.customer!.walletAmount!).toStringAsFixed(2))}"))
                                                : howManyBalanceInWalletTextView(
                                                    value: '${curr}0.0'),
                                          RotationTransition(
                                              turns:
                                                  Tween(begin: 0.0, end: 30.0)
                                                      .animate(controller
                                                          .rotationController),
                                              child: InkWell(
                                                  onTap: () => controller
                                                      .clickOnRotateIcon(),
                                                  child: autoReNewIconView())),
                                        ],
                                      ),
                                      SizedBox(height: 2.h),
                                      addMoneyToWalletText(),
                                      SizedBox(height: 1.h),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 9,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Zconstant.margin - 4),
                                              height: 40.px,
                                              decoration: BoxDecoration(
                                                color:
                                                    MyColorsLight().secondary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.px),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  rupeeTextVIew(text: curr),
                                                  SizedBox(width: 10.px),
                                                  Expanded(
                                                    flex: 9,
                                                    child:
                                                        addMoneyTextFieldView(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            flex: 1,
                                            child: arrowIconButtonView(),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Zconstant.margin,
                                  right: Zconstant.margin,
                                  top: 23.h,
                                  bottom: Zconstant.margin),
                              child: Obx(() {
                                controller.count.value;
                                if (controller.listOfWalletHistory.isNotEmpty) {
                                  return CommonWidgets.commonRefreshIndicator(
                                    onRefresh: () => controller.onRefresh(),
                                    child: RefreshLoadMore(
                                        isLastPage: controller.isLastPage.value,
                                        onLoadMore: () =>
                                            controller.onLoadMore(),
                                        child: listOfTransectionView()),
                                  );
                                } else {
                                  return CommonWidgets.commonNoDataFoundImage(
                                    onRefresh: () => controller.onRefresh(),
                                  );
                                }
                              }),
                            )
                          ],
                        );
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
            ),
          ),
        );
      },
    );
  }

  Widget gradiantBackGround() => Container(
        height: 25.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(Get.context!).colorScheme.primary,
                Theme.of(Get.context!).primaryColor,
              ]),
        ),
      );

  Widget backIconView({required BuildContext context}) => IconButton(
        onPressed: () => controller.clickOnBackIcon(context: context),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: MyColorsLight().secondary,
        ),
        splashRadius: 24.px,
        iconSize: 18.px,
      );

  Widget myWalletBalanceTextView() => Text(
        "My Wallet Balance",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(color: MyColorsLight().secondary),
      );

  Widget howManyBalanceInWalletTextView({required String value}) => Text(value,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(Get.context!).textTheme.headline1);

  Widget autoReNewIconView() => Icon(
        Icons.autorenew,
        color: MyColorsLight().secondary,
        size: 24.px,
      );

  Widget lastUpdateTimeTextView() {
    return Text(
      "Updated 2 Sec Ago",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(Get.context!)
          .textTheme
          .headline3
          ?.copyWith(color: MyColorsLight().secondary),
    );
  }

  Widget addMoneyToWalletText() {
    return Text(
      "Add Money To Wallet",
      style: Theme.of(Get.context!)
          .textTheme
          .subtitle2
          ?.copyWith(color: MyColorsLight().secondary, fontSize: 16.px),
    );
  }

  Widget rupeeTextVIew({required String text}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 4.px,
          ),
          Text(
            text,
            textAlign: TextAlign.justify,
            style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
                fontSize: 16.px,
                color: (controller.isAddedMoney.value)
                    ? MyColorsDark().secondary
                    : MyColorsDark().backgroundFilterColor),
          ),
        ],
      );

  Widget addMoneyTextFieldView() => TextFormField(
        controller: controller.addMoneyController,
        style: Theme.of(Get.context!)
            .textTheme
            .headline2
            ?.copyWith(fontSize: 16.px, color: MyColorsDark().secondary),
        onChanged: (value) {
          if (value.trim().isNotEmpty) {
            controller.isAddedMoney.value = true;
          } else {
            controller.isAddedMoney.value = false;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 5.px),
          hintText: "Amount",
          hintStyle: Theme.of(Get.context!).textTheme.headline2?.copyWith(
                fontSize: 16.px,
                color: MyColorsDark().backgroundFilterColor,
              ),
        ),
      );

  Widget arrowIconButtonView() => ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(35.px, 40.px),
            backgroundColor: MyColorsLight().secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.px),
            ),
            padding: EdgeInsets.zero),
        onPressed: () => controller.clickOnArrowIcon(),
        child: arrowImageView(),
      );

  Widget arrowImageView() => Image.asset(
        "assets/gradient_wallet_arrow.png",
        height: 30.px,
        width: 20.px,
      );

  Widget listOfTransectionView() => ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                controller.walletHistoryModel =
                    controller.listOfWalletHistory[index];
                if (controller.walletHistoryModel!.createdDate != null &&
                    controller.walletHistoryModel!.createdDate!.isNotEmpty) {
                  controller.dateTime = DateTime.parse(
                      controller.walletHistoryModel!.createdDate!);
                }
                return ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0.px, sigmaY: 5.0.px),
                    child: Column(
                      children: [
                        InkWell(
                          /*onTap: () => controller.clickOnParticularTransection(index: index),
                          borderRadius: BorderRadius.circular(10.px),*/
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.5.h,
                              horizontal: 4.w,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.px),
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? MyColorsLight().secondary.withOpacity(0.2)
                                    : MyColorsDark()
                                        .secondary
                                        .withOpacity(0.2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      dateOfTransectionTextView(index: index),
                                      SizedBox(height: 1.h),
                                      transectionTitleTextVIew(index: index)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (controller
                                              .walletHistoryModel?.transType !=
                                          null)
                                        transectionAmountTextView(index: index),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.3.h,
                        )
                      ],
                    ),
                  ),
                );
              },
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.listOfWalletHistory.length,
              physics: const NeverScrollableScrollPhysics(),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      );

  Widget dateOfTransectionTextView({required int index}) => Text(
        "${getDayOfMonthSuffix(controller.dateTime!.day)} ${DateFormat.MMMM().format(controller.dateTime!)} ${controller.dateTime?.year}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!).textTheme.headlineLarge,
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

  Widget transectionTitleTextVIew({required int index}) => Text(
        controller.walletHistoryModel?.actionType ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget transectionAmountTextView({required int index}) => Text(
        controller.walletHistoryModel?.transType == "credit"
            ? '+  $curr${double.parse(double.parse(controller.walletHistoryModel!.inAmt!).toStringAsFixed(2))}' ??
                ""
            : '-  $curr${double.parse(double.parse(controller.walletHistoryModel!.outAmt!).toStringAsFixed(2))}' ??
                "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.end,
        style: Theme.of(Get.context!).textTheme.headline2?.copyWith(
            fontSize: 16.px,
            color: controller.walletHistoryModel?.transType == "credit"
                ? MyColorsLight().success
                : MyColorsLight().error),
      );
}
