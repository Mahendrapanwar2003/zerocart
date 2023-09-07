import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/modules/navigator_bottom_bar/controllers/navigator_bottom_bar_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'dart:ui';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';

class NavigatorBottomBarView extends GetView<NavigatorBottomBarController> {
  const NavigatorBottomBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return WillPopScope(
        onWillPop: () => controller.onWillPop(),
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: controller.getBody(),
            extendBody: true,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: myBottomBar(),
          ),
        ),
      );
    });
  }

  Widget myBottomBar() {
    return Obx(() {
      controller.count.value;
      return  Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.px, sigmaY: 5.px),
                    child: Container(
                      color: Theme.of(Get.context!).brightness ==
                              Brightness.dark
                          ? MyColorsDark().bottomBarColor.withOpacity(0.5.px)
                          : MyColorsLight().bottomBarColor.withOpacity(0.5.px),
                      height: 66.px,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              gradiantLineView(),
                              SizedBox(width: 94.px),
                              gradiantLineView(),
                            ],
                          ),
                          const Spacer(),
                          customBottomNavigationBar(),
                          SizedBox(height: 12.px),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.px),
                  child: categoryBottomView(),
                ),
              ],
            );
    });
  }

  Widget gradiantLineView() => Container(
        width: 74.px,
        height: 1.6.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.px),
          gradient: CommonWidgets.commonLinearGradientView(),
        ),
      );

  Tab homeBottomView() => Tab(
        icon: Container(
          width: 18.px,
          height: 20.px,
          decoration: selectedIndex.value == 0
              ? BoxDecoration(
                  image: DecorationImage(
                    image: homeGradiantImageView(),
                  ),
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image: Theme.of(Get.context!).brightness == Brightness.dark
                        ? homeWhiteImageView()
                        : homeBlackImageView(),
                  ),
                ),
        ),
      );

  ImageProvider homeGradiantImageView() =>
      const AssetImage("assets/home_gradient.png");

  ImageProvider homeWhiteImageView() =>
      const AssetImage("assets/home_white.png");

  ImageProvider homeBlackImageView() =>
      const AssetImage("assets/home_black.png");

  Tab outfitBottomView() => Tab(
        icon: Container(
          width: 22.93.px,
          height: 20.px,
          decoration: selectedIndex.value == 1
              ? BoxDecoration(
                  image: DecorationImage(image: outfitGradiantImageView()),
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image: Theme.of(Get.context!).brightness == Brightness.dark
                        ? outfitWhiteImageView()
                        : outfitBlackImageView(),
                  ),
                ),
        ),
      );

  ImageProvider outfitGradiantImageView() =>
      const AssetImage("assets/outfit_gradient.png");

  ImageProvider outfitWhiteImageView() =>
      const AssetImage("assets/outfit_white.png");

  ImageProvider outfitBlackImageView() =>
      const AssetImage("assets/outfit_black.png");

  Widget categoryBottomView() => CommonWidgets.myElevatedButton(
      height: 70.px,
      width: 70.px,
      borderRadius: 35.px,
      text: SizedBox(height: 33.px, width: 33.px, child: categoryImageView()),
      onPressed: () => controller.clickOnCategoryBottom());

  Widget categoryImageView() => Image.asset("assets/categories_icon.png");

  Tab cartBottomView() => Tab(
        icon: Container(
          width: 20.95.px,
          height: 20.px,
          decoration: selectedIndex.value == 3
              ? BoxDecoration(
                  image: DecorationImage(
                    image: cartGradiantImageView(),
                  ),
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image: Theme.of(Get.context!).brightness == Brightness.dark
                        ? cartWhiteImageView()
                        : cartBlackImageView(),
                  ),
                ),
        ),
      );

  ImageProvider cartGradiantImageView() =>
      const AssetImage("assets/cart_gradient.png");

  ImageProvider cartWhiteImageView() =>
      const AssetImage("assets/cart_white.png");

  ImageProvider cartBlackImageView() =>
      const AssetImage("assets/cart_black.png");

  Tab emptyBottomView() => const Tab(icon: SizedBox());

  Tab profileBottomView() => Tab(
        icon: Container(
          width: 17.78.px,
          height: 20.px,
          decoration: selectedIndex.value == 4
              ? BoxDecoration(
                  image: DecorationImage(image: profileGradiantImageView()),
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image: Theme.of(Get.context!).brightness == Brightness.dark
                        ? profileWhiteImageView()
                        : profileBlackImageView(),
                  ),
                ),
        ),
      );

  ImageProvider profileGradiantImageView() =>
      const AssetImage("assets/user_gradient.png");

  ImageProvider profileWhiteImageView() =>
      const AssetImage("assets/user_white.png");

  ImageProvider profileBlackImageView() =>
      const AssetImage("assets/user_black.png");

  Widget customBottomNavigationBar() {
    return Theme(
      data: Theme.of(Get.context!).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: TabBar(
        tabs: [
          homeBottomView(),
          outfitBottomView(),
          emptyBottomView(),
          cartBottomView(),
          profileBottomView(),
        ],
        indicatorWeight: .001.px,
        onTap: (value) =>
            (value != 2) ? controller.clickOnBottomNavigator(index: value) : {},
      ),
    );
  }
}

/*
class NavigatorBottomBarView extends GetView<NavigatorBottomBarController> {
  const NavigatorBottomBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () => controller.onWillPop(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          extendBody: true,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: myBottomBar(),
          body: controller.getBody(),
        ),
      );
    });
  }

  Widget myBottomBar() {
    return Obx(() {
      return controller.count.value >= 0
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.px),
                    topRight: Radius.circular(10.px),
                  ),

                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.px, sigmaY: 8.px),
                    child: AspectRatio(
                      aspectRatio: 6.px / 1.px,
                      child: Container(
                        color: Theme.of(Get.context!)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4.px),
                        //height: 8.h,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                gradiantLineView(),
                                gradiantLineView(),
                              ],
                            ),
                            const Spacer(),
                            bottomNavigationBar(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.px),
                  child: categoryBottomView(),
                ),
              ],
            )
          : const SizedBox();
    });
  }

  Widget gradiantLineView() => Container(
        width: 74.px,
        height: 2.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.px),
          gradient: CommonWidgets.commonLinearGradientView(),
        ),
      );

  Widget bottomNavigationBar() => Theme(
        data: Theme.of(Get.context!).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Theme.of(Get.context!).colorScheme.onSurface,
          unselectedItemColor: Theme.of(Get.context!).colorScheme.onSurface,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            homeBottomView(),
            outfitBottomView(),
            emptyBottomView(),
            emptyBottomView(),
            cartBottomView(),
            profileBottomView(),
          ],
          onTap: (value) => controller.clickOnBottomNavigator(index: value),
        ),
      );

  BottomNavigationBarItem homeBottomView() => BottomNavigationBarItem(
      icon: Container(
        width: 18.px,
        height: 20.px,
        decoration: controller.selectedIndex.value == 0
            ? BoxDecoration(
                image: DecorationImage(
                  image: homeGradiantImageView(),
                ),
              )
            : BoxDecoration(
                image: DecorationImage(
                  image: Theme.of(Get.context!).brightness == Brightness.dark
                      ? homeWhiteImageView()
                      : homeBlackImageView(),
                ),
              ),
      ),
      label: '');

  ImageProvider homeGradiantImageView() =>
      const AssetImage("assets/home_gradient.png");

  ImageProvider homeWhiteImageView() =>
      const AssetImage("assets/home_white.png");

  ImageProvider homeBlackImageView() =>
      const AssetImage("assets/home_black.png");

  BottomNavigationBarItem cartBottomView() => BottomNavigationBarItem(
      icon: Container(
        width: 20.95.px,
        height: 20.px,
        decoration: controller.selectedIndex.value == 4
            ? BoxDecoration(
                image: DecorationImage(
                  image: cartGradiantImageView(),
                ),
              )
            : BoxDecoration(
                image: DecorationImage(
                  image: Theme.of(Get.context!).brightness == Brightness.dark
                      ? cartWhiteImageView()
                      : cartBlackImageView(),
                ),
              ),
      ),
      label: '');

  ImageProvider cartGradiantImageView() =>
      const AssetImage("assets/cart_gradient.png");

  ImageProvider cartWhiteImageView() =>
      const AssetImage("assets/cart_white.png");

  ImageProvider cartBlackImageView() =>
      const AssetImage("assets/cart_black.png");

  BottomNavigationBarItem emptyBottomView() =>
      const BottomNavigationBarItem(icon: SizedBox(), label: '');

  BottomNavigationBarItem outfitBottomView() => BottomNavigationBarItem(
      icon: Container(
        width: 22.93.px,
        height: 20.px,
        decoration: controller.selectedIndex.value == 1
            ? BoxDecoration(
                image: DecorationImage(image: outfitGradiantImageView()),
              )
            : BoxDecoration(
                image: DecorationImage(
                  image: Theme.of(Get.context!).brightness == Brightness.dark
                      ? outfitWhiteImageView()
                      : outfitBlackImageView(),
                ),
              ),
      ),
      label: '');

  ImageProvider outfitGradiantImageView() =>
      const AssetImage("assets/outfit_gradient.png");

  ImageProvider outfitWhiteImageView() =>
      const AssetImage("assets/outfit_white.png");

  ImageProvider outfitBlackImageView() =>
      const AssetImage("assets/outfit_black.png");

  BottomNavigationBarItem profileBottomView() => BottomNavigationBarItem(
      icon: Container(
        width: 17.78.px,
        height: 20.px,
        decoration: controller.selectedIndex.value == 5
            ? BoxDecoration(
                image: DecorationImage(image: profileGradiantImageView()),
              )
            : BoxDecoration(
                image: DecorationImage(
                  image: Theme.of(Get.context!).brightness == Brightness.dark
                      ? profileWhiteImageView()
                      : profileBlackImageView(),
                ),
              ),
      ),
      label: '');

  ImageProvider profileGradiantImageView() =>
      const AssetImage("assets/user_gradient.png");

  ImageProvider profileWhiteImageView() =>
      const AssetImage("assets/user_white.png");

  ImageProvider profileBlackImageView() =>
      const AssetImage("assets/user_black.png");

  Widget categoryBottomView() => CommonWidgets.myElevatedButton(
      height: 70.px,
      width: 70.px,
      borderRadius: 35.px,
      text: SizedBox(height: 33.px, width: 33.px, child: categoryImageView()),
      onPressed: () => controller.clickOnCategoryBottom());

  Widget categoryImageView() => Image.asset("assets/categories_icon.png");
}
*/
