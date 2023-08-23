import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/common_methods/common_methods.dart';
import '../../../apis/api_modals/get_addresses_modal.dart';

class AddAddressController extends GetxController {
  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final absorbing = false.obs;
  final isSaveButtonClicked = false.obs;
  final isUseMyLocationButtonClicked = false.obs;
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final houseController = TextEditingController();
  final colonyController = TextEditingController();
  final addressType = "Home".obs;
  final googleMapData = Rxn<Map<String, dynamic>?>();
  final userMapData = {}.obs;
  Map<String, dynamic> bodyParamsForAddAddressApi = {};
  Map<String, dynamic> responseMapOfAddAddressApi = {};
  Addresses? customerAddress=Get.arguments;
  GetLatLong? getLatLong;
  @override
  Future<void> onInit() async {
    super.onInit();
    addAddressControllerOnInIt();
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

  Future<void> addAddressControllerOnInIt() async {
    userMapData.value = await CommonMethods.getUserData() ?? {};
    if (customerAddress != null) {
      setDataOnAddAddressTextFields(addresses: customerAddress);
    } else {
      setDataOnAddAddressTextFields();
    }
  }

  void setDataOnAddAddressTextFields({Addresses? addresses}) {
    nameController.text = addresses?.name ?? "";
    numberController.text = addresses?.phone ?? "";
    pinCodeController.text = addresses?.pinCode ?? "";
    stateController.text = addresses?.state ?? "";
    cityController.text = addresses?.city ?? "";
    houseController.text = addresses?.houseNo ?? "";
    colonyController.text = addresses?.colony ?? "";
    addressType.value = addresses?.addressType ?? "Home";
  }

  void clickOnBackIcon({required BuildContext context}) {
    Get.back();
  }

  onWillPop({required BuildContext context}) {
    clickOnBackIcon(context: context);
  }

  Future<void> clickOnMyLocationButton() async {
    isUseMyLocationButtonClicked.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    await getDataFromGoogleMap();
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    isUseMyLocationButtonClicked.value = false;
  }

  Future<void> getDataFromGoogleMap() async {
    googleMapData.value = await MyLocation.getCurrentLocation(context: Get.context!);
    if (googleMapData.value != null) {
      setGoogleMapDataInTextField();
    }
  }

  void setGoogleMapDataInTextField() {
    // ignore: invalid_use_of_protected_member
    nameController.text = userMapData.value[UserDataKeyConstant.fullName] ?? "";
    // ignore: invalid_use_of_protected_member
    numberController.text = userMapData.value[UserDataKeyConstant.mobile] ?? "";
    stateController.text =
        googleMapData.value![MyAddressKeyConstant.state] ?? "";
    cityController.text = googleMapData.value![MyAddressKeyConstant.city] ?? "";
    pinCodeController.text =
        googleMapData.value![MyAddressKeyConstant.pinCode] ?? "";
    houseController.text =
        googleMapData.value![MyAddressKeyConstant.addressDetail] ?? "";
    colonyController.text =
        googleMapData.value![MyAddressKeyConstant.area] ?? "";
  }

  void clickOnHomeButton() {
    MyCommonMethods.unFocsKeyBoard();
    addressType.value = "Home";
  }

  void clickOnWorkButton() {
    MyCommonMethods.unFocsKeyBoard();
    addressType.value = "Work";
  }

  void clickOnOtherButton() {
    MyCommonMethods.unFocsKeyBoard();
    addressType.value = "Other";
  }


  Future<void> clickOnSaveAddressButton({required BuildContext context}) async {
    isSaveButtonClicked.value = true;
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    MyCommonMethods.unFocsKeyBoard();
    if (key.currentState!.validate()) {
      getLatLong= await MyLocation.getLatLongByAddress(address: cityController.text.trim().toString()+stateController.text.trim().toString());
      if(getLatLong != null)
        {
          // ignore: use_build_context_synchronously
          await callingAddCustomerAddressApi(context: context);
        }
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    isSaveButtonClicked.value = false;
  }

  Future<void> callingAddCustomerAddressApi(
      {required BuildContext context}) async {
    bodyParamsForAddAddressApi = {
      ApiKeyConstant.name: nameController.text.trim().toString(),
      ApiKeyConstant.phone: numberController.text.trim().toString(),
      ApiKeyConstant.countryCode: "+91",
      ApiKeyConstant.pinCode: pinCodeController.text.trim().toString(),
      ApiKeyConstant.state: stateController.text.trim().toString(),
      ApiKeyConstant.city: cityController.text.trim().toString(),
      ApiKeyConstant.houseNo: houseController.text.trim().toString(),
      ApiKeyConstant.colony: colonyController.text.trim().toString(),
      ApiKeyConstant.addressType: addressType.value,
      ApiKeyConstant.latitude: getLatLong?.latitude.toString(),
      ApiKeyConstant.longitude: getLatLong?.longitude.toString(),
      ApiKeyConstant.addressId: customerAddress?.addressId ?? "",
    };

    http.Response? response = await CommonApis.addCustomerAddressApi(
        bodyParams: bodyParamsForAddAddressApi);
    if (response != null) {
      responseMapOfAddAddressApi = jsonDecode(response.body);
      // ignore: use_build_context_synchronously
      clickOnBackIcon(context: context);
    }
  }


}
