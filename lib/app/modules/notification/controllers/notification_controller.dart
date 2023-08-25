import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_notification_api_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';

import '../../../common_methods/common_methods.dart';

class NotificationController extends CommonMethods {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;

  String limit = "10";
  int offset = 0;
  Map<String, dynamic> queryParameters = {};

  final notificationList = Rxn<List<NotificationList>?>();
  final getNotificationApiModel = Rxn<GetNotificationApiModel?>();

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    await getNotification();
    inAsyncCall.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  clickOnBackIcon() {
    Get.back();
  }

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          offset = 0;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  Future<void> getNotification() async {
    queryParameters = {
      ApiKeyConstant.limit: limit,
      ApiKeyConstant.offset: offset,
    };
    getNotificationApiModel.value =
        await CommonApis.getNotificationApi(queryParameters: queryParameters);
    if (getNotificationApiModel.value != null) {
      if (getNotificationApiModel.value!.notificationList != null) {
        notificationList.value =
            getNotificationApiModel.value?.notificationList;
      }
    }
  }

  onRefresh() async {
    offset = 0;
    await onInit();
  }
}
