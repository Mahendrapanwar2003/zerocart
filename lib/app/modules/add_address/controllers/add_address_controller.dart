import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/common_methods/common_methods.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../../my_location/my_location.dart';
import '../../../apis/api_modals/get_addresses_modal.dart';

class AddAddressController extends GetxController {
  final count = 0.obs;

  Addresses? customerAddress = Get.arguments;

  final key = GlobalKey<FormState>();
  final absorbing = false.obs;
  final isSaveButtonClicked = false.obs;
  final isUseMyLocationButtonClicked = false.obs;

  Map<String, dynamic> userMapData = {};
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final houseController = TextEditingController();
  final colonyController = TextEditingController();
  final addressType = "Home".obs;
  GetLatLong? getLatLong;
  Map<String, dynamic> googleMapData = {};

  Map<String, dynamic> bodyParamsForAddAddressApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();

    userMapData = await CommonMethods.getUserData() ?? {};
    if (customerAddress != null) {
      setDataOnAddAddressTextFields(addresses: customerAddress);
    } else {
      setDataOnAddAddressTextFields();
    }
  }

  void increment() => count.value++;

  Future<void> addAddressControllerOnInIt() async {}

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
    googleMapData =
        await MyLocation.getCurrentLocation(context: Get.context!) ?? {};
    setGoogleMapDataInTextField();
  }

  void setGoogleMapDataInTextField() {
    // ignore: invalid_use_of_protected_member
    nameController.text = userMapData[UserDataKeyConstant.fullName] ?? "";
    // ignore: invalid_use_of_protected_member
    numberController.text = userMapData[UserDataKeyConstant.mobile] ?? "";
    stateController.text = googleMapData[MyAddressKeyConstant.state] ?? "";
    cityController.text = googleMapData[MyAddressKeyConstant.city] ?? "";
    pinCodeController.text = googleMapData[MyAddressKeyConstant.pinCode] ?? "";
    houseController.text =
        googleMapData[MyAddressKeyConstant.addressDetail] ?? "";
    colonyController.text = googleMapData[MyAddressKeyConstant.area] ?? "";
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
      getLatLong = await MyLocation.getLatLongByAddress(
          address: cityController.text.trim().toString() +
              stateController.text.trim().toString());
      if (getLatLong != null) {
        // ignore: use_build_context_synchronously
        if (await callingAddCustomerAddressApi(context: context)) {
          // ignore: use_build_context_synchronously
          clickOnBackIcon(context: context);
        }
      }
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
    isSaveButtonClicked.value = false;
  }

  Future<bool> callingAddCustomerAddressApi(
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
      return true;
    } else {
      return false;
    }
  }
}
