import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/my_date_picker/my_date_picker.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_all_brand_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_all_fashion_category_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_city_model.dart';
import 'package:zerocart/app/apis/api_modals/get_state_model.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/alert_dialog.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final isSubmitButtonClicked = false.obs;
  final inAsyncCall = false.obs;
  final absorbing = false.obs;
  final key = GlobalKey<FormState>();
  final image = Rxn<File?>();
  final nameController = TextEditingController();
  final securityEmailController = TextEditingController();
  final securityMobileNumberController = TextEditingController();
  final dobController = TextEditingController();
  final userData = Rxn<UserData?>();
  final userDataMap = {}.obs;

  String countryId = "101";
  final stateModel = Rxn<StateModel?>();
  Map<String, dynamic> queryParametersState = {};
  List<States>? statesList;
  final selectedState = Rxn<States?>();
  String stateId='';
  String? stateName;

  final isStateSelectedValue = false.obs;
  final isCitySelectedValue = false.obs;

  final cityModel = Rxn<CityModel?>();
  Map<String, dynamic> queryParametersCity = {};
  List<Cities>? citiesList;
  final selectedCity = Rxn<Cities?>();
  String cityId='';
  String? cityName;

  /*final isSendOtpButtonClicked = false.obs;
  final isSendOtpVisible = false.obs;
  Map<String,dynamic> bodyParamsForSendOtpApi={};
  Map<String, dynamic> sendOtpApiResponseMap = {};
  final isSubmitButtonVisible = false.obs;*/

  Map<String, dynamic> bodyParamsForUpdateApi = {};
  final isCityTextFieldNotVisible = true.obs;

  List checkBoxTitle = [
    'Men',
    'Women',
    'Unisex',
  ];

  final count = 1.obs;
  final getAllBrandListApiModel = Rxn<GetAllBrandListApiModel?>();
  final getAllFashionCategoryListApiModel = Rxn<GetAllFashionCategoryListApiModel?>();
  List<BrandList> brandList = [];
  List<FashionCategoryList> fashionCategoryList = [];

  final checkTypeOfProductsValue = '-1'.obs;
  final checkValue = true.obs;
  List selectedBrands = [];
  List brandId = [];
  List fashionCategoryId = [];
  List selectedFashionCategory = [];
  final useObx = [].obs;
  final isResponse = false.obs;
  String? brandPreferenceName;
  String? brandPreferences;
  String? categoryPreferences;
  String? categoryPreferenceName;
  Iterable<BrandList> selectBrandList = [];
  Iterable<FashionCategoryList> selectFashionCategoryList = [];


  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value=true;
    await getUserData();


    print("selectedState.value::::::::::::::  ${selectedState.value}");
    print("stateId::::::::::::::  $stateId");

    stateName = userDataMap[UserDataKeyConstant.selectedState];
    cityName = userDataMap[UserDataKeyConstant.selectedCity];
    stateId = userDataMap[ApiKeyConstant.stateId];
    cityId = await MyCommonMethods.getString(key: ApiKeyConstant.cityId) ??'';
    setUserDataInTextField();

    await getStateApiCalling();
    if (stateName != '') {
      await getCityApiCalling(sId: stateId.toString());
    }
    await getAllFashionCategoryListApiCalling();
    await getAllBrandListApiCalling();
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

   clickOnBackIcon({required BuildContext context}) {
    if(!absorbing.value)
      {
        Get.back();
      }
  }


  void setUserDataInTextField() {
    nameController.text = userDataMap[UserDataKeyConstant.fullName];
    securityEmailController.text =
        userDataMap[UserDataKeyConstant.securityEmail];
    securityMobileNumberController.text =
        userDataMap[UserDataKeyConstant.securityPhone];
    dobController.text = userDataMap[UserDataKeyConstant.dob];
    checkTypeOfProductsValue.value =
        userDataMap[UserDataKeyConstant.genderPreferences];
    categoryPreferenceName =
        userDataMap[UserDataKeyConstant.categoryPreferenceName];
    brandPreferenceName = userDataMap[UserDataKeyConstant.brandPreferenceName];
    brandPreferences = userDataMap[UserDataKeyConstant.brandPreferences];
    categoryPreferences = userDataMap[UserDataKeyConstant.categoryPreferences];
    if(categoryPreferenceName!=null && categoryPreferenceName!.isNotEmpty) {
      selectedFashionCategory = categoryPreferenceName?.split(",") as List;
    }
    if(brandPreferenceName!=null && brandPreferenceName!.isNotEmpty) {
      selectedBrands = brandPreferenceName?.split(",") as List;
    }
    if(brandPreferences!=null && brandPreferences!.isNotEmpty) {
      brandId = brandPreferences?.split(",") as List;
    }
    if(categoryPreferences!=null && categoryPreferences!.isNotEmpty) {
      fashionCategoryId = categoryPreferences?.split(",") as List;
    }
    if (checkTypeOfProductsValue.value == "m") {
      checkTypeOfProductsValue.value = "0";
    } else if (checkTypeOfProductsValue.value == "f") {
      checkTypeOfProductsValue.value = "1";
    } else if (checkTypeOfProductsValue.value == "m,f") {
      checkTypeOfProductsValue.value = "2";
    } else {
      checkTypeOfProductsValue.value = "";
    }
  }

  Future<void> getUserData() async {
    userDataMap.value = await CommonMethods.getUserData() ?? {};
  }

  Future<void> getStateApiCalling() async {
    queryParametersState = {ApiKeyConstant.countryId: countryId};
    stateModel.value =
    await CommonApis.getStateApi(queryParameters: queryParametersState);
    if (stateModel.value != null) {
      statesList = stateModel.value?.states;
    }
  }

  Future<void> getCityApiCalling({required String sId}) async {
    queryParametersCity = {ApiKeyConstant.stateId: sId};
    cityModel.value =
    await CommonApis.getCityApi(queryParameters: queryParametersCity);
    if (cityModel.value != null) {
      citiesList = cityModel.value?.cities;
    }
  }

  Future<void> getAllBrandListApiCalling() async {
    getAllBrandListApiModel.value = await CommonApis.getAllBrandListApi();
    if (getAllBrandListApiModel.value != null) {
      brandList = getAllBrandListApiModel.value?.brandList ?? [];
      selectBrandList = brandList.where((element) =>brandId.contains(element.brandId ?? ''));
    }
    isResponse.value = true;
  }

  Future<void>  getAllFashionCategoryListApiCalling() async {
    getAllFashionCategoryListApiModel.value =
    await CommonApis.getAllFashionCategoryListApi();
    if (getAllFashionCategoryListApiModel.value != null) {
      fashionCategoryList = getAllFashionCategoryListApiModel.value?.fashionCategoryList ?? [];
      selectFashionCategoryList = fashionCategoryList.where((element) =>fashionCategoryId.contains(element.fashionCategoryId ?? ''));
    }
  }

  Future<void> updateUserProfileApiCalling({required BuildContext context}) async {
    bodyParamsForUpdateApi = {
      UserDataKeyConstant.fullName: nameController.text.trim().toString(),
      UserDataKeyConstant.securityEmail:
      securityEmailController.text.trim().toString(),
      UserDataKeyConstant.securityPhone:
      securityMobileNumberController.text.trim().toString(),
      UserDataKeyConstant.securityPhoneCountryCode: "+91",
      ApiKeyConstant.dob: dobController.text.trim().toString(),
      ApiKeyConstant.countryId: countryId,
      ApiKeyConstant.stateId: stateId ?? "",
      ApiKeyConstant.cityId: cityId ?? "",
      ApiKeyConstant.genderPreferences: checkTypeOfProductsValue.isNotEmpty
          ? checkTypeOfProductsValue.toString() == "0"
          ? "m"
          : checkTypeOfProductsValue.toString() == "1"
          ? "f"
          : 'm,f'
          : '',
      ApiKeyConstant.brandPreferences: brandId.isNotEmpty
          ? brandId.join(',')
          : '' ,
      ApiKeyConstant.categoryPreferences: fashionCategoryId.isNotEmpty
          ? fashionCategoryId.join(',')
          : '' ,
    };
    http.Response? response = await CommonApis.updateUserProfile(
        bodyParams: bodyParamsForUpdateApi, image: image.value);
    if (response != null && response.statusCode == 200) {
      userData.value = await CommonApis.getUserProfileApi();
      if (userData.value != null) {
        await CommonMethods.setUserData(userData: userData.value);
        await MyCommonMethods.setString(
            key: UserDataKeyConstant.selectedState,
            value: stateName.toString());
        await MyCommonMethods.setString(
            key: ApiKeyConstant.stateId, value: stateId.toString());
        await MyCommonMethods.setString(
            key: UserDataKeyConstant.selectedCity, value: cityName.toString());
        await MyCommonMethods.setString(
            key: ApiKeyConstant.cityId, value: cityId.toString());
        isSubmitButtonClicked.value = false;
        // ignore: use_build_context_synchronously
        //clickOnBackIcon(context: context);
        Get.back();
      }
    } else {
      isSubmitButtonClicked.value = false;
    }
  }

  ImageProvider selectImage() {
    if (image.value != null) {
      return FileImage(image.value!);
    } else if (userDataMap[UserDataKeyConstant.profilePicture] != null &&
        userDataMap[UserDataKeyConstant.profilePicture].toString().isNotEmpty) {
      return NetworkImage(CommonMethods.imageUrl(
          url: userDataMap[UserDataKeyConstant.profilePicture]));
    } else {
      return CommonWidgets.defaultProfilePicture();
    }
  }

  void clickOnCameraIcon() {
    showAlertDialog();
  }

  Future<void> clickOnSubmitButton({required BuildContext context}) async {
    MyCommonMethods.unFocsKeyBoard();
    absorbing.value = CommonMethods.changeTheAbsorbingValueTrue();
    dropDownValidationChecker();
    if (key.currentState!.validate()  && !isStateSelectedValue.value && !isCitySelectedValue.value) {
      isSubmitButtonClicked.value = true;
      if (selectedState.value != null) {
        if (selectedCity.value != null) {
          await updateUserProfileApiCalling(context: context);
        } else {
          isSubmitButtonClicked.value = false;
          isCitySelectedValue.value = true;
          MyCommonMethods.showSnackBar(message: "Please select city", context: context);
        }
      } else {
        await updateUserProfileApiCalling(context: context);
      }
    }
    absorbing.value = CommonMethods.changeTheAbsorbingValueFalse();
  }

  void showAlertDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: cameraTextButtonView(),
              onPressed: () => clickCameraTextButtonView(),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: galleryTextButtonView(),
              onPressed: () => clickGalleryTextButtonView(),
            ),
          ],
          title: selectImageTextView(),
          content: contentTextView(),
        );
      },
    );
  }

  Widget selectImageTextView() => Text(
        "Select Image",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 18.px),
      );

  Widget contentTextView() => Text(
        "Choose Image From The Options Below",
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget cameraTextButtonView() => Text(
        "Camera",
        style: Theme.of(Get.context!).textTheme.subtitle2,
      );

  Widget galleryTextButtonView() =>
      Text("Gallery", style: Theme.of(Get.context!).textTheme.subtitle2);

  void clickCameraTextButtonView() {
    pickCamera();
    Get.back();
  }

  void clickGalleryTextButtonView() {
    pickGallery();
    Get.back();
  }

  Future<void> pickCamera() async {
    image.value = await MyImagePicker.pickImage(
      context: Get.context!,
      wantCropper: true,
      color: Theme.of(Get.context!).colorScheme.primary,
    );
  }

  Future<void> pickGallery() async {
    image.value = await MyImagePicker.pickImage(
        context: Get.context!,
        wantCropper: true,
        color: Theme.of(Get.context!).colorScheme.primary,
        pickImageFromGallery: true);
  }

  Future<void> pickDate() async {
    MyCommonMethods.unFocsKeyBoard();
    DateTime? dateTime = await MyDatePicker.datePicker(
        context: Get.context!,
        firstDate: DateTime(1950),
        lightColorPrimaryColor: Theme.of(Get.context!).primaryColor,
        darkColorPrimaryColor: Theme.of(Get.context!).primaryColor);
    if (dateTime != null) {
      dobController.text =
      '${dateTime.year}-${dateTime.month <= 9 ? "0${dateTime.month}" : "${dateTime.month}"}-${dateTime.day <= 9 ? "0${dateTime.day}" : "${dateTime.day}"}';
    }
  }

  void dropDownValidationChecker()  {
    if (stateName == null && stateName == '') {
      isStateSelectedValue.value = true;
    } else {
      isStateSelectedValue.value = false;
    }

    if (cityName == null && cityName == '') {
      isCitySelectedValue.value = true;
      print("cityName :::000:::: $cityName");
    } else {
      isCitySelectedValue.value = false;
      print("cityName :::111:::: $cityName");
    }
  }

  /*Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) =>Theme(
        data: Theme.of(context).brightness==Brightness.dark
            ?ThemeData(
          brightness: Brightness.dark,
          dialogBackgroundColor: MyColorsDark().textGrayColor,
          primarySwatch: const MaterialColor(
            0xFFF2653A,
            <int, Color>{
              50: Color(0xFFFFEBEE),
              100: Color(0xFFFFCDD2),
              200: Color(0xFFEF9A9A),
              300: Color(0xFFE57373),
              400: Color(0xFFEF5350),
              500: Color(0xFFF2653A),
              600: Color(0xFFE53935),
              700: Color(0xFFD32F2F),
              800: Color(0xFFC62828),
              900: Color(0xFFB71C1C),
            },
          ),
        ):ThemeData(
          brightness: Brightness.light,
          //dialogBackgroundColor: Colors.white,
          primarySwatch: const MaterialColor(
            0xFFF2653A,
            <int, Color>{
              50: Color(0xFFFFEBEE),
              100: Color(0xFFFFCDD2),
              200: Color(0xFFEF9A9A),
              300: Color(0xFFE57373),
              400: Color(0xFFEF5350),
              500: Color(0xFFF2653A),
              600: Color(0xFFE53935),
              700: Color(0xFFD32F2F),
              800: Color(0xFFC62828),
              900: Color(0xFFB71C1C),
            },
          ),
        ),
        child: child??const SizedBox(),
      ),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      dobController.text = formattedDate;
    }
  }*/


  /*
  Future<void> clickOnSendOtpButton() async {
    MyCommonMethods.unFocsKeyBoard();
    isSendOtpButtonClicked.value=true;
    await sendOtpApiCalling(type: 'login');
    isSendOtpButtonClicked.value=false;
  }


  Future<void> sendOtpApiCalling({required String type}) async {
    String? uuid =await MyCommonMethods.getString(key:ApiKeyConstant.uuid);
    bodyParamsForSendOtpApi = {
      ApiKeyConstant.mobile: securityMobileNumberController.text.trim().toString(),
      ApiKeyConstant.countryCode: "+91",
      ApiKeyConstant.type: type,
      ApiKeyConstant.uuid: uuid,
    };
    http.Response? response =
    await CommonApis.sendOtpApi(bodyParams: bodyParamsForSendOtpApi);
    if (response != null) {
        sendOtpApiResponseMap = jsonDecode(response.body);
      Get.toNamed(Routes.OTP, arguments: [
        4,
        "Submit",
        sendOtpApiResponseMap[ApiKeyConstant.otp],
        "login",
    securityMobileNumberController.text.toString().trim()
      ]);
    }
  }

*/


}
