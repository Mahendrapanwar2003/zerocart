import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/apis/api_constant/api_constant.dart';
import 'package:zerocart/app/apis/api_modals/get_outfit_room_list_api_model.dart';
import 'package:zerocart/app/apis/common_apis/common_apis.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';

class OutfitRoomController extends CommonMethods {
  final count = 0.obs;
  double? bottomHeight = Get.arguments ?? 80.px;
  String upperId = '';
  String lowerId = '';
  String shoeId = '';
  String productsIds = '';

  final isAddToCartButtonClicked = false.obs;

  int responseCode = 0;
  int load = 0;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;


  final currentIndexOfUpperImageList = 0.obs;
  final currentIndexOfLowerImageList = 0.obs;
  final currentIndexOfShoeImageList = 0.obs;

  final upperImageViewValue1 = true.obs;
  final lowerImageViewValue1 = false.obs;
  final shoeImageViewValue1 = false.obs;
  final accessoriesImageViewValue1 = false.obs;

  final upperImagePath = ''.obs;
  final lowerImagePath = ''.obs;
  final shoeImagePath = ''.obs;
  final accessoriesImageList = [].obs;
  final accessoriesImageListIds = [].obs;

  GetOutfitRoomListApiModel? getOutfitRoomListApiModel;
  Map<String, dynamic> bodyParams = {};
  List<OutfitRoomList> outfitRoomList = [];
  List<PorductDetail> productDetailUpper = [];
  List<PorductDetail> productDetailLower = [];
  List<PorductDetail> productDetailShoe = [];
  List<PorductDetail> productDetailAccessories = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    onReload();
    inAsyncCall.value = true;
    try {
      await callingGetOutfitRoomListApi();
    } catch (e) {
      responseCode = 100;
      MyCommonMethods.showSnackBar(
          message: "Something went wrong", context: Get.context!);
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

  void onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await MyCommonMethods.internetConnectionCheckerMethod()) {
        if (load == 0) {
          load = 1;
          await onInit();
        }
      } else {
        load = 0;
      }
    });
  }

  clickOnBackIcon() {
    Get.back();
  }

  Future<void> clickOnUpperImage() async {
    if (productDetailUpper.isNotEmpty) {
      upperImageViewValue1.value = true;
      lowerImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      lowerImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnLowerImage() async {
    if (productDetailLower.isNotEmpty) {
      lowerImageViewValue1.value = true;
      upperImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      upperImageViewValue1.value = false;
      shoeImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnShoeImage() async {
    if (productDetailShoe.isNotEmpty) {
      shoeImageViewValue1.value = true;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
    } else {
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      accessoriesImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  Future<void> clickOnGridViewAddImage() async {
    if (productDetailAccessories.isNotEmpty) {
      accessoriesImageViewValue1.value = true;
      shoeImageViewValue1.value = false;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
    } else {
      shoeImageViewValue1.value = false;
      upperImageViewValue1.value = false;
      lowerImageViewValue1.value = false;
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }
  }

  void clickOnUpperRemoveImage() {
    upperImagePath.value = '';
    upperId = '';
    currentIndexOfUpperImageList.value = -1;
  }

  void clickOnLowerRemoveImage() {
    lowerImagePath.value = '';
    lowerId = '';
    currentIndexOfLowerImageList.value = -1;
  }

  void clickOnShoeRemoveImage() {
    shoeImagePath.value = '';
    shoeId = '';
    currentIndexOfShoeImageList.value = -1;
  }

  void clickOnAccessoriesRemoveImage({required int index}) {
    accessoriesImageListIds.removeAt(index);
    accessoriesImageList.removeAt(index);
  }

  void clickOnListHorizontalOfUpperImage({required int index}) {
    currentIndexOfUpperImageList.value = index;
    if (productDetailUpper[index].thumbnailImage != null &&
        productDetailUpper[index].thumbnailImage!.isNotEmpty) {
      upperImagePath.value = CommonMethods.imageUrl(
          url: productDetailUpper[index].thumbnailImage.toString());
    }

    if (productDetailUpper[index].outfitRoomId != null) {
      upperId = productDetailUpper[index].outfitRoomId.toString();
    }
  }

  void clickOnListHorizontalOfLowerImage({required int index}) {
    currentIndexOfLowerImageList.value = index;

    if (productDetailLower[index].thumbnailImage != null &&
        productDetailLower[index].thumbnailImage!.isNotEmpty) {
      lowerImagePath.value = CommonMethods.imageUrl(
          url: productDetailLower[index].thumbnailImage.toString());
    }

    if (productDetailLower[index].outfitRoomId != null) {
      lowerId = productDetailLower[index].outfitRoomId.toString();
    }
  }

  void clickOnListHorizontalOfShoeImage({required int index}) {
    currentIndexOfShoeImageList.value = index;

    if (productDetailShoe[index].thumbnailImage != null &&
        productDetailShoe[index].thumbnailImage!.isNotEmpty) {
      shoeImagePath.value = CommonMethods.imageUrl(
          url: productDetailShoe[index].thumbnailImage.toString());
    }

    if (productDetailShoe[index].outfitRoomId != null) {
      shoeId = productDetailShoe[index].outfitRoomId.toString();
    }
  }

  void clickOnListHorizontalOfAccessoriesImage({required int index}) {
    if (productDetailAccessories.isNotEmpty) {
      if (productDetailAccessories[index].thumbnailImage != null &&
          productDetailAccessories[index].thumbnailImage!.isNotEmpty &&
          productDetailAccessories[index].outfitRoomId != null) {
        accessoriesImageListIds.add(
            productDetailAccessories[index].outfitRoomId.toString());
        accessoriesImageList.add(CommonMethods.imageUrl(
            url: productDetailAccessories[index].thumbnailImage.toString()));
      }
    }
  }

  Future<void> callingGetOutfitRoomListApi() async {
    Map<String, String> authorization = {};
    String? token = await MyCommonMethods.getString(key: ApiKeyConstant.token);
    authorization = {"Authorization": token!};
    http.Response? response = await MyHttp.getMethod(
        url: ApiConstUri.endPointGetOutfitRoomListApi,
        token: authorization,
        context: Get.context!);
    responseCode = response?.statusCode ?? 0;
    if (response != null) {
      if (await CommonMethods.checkResponse(response: response)) {
        getOutfitRoomListApiModel =
            GetOutfitRoomListApiModel.fromJson(jsonDecode(response.body));
        if (getOutfitRoomListApiModel != null &&
            getOutfitRoomListApiModel!.outfitRoomList != null &&
            getOutfitRoomListApiModel!.outfitRoomList!.isNotEmpty) {
          outfitRoomList = getOutfitRoomListApiModel!.outfitRoomList!;
          if (outfitRoomList.isNotEmpty) {
            outfitRoomList.forEach((element) {
              String receivedJson = element.porductDetail.toString();
              Iterable l = json.decode(receivedJson);
              if (element.categoryTypeName == 'Upper') {
                productDetailUpper = List<PorductDetail>.from(
                    l.map((model) => PorductDetail.fromJson(model)));
                if (productDetailUpper.isNotEmpty) {
                  if (productDetailUpper[0].thumbnailImage != null &&
                      productDetailUpper[0].thumbnailImage!.isNotEmpty) {
                    upperImagePath.value = CommonMethods.imageUrl(
                        url: productDetailUpper[0].thumbnailImage.toString());
                  }
                  if (productDetailUpper[0].outfitRoomId != null) {
                    upperId = productDetailUpper[0].outfitRoomId.toString();
                  }
                }
              }

              if (element.categoryTypeName == 'Lower') {
                productDetailLower = List<PorductDetail>.from(
                    l.map((model) => PorductDetail.fromJson(model)));
                if (productDetailLower.isNotEmpty) {
                  if (productDetailLower[0].thumbnailImage != null &&
                      productDetailLower[0].thumbnailImage!.isNotEmpty) {
                    lowerImagePath.value = CommonMethods.imageUrl(
                        url: productDetailLower[0].thumbnailImage.toString());
                  }
                  if (productDetailLower[0].outfitRoomId != null) {
                    lowerId = productDetailLower[0].outfitRoomId.toString();
                  }
                }
              }

              if (element.categoryTypeName == 'Shoe') {
                productDetailShoe = List<PorductDetail>.from(
                    l.map((model) => PorductDetail.fromJson(model)));
                if (productDetailShoe.isNotEmpty) {
                  if (productDetailShoe[0].thumbnailImage != null &&
                      productDetailShoe[0].thumbnailImage!.isNotEmpty) {
                    shoeImagePath.value = CommonMethods.imageUrl(
                        url: productDetailShoe[0].thumbnailImage.toString());
                  }
                  if (productDetailShoe[0].outfitRoomId != null) {
                    shoeId = productDetailShoe[0].outfitRoomId.toString();
                  }
                }
              }

              if (element.categoryTypeName == 'Accessories') {
                productDetailAccessories = List<PorductDetail>.from(
                    l.map((model) => PorductDetail.fromJson(model)));
              }
            });
          }
        }
      }
      increment();
    }
  }

    Future<void> clickOnBrowserMoreButton() async {
      await callingApiAndClearDataMethod(deleteControllerValue: true);
    }

    Future<void> clickOnAddToCartButton() async {
      isAddToCartButtonClicked.value = true;
      await callingAddOutFitToCartApi();
    }

    void clearAllData({bool accessoriesImageListValue = true}) {
      upperId = '';
      lowerId = '';
      productsIds = '';
      shoeId = '';
      currentIndexOfUpperImageList.value = 0;
      currentIndexOfLowerImageList.value = 0;
      currentIndexOfShoeImageList.value = 0;
      upperImagePath.value = '';
      lowerImagePath.value = '';
      shoeImagePath.value = '';
      if (accessoriesImageListValue) {
        accessoriesImageList.clear();
        accessoriesImageListIds.clear();
      }
      getOutfitRoomListApiModel = null;
      outfitRoomList.clear();
      productDetailUpper.clear();
      productDetailLower.clear();
      productDetailShoe.clear();
      productDetailAccessories.clear();
    }

    Future<void> callingAddOutFitToCartApi() async {
      List ids = [];

      if (upperId != '' && upperId.isNotEmpty) {
        ids.add(upperId);
      }

      if (lowerId != '' && lowerId.isNotEmpty) {
        ids.add(lowerId);
      }

      if (shoeId != '' && shoeId.isNotEmpty) {
        ids.add(shoeId);
      }

      for (var element in accessoriesImageListIds) {
        ids.add(element);
      }
      productsIds = ids.join(',');

      bodyParams = {
        ApiKeyConstant.outfitRoomId: productsIds,
      };

      http.Response? response =
      await CommonApis.addOutfitToCartApi(bodyParams: bodyParams);
      if (response != null) {
        await callingApiAndClearDataMethod();
        isAddToCartButtonClicked.value = false;
      } else {
        isAddToCartButtonClicked.value = false;
      }
    }

    Future<void> callingApiAndClearDataMethod(
        {bool deleteControllerValue = false}) async {
      if (deleteControllerValue) {
        clearAllData(accessoriesImageListValue: false);
        selectedIndex.value = 2;
        // await Get.toNamed(Routes.CATEGORY,arguments: true,);
        callingGetOutfitRoomListApi();
      } else {
        clearAllData();
        await Get.delete<MyCartController>();
        Get.lazyPut<MyCartController>(
              () => MyCartController(),
        );
        //selectedIndex.value = 3;
        //await Get.toNamed(Routes.MY_CART,arguments: true);
        callingGetOutfitRoomListApi();
      }
    }

  onRefresh() async {
    await onInit();
  }
  }
