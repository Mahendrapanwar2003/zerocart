import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_addresses_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/routes/app_pages.dart';

class AddressController extends GetxController {
  final response=false.obs;
  final isLoading=false.obs;
  Map<String, dynamic> queryParametersForGetCustomerAddress={};

  final getCustomerAddresses = Rxn<GetCustomerAddresses?>();
  final listOfAddress=[].obs;
  Addresses? addresses;

  String isDefaultAddress = '1';
  Map<String, dynamic> bodyParamsForSetDefaultAddressApi = {};
  Map<String, dynamic> bodyParamsForDeleteCustomerAddressApi = {};
  String limit="10";
  int offset=0;
  final scrollController=ScrollController();

  @override
  Future<void> onInit() async {
    super.onInit();
    response.value=true;
    await getCustomerAddressesApiCalling(isListClear: true);
    response.value=false;

    scrollController.addListener(
            () async {
          if(scrollController.position.isScrollingNotifier.value&& ScrollDirection.reverse==scrollController.position.userScrollDirection)
          {
            isLoading.value=true;
          }
          if ( scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            await getCustomerAddressesApiCalling(isListClear:false );
            isLoading.value=false;
          }
        }
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void clickOnBackIcon({required BuildContext context})  {
    Get.back();
  }

  onWillPop({required BuildContext context}) async {
     clickOnBackIcon(context: context);
  }

  Future<void> clickOnParticularAddress({Addresses? addresses, required BuildContext context}) async {
     await Get.toNamed(Routes.ADD_ADDRESS,arguments: addresses);
     response.value=true;
    await getCustomerAddressesApiCalling(isListClear: true);
     response.value=false;
  }

  Future<void> getCustomerAddressesApiCalling({bool isListClear=false}) async {
   if(isListClear)
     {
       offset=0;
     }
    queryParametersForGetCustomerAddress={
      ApiKeyConstant.limit:limit,
      ApiKeyConstant.offset:offset.toString(),
    };
    getCustomerAddresses.value = await CommonApis.getCustomerAddressApi(queryParameters: queryParametersForGetCustomerAddress);
    if (getCustomerAddresses.value!= null) {
      if(getCustomerAddresses.value?.addresses != null &&getCustomerAddresses.value!.addresses!.isNotEmpty)
      {
       List<Addresses?> list= List.from(getCustomerAddresses.value!.addresses!.reversed);
     if(isListClear)
       {
         listOfAddress.clear();
       }
       offset=offset+10;

       for (var element in list) {
         listOfAddress.add(element);
       }
      }
    }
  }

  Future<void> clickOnSelectButton({required int index}) async {
    response.value=true;
    await setCustomerDefaultAddressApiCalling(index: index);
    response.value=false;
  }

  Future<void> setCustomerDefaultAddressApiCalling({required int index}) async {
    bodyParamsForSetDefaultAddressApi = {
      ApiKeyConstant.addressId: listOfAddress[index].addressId,
    };
    http.Response? response = await CommonApis.setCustomerDefaultAddressApi(bodyParams: bodyParamsForSetDefaultAddressApi);
    if(response != null)
      {
        await getCustomerAddressesApiCalling(isListClear: true);
      }
  }

  Future<void> clickOnDeleteButton({required int index}) async {
    response.value=true;
    await deleteCustomerAddressApiCalling(index:index);
    response.value=false;
  }

  Future<void> deleteCustomerAddressApiCalling({required int index}) async {
    bodyParamsForDeleteCustomerAddressApi = {
      ApiKeyConstant.addressId: listOfAddress[index].addressId,
    };
    http.Response? response = await CommonApis.deleteCustomerAddressApi(bodyParams: bodyParamsForDeleteCustomerAddressApi);
    if(response != null)
    {
       listOfAddress.removeAt(index);
    }
  }

  Future<void> clickOnAddNewAddressButton({required BuildContext context}) async {
    await Get.toNamed(Routes.ADD_ADDRESS);
    response.value=true;
    await getCustomerAddressesApiCalling(isListClear: true);
    response.value=false;
  }

}
