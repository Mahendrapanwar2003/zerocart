import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_modals/get_notification_api_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController

  final count = 0.obs;
  final getNotificationApiModel=Rxn<GetNotificationApiModel?>();
  final notificationList = Rxn<List<NotificationList>?>();

  final inAsyncCall=false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value=true;
    await getNotification();
    inAsyncCall.value=false;
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

  Future<void> getNotification() async {
    getNotificationApiModel.value = await CommonApis.getNotificationApi();
    if(getNotificationApiModel.value != null)
    {
      if(getNotificationApiModel.value!.notificationList!= null)
      {
        notificationList.value=getNotificationApiModel.value?.notificationList;
      }
    }
  }
}
