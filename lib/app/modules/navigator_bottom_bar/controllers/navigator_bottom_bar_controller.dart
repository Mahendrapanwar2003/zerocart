import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/modules/category/controllers/category_controller.dart';
import 'package:zerocart/app/modules/category/views/category_view.dart';
import 'package:zerocart/app/modules/home/controllers/home_controller.dart';
import 'package:zerocart/app/modules/home/views/home_view.dart';
import 'package:zerocart/app/modules/my_cart/controllers/my_cart_controller.dart';
import 'package:zerocart/app/modules/my_cart/views/my_cart_view.dart';
import 'package:zerocart/app/modules/outfit_room/controllers/outfit_room_controller.dart';
import 'package:zerocart/app/modules/outfit_room/views/outfit_room_view.dart';
import 'package:zerocart/app/modules/profile_menu/controllers/profile_menu_controller.dart';
import 'package:zerocart/app/modules/profile_menu/views/profile_menu_view.dart';
final selectedIndex = 0.obs;

class NavigatorBottomBarController extends GetxController {

  final count = 0.obs;
  final absorbing = false.obs;
  bool callGetCartApi=true;



  @override
  void onInit() {
    super.onInit();
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

  Future<bool> onWillPop()  async {
    if (selectedIndex.value == 0) {
      return true;
    }
    selectedIndex.value = 0;
    return false;
  }

  void clickOnBottomNavigator({required int index}) {
    selectedIndex.value = index;
  }

  Widget getBody() {
        increment();
    switch (selectedIndex.value) {
      case 0:
        Get.delete<HomeController>();
        Get.lazyPut<HomeController>(
              () => HomeController(),
        );
        HomeController homeController = Get.find();
        return const HomeView();
      case 1:
        Get.delete<OutfitRoomController>();
        Get.lazyPut<OutfitRoomController>(
              () => OutfitRoomController(),
        );
        OutfitRoomController outfitRoomController = Get.find();
        return const OutfitRoomView();
      case 2:
        Get.delete<CategoryController>();
        Get.lazyPut<CategoryController>(
              () => CategoryController(),
        );
        CategoryController categoryController = Get.find();
        return const CategoryView();
      case 3:
        Get.delete<MyCartController>();
        Get.lazyPut<MyCartController>(
              () => MyCartController(),
        );
        MyCartController myCartController = Get.find();
        return  MyCartView();
      case 4:
        Get.delete<ProfileMenuController>();
        Get.lazyPut<ProfileMenuController>(
              () => ProfileMenuController(),
        );
        ProfileMenuController profileMenuController = Get.find();
        return const ProfileMenuView();
      default:
        return const SizedBox();
    }
  }

  void clickOnCategoryBottom() {
    selectedIndex.value = 2;
  }


}


/*
  case 1:
      WishlistController wishlistController = Get.find();
        callGetCartApi=true;
        wishlistController.getWishlistApiCalling();
        return const WishlistView();
      case 2:
        CategoryController categoryController = Get.find();
        callGetCartApi=true;
        categoryController.callingGetCategoriesApi();
        return const CategoryView();
      case 4:
        MyCartController myCartController = Get.find();
        if(callGetCartApi)
        {
          myCartController.setEmpty();
          if(CommonMethods.isConnect.value)
          {
            myCartController.getCartDetailsModelApiCalling();
          }
          callGetCartApi=false;
        }
        return  MyCartView();
      case 5:
        ProfileMenuController profileMenuController = Get.find();
        callGetCartApi=true;
        return const ProfileMenuView();
      default:
        return const SizedBox();
        */