import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:async';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/app/modules/zerocart_wallet/controllers/zerocart_wallet_controller.dart';

class CommonMethods extends GetxController {
  static final isConnect = false.obs;
  late Razorpay razorpay;


  Connectivity connectivity = Connectivity();

  static Future<bool> checkResponse({required http.Response response,
    bool wantShowSuccessResponse = false,
    bool wantShowFailResponse = false,
    bool wantInternetFailResponse = false}) async {
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    if (await MyCommonMethods.internetConnectionCheckerMethod()) {
      if (response.statusCode == StatusCodeConstant.OK) {
        if (wantShowSuccessResponse) {
          MyCommonMethods.showSnackBar(
              message: responseMap[ApiKeyConstant.message],
              context: Get.context!);
        }
        return true;
      } else if (response.statusCode == StatusCodeConstant.BAD_REQUEST) {
        if (wantShowFailResponse) {
          MyCommonMethods.showSnackBar(
              message: responseMap[ApiKeyConstant.message],
              context: Get.context!);
        }
        return false;
      } else if (response.statusCode == StatusCodeConstant.BAD_GATEWAY) {
        /*MyCommonMethods.showSnackBar(
            message: "Something went wrong", context: Get.context!);*/
        return false;
      } else if (response.statusCode == StatusCodeConstant.REQUEST_TIMEOUT) {
        /*MyCommonMethods.showSnackBar(
            message: "Something went wrong", context: Get.context!);*/
        return false;
      } else {
        /*MyCommonMethods.showSnackBar(
            message: "Something went wrong", context: Get.context!);*/
        return false;
      }
    } else {
      /*if (wantInternetFailResponse) {
        MyCommonMethods.showSnackBar(
            message: "Check Your Internet Connection",
            context: Get.context!,
            duration: const Duration(seconds: 4));
      }*/
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  static Future<void> getNetworkConnectionType() async {
    ConnectivityResult connectivityResult;
    CommonMethods commonMethods = CommonMethods();
    try {
      connectivityResult =
      await (commonMethods.connectivity.checkConnectivity());
      return commonMethods.updateConnectionState(connectivityResult);
      // ignore: empty_catches
    } on PlatformException catch (e) {
      // handle e here
    }
  }

  void updateConnectionState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        update();
        break;
      case ConnectivityResult.mobile:
        update();
        break;
      case ConnectivityResult.none:
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  static checkNetworkConnection() {
    CommonMethods commonMethods = CommonMethods();
    final networkConnection = false.obs;
    return commonMethods.connectivity.onConnectivityChanged.listen((event) async {
      // ignore: void_checks
      networkConnection.value =
      await MyCommonMethods.internetConnectionCheckerMethod();
      if (networkConnection.value) {
        isConnect.value = true;
      } else {
        isConnect.value = false;
        MyCommonMethods.showSnackBar(
          message: "Check Your Internet Connection",
          context: Get.context!,
          duration: const Duration(seconds: 5),
        );
      }
      return commonMethods.updateConnectionState(event);
    });
  }

  static bool changeTheAbsorbingValueTrue() {
    return true;
  }

  static bool changeTheAbsorbingValueFalse() {
    return false;
  }

  static Future<void> setUserData({UserData? userData}) async {
    if (userData != null) {
      await MyCommonMethods.setString(key: UserDataKeyConstant.customerId, value: userData.customer?.customerId ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.fullName, value: userData.customer?.fullName ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.email, value: userData.customer?.email ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.mobile, value: userData.customer?.mobile ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.securityEmail, value: userData.customer?.securityEmail ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.securityPhone, value: userData.customer?.securityPhone ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.securityPhoneCountryCode, value: userData.customer?.securityPhoneCountryCode ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.lastUpdate, value: userData.customer?.updatedDate ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.profilePicture, value: userData.customer?.profilePicture ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.dob, value: userData.customer?.dob ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.walletAmount, value: userData.customer?.walletAmount ?? "0.00");

      await MyCommonMethods.setString(key: UserDataKeyConstant.progress, value: userData.customer?.progress ?? "0");

      await MyCommonMethods.setString(key: UserDataKeyConstant.deviceType, value: userData.customer?.deviceType ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.brandPreferenceName, value: userData.customer?.brandPreferenceName ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.brandPreferences, value: userData.customer?.brandPreferences ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.categoryPreferences, value: userData.customer?.categoryPreferences ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.selectedState, value: userData.customer?.stateName ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.selectedCity, value: userData.customer?.cityName ?? "");

      await MyCommonMethods.setString(key: ApiKeyConstant.stateId, value: userData.customer?.stateId ?? "");

      await MyCommonMethods.setString(key: UserDataKeyConstant.genderPreferences, value: userData.customer?.genderPreferences ?? "");

      String? token = await MyCommonMethods.getString(key: 'token');
      print("token:::::$token");
    }
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    Map<String, dynamic>? userDataMap;
    userDataMap = {

      UserDataKeyConstant.customerId: await MyCommonMethods.getString(key: UserDataKeyConstant.customerId),

      UserDataKeyConstant.fullName: await MyCommonMethods.getString(key: UserDataKeyConstant.fullName),

      UserDataKeyConstant.email: await MyCommonMethods.getString(key: UserDataKeyConstant.email),

      UserDataKeyConstant.mobile: await MyCommonMethods.getString(key: UserDataKeyConstant.mobile),

      UserDataKeyConstant.securityEmail: await MyCommonMethods.getString(key: UserDataKeyConstant.securityEmail),

      UserDataKeyConstant.securityPhone: await MyCommonMethods.getString(key: UserDataKeyConstant.securityPhone),

      UserDataKeyConstant.securityPhoneCountryCode: await MyCommonMethods.getString(key: UserDataKeyConstant.securityPhoneCountryCode),

      UserDataKeyConstant.lastUpdate: await MyCommonMethods.getString(key: UserDataKeyConstant.lastUpdate),

      UserDataKeyConstant.profilePicture: await MyCommonMethods.getString(key: UserDataKeyConstant.profilePicture),

      UserDataKeyConstant.dob: await MyCommonMethods.getString(key: UserDataKeyConstant.dob),

      UserDataKeyConstant.walletAmount: await MyCommonMethods.getString(key: UserDataKeyConstant.walletAmount),

      UserDataKeyConstant.deviceType: await MyCommonMethods.getString(key: UserDataKeyConstant.deviceType),

      UserDataKeyConstant.selectedCity: await MyCommonMethods.getString(key: UserDataKeyConstant.selectedCity),

      UserDataKeyConstant.selectedState: await MyCommonMethods.getString(key: UserDataKeyConstant.selectedState),

      ApiKeyConstant.stateId: await MyCommonMethods.getString(key: ApiKeyConstant.stateId),

      UserDataKeyConstant.brandPreferenceName: await MyCommonMethods.getString(key: UserDataKeyConstant.brandPreferenceName),

      UserDataKeyConstant.brandPreferences: await MyCommonMethods.getString(key: UserDataKeyConstant.brandPreferences),

      UserDataKeyConstant.categoryPreferences: await MyCommonMethods.getString(key: UserDataKeyConstant.categoryPreferences),

      UserDataKeyConstant.categoryPreferenceName: await MyCommonMethods.getString(key: UserDataKeyConstant.categoryPreferenceName),

      ApiKeyConstant.genderPreferences: await MyCommonMethods.getString(key: ApiKeyConstant.genderPreferences),
    };

    if (userDataMap.isNotEmpty) {
      return userDataMap;
    } else {
      return null;
    }
  }

  static getSize({required BuildContext context}) {
    double availableHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return availableHeight;
  }

  static String imageUrl({required String url}) {
    Uri convertUrl = Uri.parse(url);
    String convertMainUrl = convertUrl.toString();
    if (convertMainUrl.contains('https://')) {
      return convertMainUrl;
    } else {
      return ApiConstUri.baseUrl + convertMainUrl;
    }
  }

  /*static String imageUrlDefault({required String url}) {
    Uri convertUrl = Uri.parse(url);
    String convertMainUrl = convertUrl.toString();
    if (convertMainUrl.contains('https://')) {
      return convertMainUrl;
    } else {
      return 'http://zerocart.dollopinfotech.com/$convertMainUrl';
    }
  }*/


  OpenGetWayType? openGetWayType ;
  String priceValue = "";
  String transId = "";
  String razorpayKeyName = "rzp_test_sBIiiURrNWQRTc";
  String razorpayKeyPassword = "UeGbEmzqYSb3tBjT7Mcphb2V";
  bool inAmt=true;
  bool cancelOrder=false;
  String inventory="";
  int itemQua=1;
  final response=false.obs;
  final userData = Rxn<UserData?>();
  Map<String, dynamic> bodyParametersForPlaceOrderApi = {};
  Map<String, dynamic> bodyParamsForWalletTransactionApi = {};

  Future<void> openGateway(
      {required OpenGetWayType type ,
      required int priceValue,String? description,bool inAmt=true,bool cancelOrder=false,
        String inventoryId="",int itemQuantity=1,
      }) async {
    openGetWayType = type;
    this.priceValue = priceValue.toString();
    this.inAmt=inAmt;
    this.cancelOrder=cancelOrder;
    inventory=inventoryId;
    itemQua=itemQuantity;
    String userName = await MyCommonMethods.getString(key: UserDataKeyConstant.fullName) ?? "";
    String userEmail = await MyCommonMethods.getString(key: UserDataKeyConstant.email) ?? "";
    String userMobile = await MyCommonMethods.getString(key: UserDataKeyConstant.mobile) ?? "";
    var option = {
      'key': razorpayKeyName,
      'amount': priceValue * 100,
      'name': userName,
      'description': description ??"",
      'timeout': 60 * 2,
      'prefill': {'contect': userMobile, 'email': userEmail},
    };
    razorpay.open(option);
  }


  _handlePaymentSuccess(PaymentSuccessResponse paymentSuccessResponse) async {
    transId = paymentSuccessResponse.paymentId ?? "";
    if (openGetWayType == OpenGetWayType.cart) {
      cartPayment();
    } else if (openGetWayType == OpenGetWayType.buyNow) {
      buyNowPayment();
    } else {
      await addManyToWalletPayment();
    }
  }

  Future<void> cartPayment() async{
    var userMeasurement = await MyCommonMethods.getString(key: "measurement");
    bodyParametersForPlaceOrderApi = {
      ApiKeyConstant.paymentMode: "Online",
      ApiKeyConstant.transId: transId,
      ApiKeyConstant.isCart: '1',
      ApiKeyConstant.userMeasurement : userMeasurement,
    };
    final cartController=Get.find<MyCartController>();
    cartController.getCartDetailsModel.value=null;
    bool isSuccess=await placeOrderApiCalling();
    if(isSuccess)
    {
      MyCommonMethods.showSnackBar(message: "Your order has been placed successfully", context: Get.context!);
    }//                                      
    cartController.getCartDetailsModelApiCalling();
    bodyParametersForPlaceOrderApi.clear();
  }

  Future<void> buyNowPayment() async{
    var userMeasurement = await MyCommonMethods.getString(key: "measurement");
    bodyParametersForPlaceOrderApi={
      ApiKeyConstant.paymentMode:"Online",
      ApiKeyConstant.transId:transId,
      ApiKeyConstant.isCart:'0',
      ApiKeyConstant.inventoryId:inventory,
      ApiKeyConstant.userMeasurement : userMeasurement,
      ApiKeyConstant.quantity:itemQua.toString(),
    };
   bool isSuccess= await placeOrderApiCalling();
    bodyParametersForPlaceOrderApi.clear();
    if(isSuccess){
      MyCommonMethods.showSnackBar(message: "Your order has been placed successfully", context: Get.context!);
    }
  }

  Future<void> addManyToWalletPayment() async {
    if (transId.isNotEmpty) {
      await walletTransactionApiCalling();
      await getUserProfileApiCalling();
      final zerocartWalletController =Get.find<ZerocartWalletController>();
      zerocartWalletController.addMoneyController.text="";
      zerocartWalletController.isAddedMoney.value=false;
      await zerocartWalletController.getCustomerWalletHistoryApiCalling();
    }
  }

  Future<bool> placeOrderApiCalling() async {
    http.Response? response = await CommonApis.placeOrderApi(
        bodyParams: bodyParametersForPlaceOrderApi);
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> walletTransactionApiCalling() async {
    if (inAmt) {
      if (cancelOrder) {
        bodyParamsForWalletTransactionApi = {
          ApiKeyConstant.transType: "credit",
          ApiKeyConstant.inAmt: priceValue,
          ApiKeyConstant.transId: transId,
          ApiKeyConstant.actionType: "order cancel"
        };
      } else {
        bodyParamsForWalletTransactionApi = {
          ApiKeyConstant.transType: "credit",
          ApiKeyConstant.inAmt: priceValue,
          ApiKeyConstant.transId: transId,
          ApiKeyConstant.actionType: "addMoney"
        };
      }
    } else {
      bodyParamsForWalletTransactionApi = {
        ApiKeyConstant.transType: "debit",
        ApiKeyConstant.outAmt: priceValue,
        ApiKeyConstant.transId: transId,
        ApiKeyConstant.actionType: "order Item"
      };
    }

    http.Response? response = await CommonApis.walletTransactionApi(bodyParams: bodyParamsForWalletTransactionApi);
    if (response != null)
    {

    }
    bodyParamsForWalletTransactionApi.clear();
  }

  Future<void> getUserProfileApiCalling() async {
    userData.value = await CommonApis.getUserProfileApi();
    if (userData.value != null) {
      await CommonMethods.setUserData(userData: userData.value);
    }
  }

  _handlePaymentError(PaymentFailureResponse paymentFailureResponse) {
    razorpay.clear();
  }

  _handleExternalWallet() {}

}

 enum OpenGetWayType{
  cart,
  buyNow,
  addMoneyWallet
 }
