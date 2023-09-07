import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../controllers/outfit_room_controller.dart';

class OutfitRoomView extends GetView<OutfitRoomController> {
  const OutfitRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: appBarView(),
          body: Obx(
            () {
              controller.count.value;
              if (CommonMethods.isConnect.value) {
                if (controller.getOutfitRoomListApiModel != null &&
                    controller.responseCode == 200) {
                  if (controller.outfitRoomList.isNotEmpty) {
                    return CommonWidgets.commonRefreshIndicator(
                      onRefresh: () => controller.onRefresh(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.px),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.px,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: SizedBox(
                                      width: 115.px,
                                      child: ListView(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: const ScrollPhysics(),
                                        children: [
                                          controller.upperImagePath.value
                                                  .isNotEmpty
                                              ? InkWell(
                                                  onTap: () => controller
                                                      .clickOnUpperImage(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.px),
                                                  child: upperImageView())
                                              : commonConAddImage(
                                                  height: 115.px,
                                                  width: 112.px,
                                                  onTapAddImage: () =>
                                                      controller
                                                          .clickOnUpperImage()),
                                          SizedBox(height: 12.px),
                                          controller.lowerImagePath.value
                                                  .isNotEmpty
                                              ? InkWell(
                                                  onTap: () => controller
                                                      .clickOnLowerImage(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.px),
                                                  child: lowerImageView())
                                              : commonConAddImage(
                                                  height: 115.px,
                                                  width: 112.px,
                                                  onTapAddImage: () =>
                                                      controller
                                                          .clickOnLowerImage()),
                                          SizedBox(height: 12.px),
                                          controller.shoeImagePath.value
                                                  .isNotEmpty
                                              ? InkWell(
                                                  onTap: () => controller
                                                      .clickOnShoeImage(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.px),
                                                  child: shoeImageView())
                                              : commonConAddImage(
                                                  height: 115.px,
                                                  width: 112.px,
                                                  onTapAddImage: () =>
                                                      controller
                                                          .clickOnShoeImage())
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18.px),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ScrollConfiguration(
                                            behavior: MyBehavior(),
                                            child: GridView.builder(
                                              itemCount: controller
                                                      .accessoriesImageList
                                                      .length +
                                                  1,
                                              shrinkWrap: true,
                                              padding:
                                                  EdgeInsets.only(left: 16.px),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 4.px,
                                                      crossAxisSpacing: 4.px),
                                              itemBuilder: (context, index) {
                                                if (index <
                                                    controller
                                                        .accessoriesImageList
                                                        .length) {
                                                  return commonImage(
                                                    width: 80.px,
                                                    height: 80.px,
                                                    imagePath: controller
                                                        .accessoriesImageList[
                                                            index]
                                                        .toString(),
                                                    onTapCrossImage: () =>
                                                        controller
                                                            .clickOnAccessoriesRemoveImage(
                                                                index: index),
                                                  );
                                                } else {
                                                  // if(controller.accessoriesImageList.isEmpty) {
                                                  return commonConAddImage(
                                                    height: 80.px,
                                                    width: 80.px,
                                                    onTapAddImage: () => controller
                                                        .clickOnGridViewAddImage(),
                                                  );
                                                  // }
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        Align(
                                          /// TODO Add To Cart Button equal to Shoe Widget Alignment Use in this code {alignment: Alignment.bottomLeft}
                                          alignment: Alignment.bottomRight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(height: 12.px),
                                              browserMoreButtonView(),
                                              SizedBox(height: 8.px),
                                              if (controller
                                                  .outfitRoomList.isNotEmpty)
                                                addToCartButtonView(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.productDetailUpper.isNotEmpty ||
                              controller.productDetailLower.isNotEmpty ||
                              controller.productDetailShoe.isNotEmpty ||
                              controller.productDetailAccessories.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.px),
                              child: SizedBox(
                                height: 80.px,
                                //flex: 2,
                                /// TODO Add To Cart Button equal to Shoe Widget No Flex Use in this code{flex=0}
                                child: controller.upperImageViewValue1.value
                                    ? commonListViewBuilderForUpper()
                                    : controller.lowerImageViewValue1.value
                                        ? commonListViewBuilderForLower()
                                        : controller.shoeImageViewValue1.value
                                            ? commonListViewBuilderForShoe()
                                            : controller
                                                    .accessoriesImageViewValue1
                                                    .value
                                                ? commonListViewBuilderForAccessories()
                                                : const SizedBox(),
                              ),
                            ),
                          SizedBox(height: controller.bottomHeight),
                        ],
                      ),
                    );
                  } else {
                    return CommonWidgets.commonNoDataFoundImage(
                      onRefresh: () => controller.onRefresh(),
                    );
                  }
                } else {
                  if (controller.responseCode == 0) {
                    return const SizedBox();
                  }
                  return CommonWidgets.commonSomethingWentWrongImage(
                    onRefresh: () => controller.onRefresh(),
                  );
                }
              } else {
                return CommonWidgets.commonNoInternetImage(
                  onRefresh: () => controller.onRefresh(),
                );
              }
            },
          ),
        ),
      );
    });
  }

  PreferredSizeWidget appBarView() => const MyCustomContainer().myAppBar(
        text: 'Outfit Room',
        isIcon: controller.bottomHeight == 0.0 ? true : false,
        backIconOnPressed: () => controller.clickOnBackIcon(),
      );

  Widget upperImageView() => commonImage(
        height: 115.px,
        width: 112.px,
        imagePath: controller.upperImagePath.value.toString(),
        onTapCrossImage: () => controller.clickOnUpperRemoveImage(),
      );

  Widget lowerImageView() => commonImage(
        height: 115.px,
        width: 112.px,
        imagePath: controller.lowerImagePath.value.toString(),
        onTapCrossImage: () => controller.clickOnLowerRemoveImage(),
      );

  Widget shoeImageView() => commonImage(
        height: 115.px,
        width: 112.px,
        imagePath: controller.shoeImagePath.value.toString(),
        onTapCrossImage: () => controller.clickOnShoeRemoveImage(),
      );

  Widget browserMoreButtonView() => CommonWidgets.myOutlinedButton(
      text: Text(
        'Browse More',
        style: Theme.of(Get.context!).textTheme.headline3,
      ),
      onPressed: () => controller.clickOnBrowserMoreButton(),
      radius: 5.px,
      height: 40.px,
      margin: EdgeInsets.zero,
      width: 120.px);

  Widget addToCartButtonView() {
    if (!controller.isAddToCartButtonClicked.value) {
      return CommonWidgets.myElevatedButton(
          text: Text(
            'Add to cart',
            style: Theme.of(Get.context!)
                .textTheme
                .headline3
                ?.copyWith(color: MyColorsLight().secondary),
          ),
          onPressed: () => controller.clickOnAddToCartButton(),
          borderRadius: 5.px,
          height: 40.px,
          margin: EdgeInsets.zero,
          width: 120.px);
    } else {
      return CommonWidgets.myElevatedButton(
          text: SizedBox(
              height: 20.px,
              width: 20.px,
              child: CommonWidgets.buttonProgressBarView()),
          // ignore: avoid_returning_null_for_void
          onPressed: () => null,
          borderRadius: 5.px,
          height: 40.px,
          margin: EdgeInsets.zero,
          width: 120.px);
    }
  }

  Widget commonImage({
    required String imagePath,
    required GestureTapCallback onTapCrossImage,
    double? width,
    double? height,
  }) =>
      Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.px),
            child: SizedBox(
              width: width ?? double.infinity,
              height: height ?? 115.px,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CommonWidgets.commonShimmerViewForImage();
                },
              ),
            ),
          ),
          commonCrossIconView(onTapCrossImage: onTapCrossImage)
        ],
      );

  Widget commonCrossIconView({required GestureTapCallback onTapCrossImage}) =>
      Padding(
        padding: EdgeInsets.all(4.px),
        child: InkWell(
          onTap: onTapCrossImage,
          child: Container(
            height: 16.px,
            width: 16.px,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.px),
              color: MyColorsLight().greyColor,
            ),
            child: Icon(Icons.close, color: MyColorsLight().onText, size: 8.px),
          ),
        ),
      );

  Widget commonAddIconView() => Padding(
        padding: EdgeInsets.all(4.px),
        child: Container(
          height: 16.px,
          width: 16.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.px),
            color: MyColorsLight().greyColor,
          ),
          child: Icon(Icons.add, color: MyColorsLight().onText, size: 8.px),
        ),
      );

  Widget commonImageForHorizontalList({required String imagePath}) => ClipRRect(
        borderRadius: BorderRadius.circular(5.px),
        child: SizedBox(
          width: 80.px,
          height: 80.px,
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CommonWidgets.commonShimmerViewForImage();
            },
          ),
        ),
      );

  Widget commonImageForHorizontalListBorder({required String imagePath}) =>
      CommonWidgets.myOutlinedButton(
        text: ClipRRect(
          borderRadius: BorderRadius.circular(5.px),
          child: SizedBox(
            width: 80.px,
            height: 80.px,
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CommonWidgets.commonShimmerViewForImage();
              },
            ),
          ),
        ),
        onPressed: () {},
        radius: 5.px,
        wantFixedSize: false,
        width: 88.px,
        margin: EdgeInsets.zero,
        strokeWidth: 2,
        padding: EdgeInsets.all(4.px),
        height: 88.px,
      );

  Widget commonConAddImage(
          {required GestureTapCallback onTapAddImage,
          double? height,
          double? width}) =>
      InkWell(
        onTap: onTapAddImage,
        borderRadius: BorderRadius.circular(5.px),
        child: Container(
          width: 115.px,
          height: 115.px,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.px),
              color: MyColorsLight().onPrimary.withOpacity(.3)),
          child: Center(
            child: commonAddIconView(),
          ),
        ),
      );

  Widget commonListViewBuilderForUpper() {
    if (controller.productDetailUpper.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            itemCount: controller.productDetailUpper?.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(() {
                print(controller.count.value);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.px),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.px),
                      onTap: () => controller.clickOnListHorizontalOfUpperImage(
                          index: index),
                      child:
                          controller.currentIndexOfUpperImageList.value == index
                              ? commonImageForHorizontalListBorder(
                                  imagePath: CommonMethods.imageUrl(
                                      url: controller.productDetailUpper[index]
                                          .thumbnailImage
                                          .toString()),
                                )
                              : commonImageForHorizontalList(
                                  imagePath: CommonMethods.imageUrl(
                                      url: controller.productDetailUpper[index]
                                          .thumbnailImage
                                          .toString()),
                                ),
                    ),
                  ),
                );
              });
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget commonListViewBuilderForLower() {
    if (controller.productDetailLower.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            itemCount: controller.productDetailLower?.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(() {
                print(controller.count.value);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.px),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.px),
                      onTap: () => controller.clickOnListHorizontalOfLowerImage(
                          index: index),
                      child:
                          controller.currentIndexOfLowerImageList.value == index
                              ? commonImageForHorizontalListBorder(
                                  imagePath: CommonMethods.imageUrl(
                                      url: controller.productDetailLower[index]
                                          .thumbnailImage
                                          .toString()),
                                )
                              : commonImageForHorizontalList(
                                  imagePath: CommonMethods.imageUrl(
                                      url: controller.productDetailLower[index]
                                          .thumbnailImage
                                          .toString()),
                                ),
                    ),
                  ),
                );
              });
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget commonListViewBuilderForShoe() {
    if (controller.productDetailShoe.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            itemCount: controller.productDetailShoe?.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(() {
                print(controller.count.value);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.px),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.px),
                      onTap: () => controller.clickOnListHorizontalOfShoeImage(
                          index: index),
                      child:
                          controller.currentIndexOfShoeImageList.value == index
                              ? commonImageForHorizontalListBorder(
                                  imagePath: CommonMethods.imageUrl(
                                      url: controller.productDetailShoe[index]
                                          .thumbnailImage
                                          .toString()),
                                )
                              : commonImageForHorizontalList(
                                  imagePath: CommonMethods.imageUrl(
                                      url: controller.productDetailShoe[index]
                                          .thumbnailImage
                                          .toString()),
                                ),
                    ),
                  ),
                );
              });
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget commonListViewBuilderForAccessories() {
    if (controller.productDetailAccessories.isNotEmpty) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            itemCount: controller.productDetailAccessories?.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Obx(() {
                print(controller.count.value);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.px),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.px),
                      onTap: () =>
                          controller.clickOnListHorizontalOfAccessoriesImage(
                              index: index),
                      child: controller.accessoriesImageListIds.contains(
                              controller
                                  .productDetailAccessories[index].outfitRoomId
                                  .toString())
                          ? commonImageForHorizontalListBorder(
                              imagePath: CommonMethods.imageUrl(
                                  url: controller
                                      .productDetailAccessories[index]
                                      .thumbnailImage
                                      .toString()),
                            )
                          : commonImageForHorizontalList(
                              imagePath: CommonMethods.imageUrl(
                                  url: controller
                                      .productDetailAccessories[index]
                                      .thumbnailImage
                                      .toString()),
                            ),
                    ),
                  ),
                );
              });
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true),
      );
    } else {
      return const SizedBox();
    }
  }
}
