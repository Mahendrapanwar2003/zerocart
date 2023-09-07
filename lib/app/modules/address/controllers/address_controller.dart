import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_addresses_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/routes/app_pages.dart';

import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_http/my_http.dart';

class AddressController extends CommonMethods {
  final count = 0.obs;
  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;

  Map<String, dynamic> queryParametersForGetCustomerAddress = {};
  GetCustomerAddresses? getCustomerAddresses;
  List<Addresses> listOfAddress = [];
  Addresses? addresses;
  String limit = "10";
  int offset = 0;

  String isDefaultAddress = '1';
  Map<String, dynamic> bodyParamsForSetDefaultAddressApi = {};
  Map<String, dynamic> bodyParamsForDeleteCustomerAddressApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    try {
      await getCustomerAddressesApiCalling();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(message: "Something went wrong", context: Get.context!);
    }
    inAsyncCall.value = false;
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

  Future<void> onRefresh() async {
    offset = 0;
    await onInit();
  }

  Future<void> onLoadMore() async {
    offset = offset + 10;
    try {
      await getCustomerAddressesApiCalling();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(message: "Something went wrong", context: Get.context!);
    }
  }

  Future<void> getCustomerAddressesApiCalling() async {
    queryParametersForGetCustomerAddress.clear();
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    queryParametersForGetCustomerAddress = {
      ApiKeyConstant.limit: limit,
      ApiKeyConstant.offset: offset.toString(),
    };
    http.Response? response = await MyHttp.getMethodForParams(
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetCustomerAddressApi,
        queryParameters:queryParametersForGetCustomerAddress,
        authorization: authorization,
        context: Get.context!);
    responseCode = response?.statusCode??0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCustomerAddresses =
            GetCustomerAddresses.fromJson(jsonDecode(response.body));
        if (getCustomerAddresses != null) {
          if(offset==0)
          {
            listOfAddress.clear();
          }
          if (getCustomerAddresses?.addresses != null &&
              getCustomerAddresses!.addresses!.isNotEmpty) {
            isLastPage.value=false;
            List<Addresses?> list = List.from(getCustomerAddresses!.addresses!.reversed);
            for (var element in list) {
              listOfAddress.add(element!);
            }
          }else{
            isLastPage.value=true;
          }
        }
      }
    }
    increment();
  }

  Future<bool> setCustomerDefaultAddressApiCalling({required int index}) async {
    bodyParamsForSetDefaultAddressApi.clear();
    bodyParamsForSetDefaultAddressApi = {
      ApiKeyConstant.addressId: listOfAddress[index].addressId,
    };
    http.Response? response = await CommonApis.setCustomerDefaultAddressApi(
        bodyParams: bodyParamsForSetDefaultAddressApi);
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCustomerAddressApiCalling({required int index}) async {
    bodyParamsForDeleteCustomerAddressApi.clear();
    bodyParamsForDeleteCustomerAddressApi = {
      ApiKeyConstant.addressId: listOfAddress[index].addressId,
    };
    http.Response? response = await CommonApis.deleteCustomerAddressApi(
        bodyParams: bodyParamsForDeleteCustomerAddressApi);
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  void increment() => count.value++;

  void clickOnBackIcon({required BuildContext context}) {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  onWillPop({required BuildContext context}) async {
    clickOnBackIcon(context: context);
  }

  Future<void> clickOnParticularAddress({Addresses? addresses, required BuildContext context}) async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.ADD_ADDRESS, arguments: addresses);
    offset = 0;
    await getCustomerAddressesApiCalling();
    inAsyncCall.value = false;
  }

  Future<void> clickOnSelectButton({required int index}) async {
    inAsyncCall.value = true;
    if (await setCustomerDefaultAddressApiCalling(index: index)) {
      offset = 0;
      await getCustomerAddressesApiCalling();
    }
    await setCustomerDefaultAddressApiCalling(index: index);
    inAsyncCall.value = false;
  }

  Future<void> clickOnDeleteButton({required int index}) async {
    inAsyncCall.value = true;
    if (await deleteCustomerAddressApiCalling(index: index)) {
      listOfAddress.removeAt(index);
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnAddNewAddressButton({required BuildContext context}) async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.ADD_ADDRESS);
    offset = 0;
    await getCustomerAddressesApiCalling();
    inAsyncCall.value = false;
  }
}
