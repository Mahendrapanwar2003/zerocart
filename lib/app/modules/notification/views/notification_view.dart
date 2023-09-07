import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/load_more/load_more.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: WillPopScope(
          onWillPop: () => controller.clickOnBackIcon(),
          child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: const MyCustomContainer().myAppBar(
                  backIconOnPressed: () => controller.clickOnBackIcon(),
                  isIcon: true,
                  text: 'Notification'),
              body: Obx(
                () {
                  controller.count.value;
                  if (CommonMethods.isConnect.value) {
                    if (controller.getNotificationApiModel != null &&
                        controller.responseCode == 200) {
                      if (controller.notificationList.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 4.px),
                          itemCount: controller.notificationList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                  elevation: .5,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: .2.px,
                                        color: MyColorsLight().onText,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8.px)),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 16.px),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.px, vertical: 4.px),
                                    leading: Container(
                                      height: 45,
                                      width: 42,
                                      decoration: BoxDecoration(
                                        color: MyColorsLight().borderColor,
                                        borderRadius:
                                            BorderRadius.circular(8.px),
                                      ),
                                      child: Icon(
                                        Icons.notifications,
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.color,
                                        size: 20.px,
                                      ),
                                    ),
                                    horizontalTitleGap: 10.px,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (controller.notificationList[index]
                                                    .notificationFor !=
                                                null &&
                                            controller.notificationList[index]
                                                .notificationFor!.isNotEmpty)
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              controller.notificationList[index]
                                                  .notificationFor
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(Get.context!)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                      fontSize: 14.px,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                        if (controller.notificationList[index]
                                                    .createdDate !=
                                                null &&
                                            controller.notificationList[index]
                                                .createdDate!.isNotEmpty)
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                                controller
                                                    .notificationList[index]
                                                    .createdDate
                                                    .toString(),
                                                style: Theme.of(Get.context!)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(fontSize: 9.px),
                                                maxLines: 1,
                                                textAlign: TextAlign.end),
                                          ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      controller.notificationList[index]
                                                      .notificationText !=
                                                  null &&
                                              controller.notificationList[index]
                                                  .notificationText!.isNotEmpty
                                          ? controller.notificationList[index]
                                              .notificationText
                                              .toString()
                                          : "",
                                      maxLines: 2,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontSize: 12.px,
                                              fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.px),
                              ],
                            );
                          },
                        );
                        /*return CommonWidgets.commonRefreshIndicator(
                          onRefresh: () => controller.onRefresh(),
                          child: RefreshLoadMore(
                            isLastPage: controller.isLastPage.value,
                            onLoadMore: () => controller.onLoadMore(),
                            child: //ListView.builder
                          ),
                        );*/
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
              )),
        ),
      );
    });
  }
}
