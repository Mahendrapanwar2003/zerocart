import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:light_carousel/light_carousel.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../common_methods/common_methods.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../custom/custom_appbar.dart';
import '../../../custom/custom_outline_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Obx(() {
        return ModalProgress(
          inAsyncCall: controller.inAsyncCall.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Obx(
              () {
                if (CommonMethods.isConnect.value) {
                  return Stack(
                    children: [
                      Obx(() {
                        return ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              Visibility(
                                maintainSize: true,
                                visible: false,
                                maintainAnimation: true,
                                maintainState: true,
                                child: Column(
                                  children: [
                                    Container(
                                        color: Theme.of(Get.context!)
                                            .colorScheme
                                            .onBackground,
                                        child: const MyCustomContainer()
                                            .myCustomContainer()),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Obx(() {
                                    if (controller.getBanner.value != null) {
                                      if (controller
                                          .bannerImageList.isNotEmpty) {
                                        return Stack(
                                          children: [
                                            banner(),
                                            Column(
                                              children: [
                                                AspectRatio(
                                                  aspectRatio: 19.px / 7.px,
                                                  child: const SizedBox(),
                                                ),
                                                customDotIndicatorList(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 16.px,
                                                      left: 20.px,
                                                      right: 20.px),
                                                  child: Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 10.px,
                                                        horizontal: 10.px,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.px),
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? MyColorsLight()
                                                                .secondary
                                                            : MyColorsLight()
                                                                .card
                                                                .withOpacity(
                                                                    .9),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Customize your wardrobe",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                ?.copyWith(
                                                                    color: MyColorsLight()
                                                                        .onText,
                                                                    fontSize:
                                                                        14.px),
                                                          ),
                                                          SizedBox(
                                                              height: 8.px),
                                                          Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            "Make your own clothes based on your choice of colour, texture, material and many others.",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline4
                                                                ?.copyWith(
                                                                    color: MyColorsLight()
                                                                        .onText,
                                                                    fontSize:
                                                                        12.px),
                                                          ),
                                                          SizedBox(
                                                              height: 12.px),
                                                          Center(
                                                            child: CommonWidgets
                                                                .myElevatedButton(
                                                              borderRadius:
                                                                  5.px,
                                                              width: 50.w,
                                                              height: 28.px,
                                                              text: Text(
                                                                'OUTFIT ROOM',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .button
                                                                    ?.copyWith(
                                                                        fontSize:
                                                                            12.px),
                                                              ),
                                                              onPressed: () => controller
                                                                  .clickOnCustomizeButton(
                                                                      context:
                                                                          context),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        return CommonWidgets.noDataTextView(
                                            text: "No Banner Found");
                                      }
                                    } else {
                                      return Center(
                                        child: CommonWidgets
                                            .commonShimmerViewForImage(
                                                width: double.infinity,
                                                height: 20.h),
                                      );
                                    }
                                  })
                                ],
                              ),
                              SizedBox(height: 16.px),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.px),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((controller
                                        .recentProductsList.isNotEmpty))
                                      sectionHeading("Based on previous order"),
                                    if ((controller
                                        .recentProductsList.isNotEmpty))
                                      SizedBox(height: 8.px),
                                    if ((controller
                                        .recentProductsList.isNotEmpty))
                                      ScrollConfiguration(
                                          behavior: MyBehavior(),
                                          child: recentGridView()),
                                    if ((controller
                                        .topTrendingProductsList.isNotEmpty))
                                      SizedBox(height: 16.px),
                                    if ((controller
                                        .topTrendingProductsList.isNotEmpty))
                                      sectionHeading(
                                          "Based on users with similar preferences"),
                                    if ((controller
                                        .topTrendingProductsList.isNotEmpty))
                                      SizedBox(height: 8.px),
                                    if ((controller
                                        .topTrendingProductsList.isNotEmpty))
                                      ScrollConfiguration(
                                          behavior: MyBehavior(),
                                          child: trendingGridView()),
                                    if ((controller
                                        .topTrendingProductsList2.isNotEmpty))
                                      SizedBox(height: 16.px),
                                    if ((controller
                                        .topTrendingProductsList2.isNotEmpty))
                                      sectionHeading(
                                          "Other users also ordered"),
                                    if ((controller
                                        .topTrendingProductsList2.isNotEmpty))
                                      SizedBox(height: 8.px),
                                    if ((controller
                                        .topTrendingProductsList2.isNotEmpty))
                                      ScrollConfiguration(
                                          behavior: MyBehavior(),
                                          child: trendingGridView2()),
                                    if ((controller
                                                .getProductApiModel.value ==
                                            null) &&
                                        (controller
                                            .recentProductsList.isEmpty) &&
                                        (controller
                                            .topTrendingProductsList.isEmpty) &&
                                        (controller.topTrendingProductsList2
                                            .isEmpty) &&
                                        controller
                                            .productListDefault.isNotEmpty)
                                      sectionHeading("Products"),
                                    SizedBox(height: 8.px),
                                    if ((controller
                                                .getProductApiModel.value ==
                                            null) &&
                                        (controller
                                            .recentProductsList.isEmpty) &&
                                        (controller
                                            .topTrendingProductsList.isEmpty) &&
                                        (controller.topTrendingProductsList2
                                            .isEmpty) &&
                                        controller
                                            .productListDefault.isNotEmpty)
                                      defaultProductGridView()
                                  ],
                                ),
                              ),
                              SizedBox(height: 100.px),
                            ],
                          ),
                        );
                      }),
                      Column(
                        children: [
                          Container(
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5),
                              child: const MyCustomContainer()
                                  .myCustomContainer()),
                        ],
                      ),
                    ],
                  );
                } else {
                  return CommonWidgets.noInternetTextView();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget sectionHeading(String text) {
    return Text(
      text,
      style:
          Theme.of(Get.context!).textTheme.subtitle1?.copyWith(fontSize: 14.px),
    );
  }

  Widget banner() {
    return bannerImage();
  }

  Widget bannerImage() {
    return AspectRatio(
      aspectRatio: 16.px / 9.px,
      child: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/default_image.jpg'))),
        child: LightCarousel(
          images: controller.bannerImageList,
          dotSize: 0,
          autoPlay: true,
          onImageChange: (reason, index) {
            controller.current.value = index;
          },
          boxFit: BoxFit.cover,
          dotBgColor: Colors.transparent,
          defaultImage: CommonWidgets.defaultImage(),
        ),
      ),
    );
  }

  Widget customDotIndicatorList() {
    return SizedBox(
      height: 10.px,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.bannerImageList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Obx(() {
            controller.count.value;
            return controller.current.value == index
                ? customDot(true)
                : customDot(false);
          });
        },
      ),
    );
  }

  Widget customDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.px),
      width: 10.px,
      child: UnicornOutline(
        strokeWidth: 1.px,
        radius: 5.px,
        gradient: CommonWidgets.commonLinearGradientView(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 8.px,
          width: 8.px,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? MyColorsLight().secondary : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget recentGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.155,
        crossAxisSpacing: 16.px,
        mainAxisSpacing: 16.px,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: controller.recentProductsList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          int recentProductId = int.parse(
              controller.recentProductsList[index].productId.toString());
          String recentProductIdId = recentProductId.toString();
          controller.clickOnCard(productId: recentProductIdId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.recentProductsList[index].thumbnailImage != null &&
                controller.recentProductsList[index].thumbnailImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.px),
                child: Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CommonWidgets.commonShimmerViewForImage();
                  },
                  CommonMethods.imageUrl(
                      url: controller.recentProductsList[index].thumbnailImage
                          .toString()),
                  width: 50.w,
                  height: 28.w,
                  fit: BoxFit.cover,
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 6.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.recentProductsList[index].productName !=
                            null &&
                        controller
                            .recentProductsList[index].productName!.isNotEmpty)
                      Text(
                        controller.recentProductsList[index].productName
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 10.px),
                        maxLines: 1,
                      ),
                    if (controller.recentProductsList[index].productPrice !=
                            null &&
                        controller.recentProductsList[index].productPrice != 0)
                      Text(
                        controller.recentProductsList[index].productPrice
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 10.px),
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget trendingGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.155,
        crossAxisSpacing: 16.px,
        mainAxisSpacing: 16.px,
      ),
      itemCount: controller.topTrendingProductsList.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          int topProductId = int.parse(
              controller.topTrendingProductsList[index].productId.toString());
          String topProductIdId = topProductId.toString();
          controller.clickOnCard(productId: topProductIdId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.topTrendingProductsList[index].thumbnailImage !=
                    null &&
                controller
                    .topTrendingProductsList[index].thumbnailImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.px),
                child: Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CommonWidgets.commonShimmerViewForImage();
                  },
                  CommonMethods.imageUrl(
                      url: controller
                          .topTrendingProductsList[index].thumbnailImage
                          .toString()),
                  width: 50.w,
                  height: 28.w,
                  fit: BoxFit.cover,
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 6.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.topTrendingProductsList[index].productName !=
                            null &&
                        controller.topTrendingProductsList[index].productName!
                            .isNotEmpty)
                      Text(
                        controller.topTrendingProductsList[index].productName
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 10.px),
                        maxLines: 1,
                      ),
                    if (controller
                                .topTrendingProductsList[index].productPrice !=
                            null &&
                        controller
                                .topTrendingProductsList[index].productPrice !=
                            0)
                      Text(
                        controller.topTrendingProductsList[index].productPrice
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 10.px),
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget trendingGridView2() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.155,
        crossAxisSpacing: 16.px,
        mainAxisSpacing: 16.px,
      ),
      itemCount: controller.topTrendingProductsList2.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          int productId = int.parse(
              controller.topTrendingProductsList2[index].productId.toString());
          String productIdId = productId.toString();
          controller.clickOnCard(productId: productIdId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.topTrendingProductsList2[index].thumbnailImage !=
                    null &&
                controller
                    .topTrendingProductsList2[index].thumbnailImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.px),
                child: Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CommonWidgets.commonShimmerViewForImage();
                  },
                  CommonMethods.imageUrl(
                      url: controller
                          .topTrendingProductsList2[index].thumbnailImage
                          .toString()),
                  width: 50.w,
                  height: 28.w,
                  fit: BoxFit.cover,
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 6.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller
                                .topTrendingProductsList2[index].productName !=
                            null &&
                        controller.topTrendingProductsList2[index].productName!
                            .isNotEmpty)
                      Text(
                        controller.topTrendingProductsList2[index].productName
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 10.px),
                        maxLines: 1,
                      ),
                    if (controller
                                .topTrendingProductsList2[index].productPrice !=
                            null &&
                        controller
                                .topTrendingProductsList2[index].productPrice !=
                            0)
                      Text(
                        controller.topTrendingProductsList2[index].productPrice
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(Get.context!)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: 10.px),
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget defaultProductGridView() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.155,
          crossAxisSpacing: 16.px,
          mainAxisSpacing: 16.px,
        ),
        itemCount: controller.productListDefault.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (!controller.isShimmer.value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [CommonWidgets.commonShimmerViewForImage()],
            );
          } else {
            return GestureDetector(
              onTap: () {
                int productId = int.parse(
                    controller.productListDefault[index].productId.toString());
                String productIdId = productId.toString();
                controller.clickOnCard(productId: productIdId);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.productListDefault[index].thumbnailImage !=
                          null &&
                      controller
                          .productListDefault[index].thumbnailImage!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.px),
                      child: Image.network(
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CommonWidgets.commonShimmerViewForImage();
                        },
                        CommonMethods.imageUrl(
                            url: controller
                                .productListDefault[index].thumbnailImage
                                .toString()),
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration:
                                BoxDecoration(color: MyColorsLight().onPrimary),
                            width: 50.w,
                            height: 28.w,
                          );
                        },
                        width: 50.w,
                        height: 28.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.px),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller
                                      .productListDefault[index].productName !=
                                  null &&
                              controller.productListDefault[index].productName!
                                  .isNotEmpty)
                            Text(
                              controller.productListDefault[index].productName
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(fontSize: 10.px),
                              maxLines: 1,
                            ),
                          if (controller
                                      .productListDefault[index].productPrice !=
                                  null &&
                              controller.productListDefault[index].productPrice!
                                  .isNotEmpty)
                            Text(
                              controller.productListDefault[index].productPrice
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(fontSize: 10.px),
                              maxLines: 1,
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }

//TODO This Code Comment By Aman

/* Widget recentGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 16.px,
        mainAxisSpacing: 16.px,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: controller.recentSearchList!.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => controller.clickOnCard(
            productId: controller.recentSearchList![index].productId!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.recentSearchList![index].thumbnailImage != null &&
                controller.recentSearchList![index].thumbnailImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.px),
                child: Image.network(
                  ApiConstUri.baseUrl +
                      controller.recentSearchList![index].thumbnailImage!,
                  width: 50.w,
                  height: 28.w,
                  fit: BoxFit.cover,
                ),
              ),
            if (controller.recentSearchList![index].productName != null &&
                controller.recentSearchList![index].productName!.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6.px),
                  child: Text(
                    controller.recentSearchList![index].productName!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .headline3
                        ?.copyWith(fontSize: 10.px),
                    maxLines: 2,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }*/

/*Widget trendingGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 16.px,
        mainAxisSpacing: 16.px,
      ),
      itemCount: controller.trendingList!.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => controller.clickOnCard(productId: controller.trendingList![index].productId!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.trendingList![index].thumbnailImage != null &&
                controller.trendingList![index].thumbnailImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.px),
                child: Image.network(
                  ApiConstUri.baseUrl +
                      controller.trendingList![index].thumbnailImage!,
                  width: 50.w,
                  height: 28.w,
                  fit: BoxFit.cover,
                ),
              ),
            if (controller.trendingList![index].productName != null &&
                controller.trendingList![index].productName!.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6.px, right: 2.px, left: 2.px),
                  child: Text(
                    controller.trendingList![index].productName!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .headline3
                        ?.copyWith(fontSize: 10.px),
                    maxLines: 1,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }*/
}
