import 'dart:convert';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_notification_api_model.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';
import '../../../common_methods/common_methods.dart';
import 'package:http/http.dart' as http;

class NotificationController extends CommonMethods {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int responseCode = 0;
  int load = 0;

  String limit = "10";
  int offset = 0;
  Map<String, dynamic> queryParameters = {};

  GetNotificationApiModel? getNotificationApiModel;
  List<NotificationList> notificationList = [];
  final isLastPage = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      try {
        await getNotification();
      } catch (e) {
        MyCommonMethods.showSnackBar(
            message: "Something went wrong", context: Get.context!);
        responseCode = 100;
      }
    }
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
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    queryParameters = {
      ApiKeyConstant.limit: limit.toString(),
      ApiKeyConstant.offset: offset.toString(),
    };
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetNotificationApi);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getNotificationApiModel =
            GetNotificationApiModel.fromJson(jsonDecode(response.body));
        if (offset == 0) {
          notificationList.clear();
        }
        if (getNotificationApiModel != null) {
          if (getNotificationApiModel?.notificationList != null &&
              getNotificationApiModel!.notificationList!.isNotEmpty) {
            isLastPage.value = false;
            getNotificationApiModel?.notificationList?.forEach((element) {
              notificationList.add(element);
            });
          } else {
            isLastPage.value = true;
          }
        }
      }
    }
    increment();
  }

  Future<void> onRefresh() async {
    offset = 0;
    await onInit();
  }


  Future<void> onLoadMore() async {
    offset = offset + 10;
    try {
      await getNotification();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(message: "Something went wrong", context: Get.context!);
    }
  }

}
