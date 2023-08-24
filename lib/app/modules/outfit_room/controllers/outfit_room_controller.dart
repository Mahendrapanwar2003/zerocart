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

class OutfitRoomController extends GetxController {
  final count = 0.obs;
  double? bottomHeight = Get.arguments ?? 80.px;
  String upperId = '';
  String lowerId = '';
  String shoeId = '';
  String productsIds = '';

  final isAddToCartButtonClicked = false.obs;
  final absorbing = false.obs;

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

  final getOutfitRoomListApiModel = Rxn<GetOutfitRoomListApiModel>();
  Map<String, dynamic> bodyParams = {};
  List<OutfitRoomList>? outfitRoomList;
  List<PorductDetail>? porductDetailUpper;
  List<PorductDetail>? porductDetailLower;
  List<PorductDetail>? porductDetailShoe;
  List<PorductDetail>? porductDetailAccessories;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingGetOutfitRoomListApi();
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

  Future<void> clickOnUpperImage() async {
    if (porductDetailUpper != null && porductDetailUpper!.isNotEmpty) {
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
    if (porductDetailLower != null && porductDetailLower!.isNotEmpty) {
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
    if (porductDetailShoe != null && porductDetailShoe!.isNotEmpty) {
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
    if (porductDetailAccessories != null &&
      porductDetailAccessories!.isNotEmpty) {
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
    if (porductDetailUpper?[index].thumbnailImage != null &&
        porductDetailUpper![index].thumbnailImage!.isNotEmpty) {
      upperImagePath.value = CommonMethods.imageUrl(url: porductDetailUpper![index].thumbnailImage.toString());
    }

    if (porductDetailUpper?[index].outfitRoomId != null) {
      upperId = porductDetailUpper![index].outfitRoomId.toString();
      print("upperId:::::::::::::::::::::::$upperId");
    }
  }

  void clickOnListHorizontalOfLowerImage({required int index}) {
    currentIndexOfLowerImageList.value = index;

    if (porductDetailLower?[index].thumbnailImage != null &&
        porductDetailLower![index].thumbnailImage!.isNotEmpty) {
      lowerImagePath.value = CommonMethods.imageUrl(url: porductDetailLower![index].thumbnailImage.toString());
    }

    if (porductDetailLower?[index].outfitRoomId != null) {
      lowerId = porductDetailLower![index].outfitRoomId.toString();
      print("lowerId:::::::::::::::::::::::$lowerId");
    }
  }

  void clickOnListHorizontalOfShoeImage({required int index}) {
    currentIndexOfShoeImageList.value = index;

    if (porductDetailShoe?[index].thumbnailImage != null &&
        porductDetailShoe![index].thumbnailImage!.isNotEmpty) {
      shoeImagePath.value = CommonMethods.imageUrl(url: porductDetailShoe![index].thumbnailImage.toString());
    }

    if (porductDetailShoe?[index].outfitRoomId != null) {
      shoeId = porductDetailShoe![index].outfitRoomId.toString();
    }
  }

  void clickOnListHorizontalOfAccessoriesImage({required int index}) {
    if (porductDetailAccessories != null &&
        porductDetailAccessories!.isNotEmpty) {
      if (porductDetailAccessories?[index].thumbnailImage != null &&
          porductDetailAccessories![index].thumbnailImage!.isNotEmpty &&
          porductDetailAccessories?[index].outfitRoomId != null) {
        accessoriesImageListIds.add(porductDetailAccessories![index].outfitRoomId.toString());
        accessoriesImageList.add(CommonMethods.imageUrl(url: porductDetailAccessories![index].thumbnailImage.toString()));
        print(":::::::::::::::::::::::$accessoriesImageListIds");
      }
    }
  }

  Future<void> callingGetOutfitRoomListApi() async {
    absorbing.value = true;

    getOutfitRoomListApiModel.value = await CommonApis.getOutfitRoomListApi();
    if (getOutfitRoomListApiModel.value != null) {
      outfitRoomList = getOutfitRoomListApiModel.value?.outfitRoomList;
      if (outfitRoomList != null && outfitRoomList!.isNotEmpty) {
        outfitRoomList?.forEach((element) {
          String receivedJson = element.porductDetail.toString();
          Iterable l = json.decode(receivedJson);

          if (element.categoryTypeName == 'Upper') {
            porductDetailUpper = List<PorductDetail>.from(
                l.map((model) => PorductDetail.fromJson(model)));
            if (porductDetailUpper != null && porductDetailUpper!.isNotEmpty) {
              if (porductDetailUpper?[0].thumbnailImage != null &&
                  porductDetailUpper![0].thumbnailImage!.isNotEmpty) {
                upperImagePath.value = CommonMethods.imageUrl(
                    url: porductDetailUpper![0].thumbnailImage.toString());
              }
              if (porductDetailUpper?[0].outfitRoomId != null) {
                upperId = porductDetailUpper![0].outfitRoomId.toString();
                print(":::::::::::::::::::::::$upperId");
              }
            }
          }

          if (element.categoryTypeName == 'Lower') {
            porductDetailLower = List<PorductDetail>.from(
                l.map((model) => PorductDetail.fromJson(model)));
            if (porductDetailLower != null && porductDetailLower!.isNotEmpty) {
              if (porductDetailLower?[0].thumbnailImage != null &&
                  porductDetailLower![0].thumbnailImage!.isNotEmpty) {
                lowerImagePath.value = CommonMethods.imageUrl(
                    url: porductDetailLower![0].thumbnailImage.toString());
              }
              if (porductDetailLower?[0].outfitRoomId != null) {
                lowerId = porductDetailLower![0].outfitRoomId.toString();
                print(":::::::::::::::::::::::$lowerId");
              }
            }
          }

          if (element.categoryTypeName == 'Shoe') {
            porductDetailShoe = List<PorductDetail>.from(
                l.map((model) => PorductDetail.fromJson(model)));
            if (porductDetailShoe != null && porductDetailShoe!.isNotEmpty) {
              if (porductDetailShoe?[0].thumbnailImage != null &&
                  porductDetailShoe![0].thumbnailImage!.isNotEmpty) {
                shoeImagePath.value = CommonMethods.imageUrl(
                    url: porductDetailShoe![0].thumbnailImage.toString());
              }
              if (porductDetailShoe?[0].outfitRoomId != null) {
                shoeId = porductDetailShoe![0].outfitRoomId.toString();
              }
            }
          }

          if (element.categoryTypeName == 'Accessories') {
            porductDetailAccessories = List<PorductDetail>.from(
                l.map((model) => PorductDetail.fromJson(model)));
          }
        });
      }
    }
    absorbing.value = false;
  }

  Future<void> clickOnBrowserMoreButton() async {
    await callingApiAndClearDataMethod(deleteControllerValue: true);
  }

  Future<void> clickOnAddToCartButton() async {
    isAddToCartButtonClicked.value = true;
    print("upperId:::::::::::::::::::$upperId");
    print("lowerId:::::::::::::::::::$lowerId");
    print("shoeId:::::::::::::::::::$shoeId");
    print("accessoriesImageListIds:::::::::::::::::::$accessoriesImageListIds");
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
    getOutfitRoomListApiModel.value = null;
    outfitRoomList?.clear();
    porductDetailUpper?.clear();
    porductDetailLower?.clear();
    porductDetailShoe?.clear();
    porductDetailAccessories?.clear();
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
      selectedIndex.value = 3;
      //await Get.toNamed(Routes.MY_CART,arguments: true);
      callingGetOutfitRoomListApi();
    }
  }
}
