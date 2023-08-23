import 'dart:convert';
import 'dart:io';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/dashboard_detail_model.dart';
import 'package:zerocart/app/apis/api_modals/get%20_recent_product_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_addresses_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_all_brand_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_all_fashion_category_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_apply_coupon_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_banner_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_buy_now_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_cancel_order_reason_model.dart';
import 'package:zerocart/app/apis/api_modals/get_cart_details_model.dart';
import 'package:zerocart/app/apis/api_modals/get_categories_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_city_model.dart';
import 'package:zerocart/app/apis/api_modals/get_connection_detail_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_connection_list_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_customer_measurement_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_filter_list_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_order_list_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_outfit_room_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_product_detail_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_product_list_api_model.dart';
import 'package:zerocart/app/apis/api_modals/get_product_list_home_model.dart';
import 'package:zerocart/app/apis/api_modals/get_review_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_state_model.dart';
import 'package:zerocart/app/apis/api_modals/get_wallet_history_modal.dart';
import 'package:zerocart/app/apis/api_modals/get_wishlist_modal.dart';
import 'package:zerocart/app/apis/api_modals/my_order_detail_model.dart';
import 'package:zerocart/app/apis/api_modals/search_product_model.dart';
import 'package:zerocart/app/apis/api_modals/search_product_suggestion_model.dart';
import 'package:zerocart/app/apis/api_modals/user_data_modal.dart';
import 'package:http/http.dart' as http;
import 'package:zerocart/app/common_methods/common_methods.dart';
import '../api_modals/get_notification_api_model.dart';

class CommonApis {
  static Future<UserData?> signInWithGoogle({
    required Map<String, dynamic> bodyParams,
  }) async {
    UserData? userData;
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointGoogleSignUpApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        userData = UserData.fromJson(jsonDecode(response.body));
        return userData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<StateModel?> getStateApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    StateModel? stateModel;
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetStateApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(
        response: response,
      )) {
        stateModel = StateModel.fromJson(jsonDecode(response.body));
        return stateModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<CityModel?> getCityApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    CityModel? cityModel;
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetCityApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        cityModel = CityModel.fromJson(jsonDecode(response.body));
        return cityModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetAllBrandListApiModel?> getAllBrandListApi() async {
    GetAllBrandListApiModel? getAllBrandListApiModel;
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!, url: ApiConstUri.endPointGetAllBrandListApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getAllBrandListApiModel =
            GetAllBrandListApiModel.fromJson(jsonDecode(response.body));
        return getAllBrandListApiModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetAllFashionCategoryListApiModel?>
      getAllFashionCategoryListApi() async {
    GetAllFashionCategoryListApiModel? getAllFashionCategoryListApiModel;
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!,
        url: ApiConstUri.endPointGetAllFashionCategoryListApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getAllFashionCategoryListApiModel =
            GetAllFashionCategoryListApiModel.fromJson(
                jsonDecode(response.body));
        return getAllFashionCategoryListApiModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UserData?> registrationApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    UserData? userData;
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointRegistrationApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        userData = UserData.fromJson(jsonDecode(response.body));
        await MyCommonMethods.setString(
            key: ApiKeyConstant.token, value: userData.customer!.token!);
        return userData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> sendOtpApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointSendOtpApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> matchOtpApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
        url: ApiConstUri.endPointMatchOtpApi,
        bodyParams: bodyParams,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantInternetFailResponse: true,
          wantShowFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UserData?> loginApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    UserData? userData;
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointLoginApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      userData = UserData.fromJson(jsonDecode(response.body));
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        await MyCommonMethods.setString(
            key: ApiKeyConstant.token, value: userData.customer!.token!);
        return userData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> resetPasswordApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointResetPasswordApi,
      bodyParams: bodyParams,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> changePasswordApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
        url: ApiConstUri.endPointChangePasswordApi,
        bodyParams: bodyParams,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> updateFcmIdApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);

    Map<String, String> authorization = {};
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointUpdateFcmIdApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<UserData?> getUserProfileApi() async {
    UserData? userData;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetUserDataApi,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        userData = UserData.fromJson(jsonDecode(response.body));
        return userData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> updateUserProfile({
    required Map<String, dynamic> bodyParams,
    File? image,
  }) async {
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    http.Response? response = await MyHttp.multipartRequest(
        url: ApiConstUri.endPointUpdateCustomerProfileApi,
        multipartRequestType: "POST",
        bodyParams: bodyParams,
        token: token ?? "",
        image: image,
        userProfileImageKey: ApiKeyConstant.profilePicture,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<DashboardDetailModel?> dashboardDetailApi() async {
    DashboardDetailModel? dashboardDetailModel;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointDashboardDetailApi,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        dashboardDetailModel =
            DashboardDetailModel.fromJson(jsonDecode(response.body));
        return dashboardDetailModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetBanner?> getBannerApi() async {
    GetBanner getBanner;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetBannerApi,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getBanner = GetBanner.fromJson(jsonDecode(response.body));
        return getBanner;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetCategories?> getCategoryApi() async {
    GetCategories? getCategories;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetCategoryApi,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCategories = GetCategories.fromJson(jsonDecode(response.body));
        return getCategories;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetProductListApiModel?> getCategoryProductApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetProductListApiModel? getProductListApiModel;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductListApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getProductListApiModel =
            GetProductListApiModel.fromJson(jsonDecode(response.body));
        return getProductListApiModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetFilterModal?> getCategoryProductFilterApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetFilterModal? getFilterModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetFilterCategoriesApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getFilterModal = GetFilterModal.fromJson(jsonDecode(response.body));
        return getFilterModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetFilterListModal?> getCategoryProductFilterListApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetFilterListModal? getFilterListModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetFilterCategoriesListApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getFilterListModal =
            GetFilterListModal.fromJson(jsonDecode(response.body));
        return getFilterListModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetProductDetailModel?> getCategoryProductDetailApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetProductDetailModel? productDetailModel;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductDetailApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        productDetailModel =
            GetProductDetailModel.fromJson(jsonDecode(response.body));
        return productDetailModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> searchRecentProductApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointSearchRecentProductApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> manageCartApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointManageCartApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetCartDetailsModel?> getCartDetailsApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetCartDetailsModel? getCartDetailsModel;
    Map<String, String> authorization = {};

    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        baseUri: ApiConstUri.baseUrlForGetMethod,
        authorization: authorization,
        context: Get.context!,
        queryParameters: queryParameters,
        endPointUri: ApiConstUri.endPointGetCartDetailsApi);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCartDetailsModel =
            GetCartDetailsModel.fromJson(jsonDecode(response.body));
        return getCartDetailsModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> removeCartItemApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointRemoveCartItemApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> cartItemSelectionApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.cartItemSelectionApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addToWishListApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointAddToWishListApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetWishlistModal?> getWishlistApi() async {
    GetWishlistModal? getWishlistModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetWishListApi,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getWishlistModal = GetWishlistModal.fromJson(jsonDecode(response.body));
        return getWishlistModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> removeWishlistItemApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.deleteMethod(
      url: ApiConstUri.endPointRemoveWishlistItemApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetApplyCouponModal?> applyCouponApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    GetApplyCouponModal? getApplyCouponModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointApplyCouponApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        getApplyCouponModal =
            GetApplyCouponModal.fromJson(jsonDecode(response.body));
        return getApplyCouponModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> placeOrderApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointPlaceOrderApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /*static Future<http.Response?> userProductFeedbackApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    http.Response? response = await MyHttp.multipartRequest(
      url: ApiConstUri.endPointUserProductFeedbackApi,
      bodyParams: bodyParams,
      context: Get.context!,
      multipartRequestType: 'POST',
      userProfileImageKey: ApiKeyConstant.reviewFile,
      token: token ?? "",
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }*/

  static Future<http.Response?> userProductFeedbackApi({
    required Map<String, dynamic> bodyParams,
    required List<File> imageList,
  }) async {
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    http.Response? response = await MyHttp.uploadMultipleImagesWithBody(
      images: imageList,
      uri: ApiConstUri.endPointUserProductFeedbackApi,
      bodyParams: bodyParams,
      context: Get.context!,
      multipartRequestType: 'POST',
      imageKey: ApiKeyConstant.reviewFile,
      token: token ?? "",
    );

    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetReviewModal?> getProductReviewApi(
      {required Map<String, dynamic> queryParameters}) async {
    GetReviewModal? getReviewModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        authorization: authorization,
        endPointUri: ApiConstUri.endPointGetProductReviewApi);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getReviewModal = GetReviewModal.fromJson(jsonDecode(response.body));
        return getReviewModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addCustomerAddressApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointAddCustomerAddressApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetCustomerAddresses?> getCustomerAddressApi({      required Map<String, dynamic> queryParameters,
  }) async {
    GetCustomerAddresses? getCustomerAddresses;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetCustomerAddressApi,
        queryParameters:queryParameters,
        authorization: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCustomerAddresses =
            GetCustomerAddresses.fromJson(jsonDecode(response.body));
        return getCustomerAddresses;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> setCustomerDefaultAddressApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointSetCustomerDefaultAddressApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> deleteCustomerAddressApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointDeleteCustomerAddressApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> userPrescriptionApi({File? image}) async {
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    http.Response? response = await MyHttp.multipartRequest(
      url: ApiConstUri.endPointUserPrescriptionApi,
      token: token!,
      image: image,
      bodyParams: {},
      multipartRequestType: 'POST',
      userProfileImageKey: 'prescription',
      context: Get.context!,
    );
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetConnectionListModal?> getConnectionListApi() async {
    GetConnectionListModal? getConnectionList;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetConnectionListApi,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getConnectionList =
            GetConnectionListModal.fromJson(jsonDecode(response.body));
        return getConnectionList;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetConnectionDetail?> getConnectionDetailApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetConnectionDetail? getConnectionDetail;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetConnectionDetailApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getConnectionDetail =
            GetConnectionDetail.fromJson(jsonDecode(response.body));
        return getConnectionDetail;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<RecentProduct?> getRecentProductApi(
      {required Map<String, dynamic> queryParameters}) async {
    RecentProduct? recentProduct;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: '172.188.16.156:8000',
        endPointUri: ApiConstUri.endPointGetRecentProductApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        recentProduct = RecentProduct.fromJson(jsonDecode(response.body));
        return recentProduct;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<RecentProduct?> getTopTrendingProductApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    RecentProduct? recentProduct;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: '172.188.16.156:8000',
        endPointUri: ApiConstUri.endPointGetTopTrendingProductApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        recentProduct = RecentProduct.fromJson(jsonDecode(response.body));
        return recentProduct;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<RecentProduct?> getTopTrendingProductApi2(
      {required Map<String, dynamic> queryParameters}) async {
    RecentProduct? recentProduct;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: '172.188.16.156:8000',
        endPointUri: ApiConstUri.endPointGetTopTrendingProductApi2);
    // ignore: unnecessary_null_comparison
    if (response != null) {

      if (await CommonMethods.checkResponse(response: response)) {
        recentProduct = RecentProduct.fromJson(jsonDecode(response.body));
        return recentProduct;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

    static Future<RecentProduct?> getProductDetailRecentApi2(
      {required Map<String, dynamic> queryParameters}) async {
    RecentProduct? recentProduct;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: '172.188.16.156:8000',
        endPointUri: ApiConstUri.endPointGetProductDetailApi2);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        recentProduct = RecentProduct.fromJson(jsonDecode(response.body));
        return recentProduct;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<SearchProductSuggestionModel?>
      getSearchProductListSuggestionApi(
          {required Map<String, dynamic> queryParameters}) async {
    SearchProductSuggestionModel? searchProductSuggestionModel;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductSuggestion);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        searchProductSuggestionModel =
            SearchProductSuggestionModel.fromJson(jsonDecode(response.body));
        return searchProductSuggestionModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<SearchProductModel?> getSearchProductListApi(
      {required Map<String, dynamic> queryParameters}) async {
    SearchProductModel? searchProductModel;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetAllProductListApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        searchProductModel =
            SearchProductModel.fromJson(jsonDecode(response.body));
        return searchProductModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //TODO This Code Comment By Aman
  /* static Future<GetRecentProductApiModel?> getRecentProductApi() async {
    GetRecentProductApiModel? getRecentProductApiModel;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!,
        token: authorization,
        url: ApiConstUri.endPointGetRecentProductApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getRecentProductApiModel =
            GetRecentProductApiModel.fromJson(jsonDecode(response.body));
        return getRecentProductApiModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

   static Future<TopTrendingApiModal?> getTopTrendingProductApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    TopTrendingApiModal? topTrendingApiModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetTopTrendingProductApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        topTrendingApiModal =
            TopTrendingApiModal.fromJson(jsonDecode(response.body));
        return topTrendingApiModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }*/

  //TODO sapan
  static Future<GetProductByInventoryApiModal?> getProductByInventoryApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetProductByInventoryApiModal? byInventoryApiModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductByInventoryApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        byInventoryApiModal =
            GetProductByInventoryApiModal.fromJson(jsonDecode(response.body));
        return byInventoryApiModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetOrderListApiModal?> getOrderListApi({
    required Map<String, dynamic> queryParameters,
  }) async {
    GetOrderListApiModal? getOrderListApiModal;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        queryParameters: queryParameters,
        authorization: authorization,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetOrderListApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getOrderListApiModal =
            GetOrderListApiModal.fromJson(jsonDecode(response.body));
        return getOrderListApiModal;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> cancelOrderApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};

    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointCancelOrderApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetNotificationApiModel?> getNotificationApi() async {
    GetNotificationApiModel? getNotificationApiModel;
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    Map<String, String> authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!,
        token: authorization,
        url: ApiConstUri.endPointGetNotificationApi);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getNotificationApiModel =
            GetNotificationApiModel.fromJson(jsonDecode(response.body));
        return getNotificationApiModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetWalletHistoryModel?> getCustomerWalletHistoryApi({required Map<String,dynamic> queryParameters}) async {
    GetWalletHistoryModel? getWalletHistoryModel;
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    Map<String, String> authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        authorization: authorization,
        queryParameters: queryParameters,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetCustomerWalletHistoryApi);
    if (response !=  null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getWalletHistoryModel =
            GetWalletHistoryModel.fromJson(jsonDecode(response.body));
        return getWalletHistoryModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> walletTransactionApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointWalletTransactionApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }






  static Future<http.Response?> addToOutfitRoomApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointAddToOutfitRoomApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetOutfitRoomListApiModel?> getOutfitRoomListApi() async {
    GetOutfitRoomListApiModel? getOutfitRoomListApiModel;
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    Map<String, String> authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!,
        token: authorization,
        url: ApiConstUri.endPointGetOutfitRoomListApi);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getOutfitRoomListApiModel =
            GetOutfitRoomListApiModel.fromJson(jsonDecode(response.body));
        return getOutfitRoomListApiModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> addOutfitToCartApi({
    required Map<String, dynamic> bodyParams,
  }) async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.postMethod(
      url: ApiConstUri.endPointAddOutfitToCartApi,
      bodyParams: bodyParams,
      token: authorization,
      context: Get.context!,
    );
    if (response != null) {
      if (await CommonMethods.checkResponse(
          response: response,
          wantShowFailResponse: true,
          wantInternetFailResponse: true)) {
        return response;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


  static Future<GetCustomerMeasurementApiModel?> getCustomerMeasurementApi() async {
    GetCustomerMeasurementApiModel? getCustomerMeasurementApiModel;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetCustomerMeasurementApi,
        token: authorization,
        context: Get.context!);
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCustomerMeasurementApiModel =
            GetCustomerMeasurementApiModel.fromJson(jsonDecode(response.body));
        return getCustomerMeasurementApiModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetProductListForHome?> getDefaultProductListApiForHome() async {
    GetProductListForHome? getProductListForHome;
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!, url: ApiConstUri.endPointGetDefaultProductListApi);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getProductListForHome =
            GetProductListForHome.fromJson(jsonDecode(response.body));
        return getProductListForHome;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetCancelOrderReasonList?> getCancelOrderReasonListApi() async {
    GetCancelOrderReasonList? getCancelOrderReasonList;
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        context: Get.context!, url: ApiConstUri.endPointGetCancelReasonListApi,token: authorization);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getCancelOrderReasonList = GetCancelOrderReasonList.fromJson(jsonDecode(response.body));
        return getCancelOrderReasonList;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<MyOrderDetailsModel?> getMyOrderDetailsApi({required Map<String,dynamic> queryParameters}) async {
    MyOrderDetailsModel? myOrderDetailsModel;
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    Map<String, String> authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethodForParams(
        context: Get.context!,
        authorization: authorization,
        queryParameters: queryParameters,
        baseUri: ApiConstUri.baseUrlForGetMethod,
        endPointUri: ApiConstUri.endPointGetProductSellerDetailApi);
    if (response !=  null) {
      if (await CommonMethods.checkResponse(response: response)) {
        myOrderDetailsModel =
            MyOrderDetailsModel.fromJson(jsonDecode(response.body));
        return myOrderDetailsModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

}
