import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/model_progress_bar/model_progress_bar.dart';
import '../../../../load_more/load_more.dart';
import '../../../../my_list/my_list_view.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../constant/zconstant.dart';
import '../../../custom/custom_outline_button.dart';
import '../../../custom/custom_appbar.dart';
import '../../../custom/custom_gradient_text.dart';
import '../controllers/category_product_controller.dart';

class CategoryProductView extends GetView<CategoryProductController> {
  const CategoryProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: WillPopScope(
          onWillPop: () => controller.onWillPop(context: context),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: controller.searchPageValue == 'searchPage'
                ? const MyCustomContainer().myAppBar(
                    isIcon: true,
                    backIconOnPressed: () =>
                        controller.clickOnBackButton(context: context),
                    text: controller.appBarTitleFromSearchPage.toString(),
                    isChatOption: false)
                : const MyCustomContainer().myAppBar(
                    buttonIcon: Icons.filter_alt_sharp,
                    buttonOnPressed: () => controller.clickOnFilterButton(
                          context: context,
                          isChatOption:
                              /*controller.isChatOption == '1' ? true :*/ false,
                        ),
                    isIcon: true,
                    backIconOnPressed: () =>
                        controller.clickOnBackButton(context: context),
                    text: (controller.categoryName != null &&
                            controller.categoryName!.isNotEmpty)
                        ? controller.categoryName
                        : 'Result',
                    buttonText: /*controller.isChatOption == '1'
                        ? 'Upload Prescription'
                        :*/
                        'Filters',
                    isChatOption: /*controller.isChatOption == '1' ? true :*/
                        false),
            body: Obx(
              () {
                controller.count.value;
                if (CommonMethods.isConnect.value) {
                  if ((controller.getProductListApiModel != null ||
                          controller.searchProductModel != null) &&
                      controller.responseCode == 200) {
                    if (controller.products.isNotEmpty) {
                      return CommonWidgets.commonRefreshIndicator(
                        onRefresh: () => controller.onRefresh(),
                        child: RefreshLoadMore(
                          isLastPage: controller.isLastPage.value,
                          onLoadMore: () => controller.onLoadMore(),
                          child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    if (controller.filterDataList.isNotEmpty)
                                      Obx(() {
                                        controller.count.value;
                                        return filterListView();
                                      }),
                                    SizedBox(height: 4.px),
                                    productsGridView(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.filterDataList.isNotEmpty)
                            Obx(() {
                              controller.count.value;
                              return filterListView();
                            }),
                          if (controller.products.isEmpty)
                            SizedBox(height: 4.px),
                          if (controller.products.isEmpty)
                            Expanded(
                              child: CommonWidgets.commonNoDataFoundImage(
                                onRefresh: () => controller.onRefresh(),
                              ),
                            ),
                        ],
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
        ),
      ),
    );
  }

  /*CommonMethods.isConnect.value
                ? controller.getProductListApiModel != null ||
                        controller.searchProductModel != null
                    ? controller.products.isNotEmpty
                        ? ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.filterDataList.isNotEmpty)
                                  Obx(() {
                                    print("${controller.count.value}");
                                    return filterListView();
                                  }),
                                if (controller.products.isNotEmpty)
                                  SizedBox(height: 4.px),
                                if (controller.products.isNotEmpty)
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.px),
                                      child: productsGridView(),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (controller.filterDataList.isNotEmpty)
                                Obx(() {
                                  print("${controller.count.value}");
                                  return filterListView();
                                }),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonWidgets.noDataTextView(),
                                  ],
                                ),
                              ),
                            ],
                          )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (controller.filterDataList.isNotEmpty)
                            Obx(() {
                              print("${controller.count.value}");
                              return filterListView();
                            }),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonWidgets.progressBarView(),
                              ],
                            ),
                          ),
                        ],
                      )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonWidgets.noDataTextView(text: "No Internet"),
                    ],
                  ),*/

  Widget backArrowIconButtonView({required BuildContext context}) => Material(
        color: Colors.transparent,
        child: IconButton(
          splashRadius: 24.px,
          onPressed: () => controller.clickOnBackButton(context: context),
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Theme.of(Get.context!).textTheme.subtitle1?.color,
            size: 18.px,
          ),
        ),
      );

  Widget categoryNameTextView() => Expanded(
        child: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          controller.categoryName ?? "category Name",
          style: Theme.of(Get.context!).textTheme.subtitle1,
        ),
      );

  Widget filterListView() => SizedBox(
        height: 50.px,
        child: MyListView(
            shrinkWrap: true,
            dividerHorizontalPadding: 3.w,
            isVertical: false,
            listOfData: (index) {
              return Row(
                children: [
                  myOutlinedButton(
                    radius: 5.px,
                    text: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          size: 14.px,
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1?.color,
                        ),
                        SizedBox(width: 2.w),
                        Text(controller.filterDataList[index],
                            style: Theme.of(Get.context!).textTheme.headline3),
                      ],
                    ),
                    onPressed: () =>
                        controller.clickOnFilterOptionListButton(index: index),
                  ),
                  SizedBox(width: 2.w)
                ],
              );
            },
            physics: const BouncingScrollPhysics(),
            itemCount: controller.filterDataList.length),
      );

/*  Widget filterButtonView(
      {required BuildContext context,
        required String text,
        required bool isChatOption}) =>
      CommonWidgets.myElevatedButton(
          height: 26.px,
          width: 22.w,
          borderRadius: 4.px,
          text: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (!isChatOption)
                Icon(
                  Icons.filter_alt_sharp,
                  size: 18.px,
                  color: MyColorsLight().secondary,
                ),
              Text(
                  style: Theme.of(Get.context!)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: MyColorsLight().secondary),
                  text),
            ],
          ),
          onPressed: () => controller.clickOnFilterButton(
            context: context,
            isChatOption: isChatOption,
          ));*/

  Widget myOutlinedButton({
    required Widget text,
    required VoidCallback onPressed,
    double? height,
    double? width,
    double? radius,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: CustomOutlineButton(
        onPressed: onPressed,
        strokeWidth: 1,
        radius: radius ?? 25.px,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(Get.context!).primaryColor,
            Theme.of(Get.context!).colorScheme.primary,
          ],
        ),
        child: text,
      ),
    );
  }

  ///Todo dynamicSize for GridView Widget
  /* Widget productsGridView() => MasonryGridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    itemCount:controller.products.length,
    physics: controller.isLoading.value
        ? const NeverScrollableScrollPhysics()
        : const ScrollPhysics(),
    controller: controller.scrollController,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => controller.clickOnProduct(
            context: context,
            productId: controller.products[index].productId.toString()),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  productImageView(index: index),
                  //SizedBox(height: 2.px),
                  if (controller.products[index].isColor != null &&
                      controller.products[index].isColor != "0")
                    colorListView(index: index),
                  SizedBox(height: 4.px),
                  if (controller.products[index].brandName != null &&
                      controller.products[index].brandName!.isNotEmpty)
                    brandNameTextView(index: index),
                  if (controller.products[index].brandName != null &&
                      controller.products[index].brandName!.isNotEmpty)
                    SizedBox(height: 2.px),
                  if (controller.products[index].productName != null &&
                      controller
                          .products[index].productName!.isNotEmpty)
                    productNameTextView(index: index),
                  if (controller.products[index].productName != null &&
                      controller
                          .products[index].productName!.isNotEmpty)
                    SizedBox(height: 2.px),
                  priceView(index: index),
                  //SizedBox(height: 4.px),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );*/

  Widget productsGridView() =>SingleChildScrollView(
    child: Wrap(
      children: List.generate(controller.products.length, (index) {
        final cellWidth = MediaQuery.of(Get.context!).size.width /
            2; // Every cell's `width` will be set to 1/2 of the screen width.
        return SizedBox(
          width: cellWidth,
          child: GestureDetector(
            onTap: () => controller.clickOnProduct(
                context: Get.context!,
                productId: controller.products[index].productId.toString()),
            child: Container(
                width: cellWidth,
                //height: 248.px,
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.all(10.px),
                margin: EdgeInsets.only(
                    left: index % 2 == 0 ? 16.px : 10.px,
                    right: index % 2 == 0 ? 10.px : 16.px,
                    bottom: 16.px),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.px)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        productImageView(index: index),
                        //SizedBox(height: 2.px),
                        if (controller.products[index].isColor != null &&
                            controller.products[index].isColor != "0")
                          colorListView(index: index),
                        SizedBox(height: 4.px),
                        if (controller.products[index].brandName != null &&
                            controller.products[index].brandName!.isNotEmpty)
                          brandNameTextView(index: index),
                        if (controller.products[index].brandName != null &&
                            controller.products[index].brandName!.isNotEmpty)
                          SizedBox(height: 2.px),
                        if (controller.products[index].productName != null &&
                            controller.products[index].productName!.isNotEmpty)
                          productNameTextView(index: index),
                        if (controller.products[index].productName != null &&
                            controller.products[index].productName!.isNotEmpty)
                          SizedBox(height: 2.px),
                        //priceView(index: index),
                        //SizedBox(height: 4.px),
                      ],
                    ),
                  ],
                )),
          ),
        );
      }),
    ),
  );

     /* Widget productsGridView() => Column(
        children: [
          Wrap(
              children: List.generate(
            controller.products.length,
            (index) => GestureDetector(
              onTap: () => controller.clickOnProduct(
                  context: Get.context!,
                  productId: controller.products[index].productId.toString()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.px, vertical: 6.px),
                width: MediaQuery.of(Get.context!).size.width / 2.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        productImageView(index: index),
                        //SizedBox(height: 2.px),
                        if (controller.products[index].isColor != null &&
                            controller.products[index].isColor != "0")
                          colorListView(index: index),
                        SizedBox(height: 4.px),
                        if (controller.products[index].brandName != null &&
                            controller.products[index].brandName!.isNotEmpty)
                          brandNameTextView(index: index),
                        if (controller.products[index].brandName != null &&
                            controller.products[index].brandName!.isNotEmpty)
                          SizedBox(height: 2.px),
                        if (controller.products[index].productName != null &&
                            controller.products[index].productName!.isNotEmpty)
                          productNameTextView(index: index),
                        if (controller.products[index].productName != null &&
                            controller.products[index].productName!.isNotEmpty)
                          SizedBox(height: 2.px),
                        //priceView(index: index),
                        //SizedBox(height: 4.px),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      );*/

  /*Widget productsGridView() => SliverGrid.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 25.h,
          childAspectRatio: 0.6,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 1.5.h,
        ),
        itemCount: controller.products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => controller.clickOnProduct(
                context: context,
                productId: controller.products[index].productId.toString()),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      productImageView(index: index),
                      //SizedBox(height: 2.px),
                      if (controller.products[index].isColor != null &&
                          controller.products[index].isColor != "0")
                        colorListView(index: index),
                      SizedBox(height: 4.px),
                      if (controller.products[index].brandName != null &&
                          controller.products[index].brandName!.isNotEmpty)
                        brandNameTextView(index: index),
                      if (controller.products[index].brandName != null &&
                          controller.products[index].brandName!.isNotEmpty)
                        SizedBox(height: 2.px),
                      if (controller.products[index].productName != null &&
                          controller.products[index].productName!.isNotEmpty)
                        productNameTextView(index: index),
                      if (controller.products[index].productName != null &&
                          controller.products[index].productName!.isNotEmpty)
                        SizedBox(height: 2.px),
                      //priceView(index: index),
                      //SizedBox(height: 4.px),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );*/

/*
  Widget productsGridView() => CustomScrollView(
        shrinkWrap: true,
        physics: controller.isLoading.value
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        controller: controller.scrollController,
        slivers: [
          SliverGrid.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            addSemanticIndexes: false,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 25.h,
              childAspectRatio: 0.6,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 1.5.h,
            ),
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => controller.clickOnProduct(
                    context: context,
                    productId: controller.products[index].productId.toString()),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          productImageView(index: index),
                          //SizedBox(height: 2.px),
                          if (controller.products[index].isColor != null &&
                              controller.products[index].isColor != "0")
                            colorListView(index: index),
                          SizedBox(height: 4.px),
                          if (controller.products[index].brandName != null &&
                              controller.products[index].brandName!.isNotEmpty)
                            brandNameTextView(index: index),
                          if (controller.products[index].brandName != null &&
                              controller.products[index].brandName!.isNotEmpty)
                            SizedBox(height: 2.px),
                          if (controller.products[index].productName != null &&
                              controller
                                  .products[index].productName!.isNotEmpty)
                            productNameTextView(index: index),
                          if (controller.products[index].productName != null &&
                              controller
                                  .products[index].productName!.isNotEmpty)
                            SizedBox(height: 2.px),
                          //priceView(index: index),
                          //SizedBox(height: 4.px),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SliverPadding(
            sliver: SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.px),
                    child: CommonWidgets.progressBarView(
                        height: 25.px, width: 25.px),
                  );
                } else if (controller
                        .getProductListApiModel?.products?.isEmpty ??
                    false) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.px),
                    child: CommonWidgets.noDataTextView(text: "No more data!"),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
            padding: EdgeInsets.only(bottom: 35.px),
          )
        ],
      );
*/

  ///Todo Mahi
  /*  Widget productsGridView() => MasonryGridView.count(
        shrinkWrap: true,
        physics: controller.isLoading.value
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        controller: controller.scrollController,
        itemCount: controller.products.length,
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 1.5.h,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.clickOnProduct(
                context: context,
                productId: controller.products[index].productId.toString()),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      productImageView(index: index),
                      //SizedBox(height: 2.px),
                      if (controller.products[index].isColor != null &&
                          controller.products[index].isColor != "0")
                        colorListView(index: index),
                      SizedBox(height: 4.px),
                      if (controller.products[index].brandName != null &&
                          controller.products[index].brandName!.isNotEmpty)
                        brandNameTextView(index: index),
                      if (controller.products[index].brandName != null &&
                          controller.products[index].brandName!.isNotEmpty)
                        SizedBox(height: 2.px),
                      if (controller.products[index].productName != null &&
                          controller.products[index].productName!.isNotEmpty)
                        productNameTextView(index: index),
                      if (controller.products[index].productName != null &&
                          controller.products[index].productName!.isNotEmpty)
                        SizedBox(height: 2.px),
                      priceView(index: index),
                      //SizedBox(height: 4.px),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
*/

  ///Todo This GridView Widget Old
  /* Widget productsGridView() => GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      */
  /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // maxCrossAxisExtent: 25.h,
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 1.5.h,
      ),*/
  /*
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 25.h,
        childAspectRatio: 0.65,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 1.5.h,
      ),
      itemCount: controller.products.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => controller.clickOnProduct(
              context: context,
              productId: controller.products[index].productId.toString()),
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    productImageView(index: index),
                    //SizedBox(height: 2.px),
                    if (controller.products[index].isColor != null &&
                        controller.products[index].isColor != "0")
                      colorListView(index: index),
                    SizedBox(height: 4.px),
                    if (controller.products[index].brandName != null &&
                        controller.products[index].brandName!.isNotEmpty)
                      brandNameTextView(index: index),
                    if (controller.products[index].brandName != null &&
                        controller.products[index].brandName!.isNotEmpty)
                      SizedBox(height: 2.px),
                    if (controller.products[index].productName != null &&
                        controller.products[index].productName!.isNotEmpty)
                      productNameTextView(index: index),
                    if (controller.products[index].productName != null &&
                        controller.products[index].productName!.isNotEmpty)
                      SizedBox(height: 2.px),
                    priceView(index: index),
                    //SizedBox(height: 4.px),
                  ],
                ),
              ],
            ),
          ),
        );
      });*/

  Widget productImageView({required int index}) =>
      controller.products[index].thumbnailImage != null &&
              controller.products[index].thumbnailImage.toString().isNotEmpty
          ? SizedBox(
              height: 150.px,
              width: 150.px,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6.px)),
                child: Image.network(
                  CommonMethods.imageUrl(
                      url:
                          controller.products[index].thumbnailImage.toString()),
                  fit: BoxFit.cover,
                  // height: 150.px,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CommonWidgets.commonShimmerViewForImage();
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      CommonWidgets.defaultImage(),
                ),
              ),
            )
          : CommonWidgets.progressBarView();

  Widget colorListView({required int index}) =>
      controller.products[index].colorsList != null &&
              controller.products[index].colorsList!.isNotEmpty
          ? SizedBox(
              height: 25.px,
              child: MyListView(
                listOfData: (colorIndex) {
                  String? color = controller
                      .products[index].colorsList![colorIndex].colorCode
                      .toString();
                  if (controller
                      .products[index].colorsList![colorIndex].colorCode
                      .toString()
                      .isNotEmpty) {
                    String replaceColor = color.replaceAll("#", "0xff");
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.px,
                          width: 15.px,
                          child: Container(
                            height: 30.px,
                            width: 15.px,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(
                                int.parse(replaceColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 1.w)
                      ],
                    );
                  }
                  return const SizedBox();
                },
                horizontalPadding: 4.w,
                physics: const ScrollPhysics(),
                itemCount: controller.products[index].colorsList!.length,
                shrinkWrap: true,
                isVertical: false,
              ),
            )
          : const SizedBox();

  Widget brandNameTextView({required int index}) => Text(
        controller.products[index].brandName.toString(),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget productNameTextView({required int index}) =>
      Text(controller.products[index].productName.toString(),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(Get.context!).textTheme.headline3);

  Widget productPriceTextView({required int index, required String text}) =>
      GradientText(
        '$curr$text',
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(overflow: TextOverflow.ellipsis),
        gradient: CommonWidgets.commonLinearGradientView(),
      );

/*Widget priceView({required int index}) {
    if ((controller.products[index].isOffer != null &&
        controller.products[index].isOffer!.isNotEmpty) &&
        controller.products[index].isOffer != "0") {
      return Column(
        children: [
          if (controller.products[index].offerPrice != null &&
              controller.products[index].offerPrice!.isNotEmpty)
            productPriceTextView(
                index: index,
                text: controller.products[index].offerPrice.toString()),
          SizedBox(height: 4.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.products[index].productPrice != null &&
                  controller.products[index].productPrice!.isNotEmpty)
                Flexible(
                  child: productOfferPriceTextView(index: index),
                ),
              SizedBox(width: .5.w),
              if (controller.products[index].percentageDis != null &&
                  controller.products[index].percentageDis!.isNotEmpty)
                Flexible(
                  child: productOfferPercentsTextView(index: index),
                ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.products[index].productPrice != null &&
              controller.products[index].productPrice!.isNotEmpty)
            Flexible(
              flex: 2,
              child: productPriceTextView(
                  index: index,
                  text: controller.products[index].productPrice.toString()),
            ),
        ],
      );
    }
  }

  Widget productOfferPriceTextView({required int index}) => Text(
    "$curr${controller.products[index].productPrice.toString()}",
    maxLines: 1,
    style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
        fontSize: 8.px,
        overflow: TextOverflow.ellipsis,
        decoration: TextDecoration.lineThrough),
    overflow: TextOverflow.ellipsis,
  );

  Widget productOfferPercentsTextView({required int index}) => Text(
    ("(${controller.products[index].percentageDis.toString()}% Off)"),
    style: Theme.of(Get.context!)
        .textTheme
        .headline3
        ?.copyWith(fontSize: 8.px, overflow: TextOverflow.ellipsis),
  );*/

/*
  Widget productsGridView1() => CustomScrollView(
    shrinkWrap: true,
    physics: controller.isLoading.value
        ? const NeverScrollableScrollPhysics()
        : const ScrollPhysics(),
    controller: controller.scrollController,
    slivers: [
      SliverGrid.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 25.h,
          childAspectRatio: 0.65,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 1.5.h,
        ),
        itemCount: controller.searchProductList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => controller.clickOnProduct(
                context: context,
                productId: controller.searchProductList[index].productId
                    .toString()),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      productImageView1(index: index),
                      SizedBox(height: 2.px),
                      // SizedBox(height: 1.4.h),
                      if (controller.searchProductList[index].brandName !=
                          null &&
                          controller.searchProductList[index].brandName!
                              .isNotEmpty)
                        brandNameTextView1(index: index),
                      if (controller.searchProductList[index].brandName !=
                          null &&
                          controller.searchProductList[index].brandName!
                              .isNotEmpty)
                        SizedBox(height: 4.px),
                      if (controller
                          .searchProductList[index].productName !=
                          null &&
                          controller.searchProductList[index].productName!
                              .isNotEmpty)
                        productNameTextView1(index: index),
                      if (controller
                          .searchProductList[index].productName !=
                          null &&
                          controller.searchProductList[index].productName!
                              .isNotEmpty)
                        SizedBox(height: 4.px),
                      priceView1(index: index),
                      SizedBox(height: 4.px),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      SliverPadding(
        sliver: SliverToBoxAdapter(
          child:  Obx(() {
            if (controller.isLoading.value) {
              return Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.px),
                child: CommonWidgets.progressBarView(height: 25.px,width: 25.px),
              );
            } else if (controller.searchProductModel?.productList?.isEmpty ?? false) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.px),
                  child:
                  CommonWidgets.noDataTextView(text: "No more data!"));
            } else {
              return const SizedBox();
            }
          }),
        ),
        padding: EdgeInsets.only(bottom: 35.px),
      )
    ],
  );
*/

//Todo Mahi
/*  Widget productsGridView1() => MasonryGridView.count(
        shrinkWrap: true,
        physics: controller.isLoading.value
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        controller: controller.scrollController,
        itemCount: controller.products.length,
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 1.5.h,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.clickOnProduct(
                context: context,
                productId:
                    controller.searchProductList[index].productId.toString()),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      productImageView1(index: index),
                      SizedBox(height: 2.px),
                      // SizedBox(height: 1.4.h),
                      if (controller.searchProductList[index].brandName !=
                              null &&
                          controller
                              .searchProductList[index].brandName!.isNotEmpty)
                        brandNameTextView1(index: index),
                      if (controller.searchProductList[index].brandName !=
                              null &&
                          controller
                              .searchProductList[index].brandName!.isNotEmpty)
                        SizedBox(height: 4.px),
                      if (controller.searchProductList[index].productName !=
                              null &&
                          controller
                              .searchProductList[index].productName!.isNotEmpty)
                        productNameTextView1(index: index),
                      if (controller.searchProductList[index].productName !=
                              null &&
                          controller
                              .searchProductList[index].productName!.isNotEmpty)
                        SizedBox(height: 4.px),
                      priceView1(index: index),
                      SizedBox(height: 4.px),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
*/

  ///Todo This GridView Widget Old
/* Widget productsGridView1() => GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 25.h,
        childAspectRatio: 0.65,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 1.5.h,
      ),
      itemCount: controller.searchProductList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => controller.clickOnProduct(
              context: context,
              productId:
                  controller.searchProductList[index].productId.toString()),
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    productImageView1(index: index),
                    SizedBox(height: 2.px),
                    // SizedBox(height: 1.4.h),
                    if (controller.searchProductList[index].brandName != null &&
                        controller
                            .searchProductList[index].brandName!.isNotEmpty)
                      brandNameTextView1(index: index),
                    if (controller.searchProductList[index].brandName != null &&
                        controller
                            .searchProductList[index].brandName!.isNotEmpty)
                      SizedBox(height: 4.px),
                    if (controller.searchProductList[index].productName !=
                            null &&
                        controller
                            .searchProductList[index].productName!.isNotEmpty)
                      productNameTextView1(index: index),
                    if (controller.searchProductList[index].productName !=
                            null &&
                        controller
                            .searchProductList[index].productName!.isNotEmpty)
                      SizedBox(height: 4.px),
                    priceView1(index: index),
                    SizedBox(height: 4.px),
                  ],
                ),
              ],
            ),
          ),
        );
      });*/

/*  Widget productImageView1({required int index}) =>
      controller.searchProductList[index].thumbnailImage != null &&
          controller.searchProductList[index].thumbnailImage
              .toString()
              .isNotEmpty
          ? SizedBox(
        height: 150.px,
        width: 150.px,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6.px)),
          child: Image.network(
            CommonMethods.imageUrl(
                url: controller.searchProductList[index].thumbnailImage
                    .toString()),
            fit: BoxFit.cover,
            // height: 150.px,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CommonWidgets.commonShimmerViewForImage();
            },
            errorBuilder: (context, error, stackTrace) =>
                CommonWidgets.defaultImage(),
          ),
        ),
      )
          : CommonWidgets.progressBarView();

  Widget brandNameTextView1({required int index}) => Text(
    controller.searchProductList[index].brandName.toString(),
    textAlign: TextAlign.center,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(Get.context!)
        .textTheme
        .subtitle1
        ?.copyWith(fontSize: 14.px),
  );

  Widget productNameTextView1({required int index}) =>
      Text(controller.searchProductList[index].productName.toString(),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(Get.context!).textTheme.headline3);

  Widget productPriceTextView1({required int index, required String text}) =>
      GradientText(
        '$curr$text',
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(overflow: TextOverflow.ellipsis),
        gradient: CommonWidgets.commonLinearGradientView(),
      );

  Widget priceView1({required int index}) {
    if ((controller.searchProductList[index].isOffer != null &&
        controller.searchProductList[index].isOffer!.isNotEmpty) &&
        controller.searchProductList[index].isOffer != "0") {
      return Column(
        children: [
          if (controller.searchProductList[index].offerPrice != null &&
              controller.searchProductList[index].offerPrice!.isNotEmpty)
            productPriceTextView(
                index: index,
                text:
                controller.searchProductList[index].offerPrice.toString()),
          SizedBox(height: 4.px),
         */ /* Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.searchProductList[index].productPrice != null &&
                  controller.searchProductList[index].productPrice!.isNotEmpty)
                Flexible(
                  child: productOfferPriceTextView(index: index),
                ),
              SizedBox(width: .5.w),
              if (controller.searchProductList[index].percentageDis != null &&
                  controller.searchProductList[index].percentageDis!.isNotEmpty)
                Flexible(
                  child: productOfferPercentsTextView(index: index),
                ),
            ],
          ),*/ /*
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.searchProductList[index].productPrice != null &&
              controller.searchProductList[index].productPrice!.isNotEmpty)
            Flexible(
              flex: 2,
              child: productPriceTextView(
                  index: index,
                  text: controller.searchProductList[index].productPrice
                      .toString()),
            ),
        ],
      );
    }
  }

  Widget productOfferPriceTextView1({required int index}) => Text(
    "$curr${controller.searchProductList[index].productPrice.toString()}",
    maxLines: 1,
    style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
        fontSize: 8.px,
        overflow: TextOverflow.ellipsis,
        decoration: TextDecoration.lineThrough),
    overflow: TextOverflow.ellipsis,
  );

  Widget productOfferPercentsTextView1({required int index}) => Text(
    ("(${controller.searchProductList[index].percentageDis.toString()}% Off)"),
    style: Theme.of(Get.context!)
        .textTheme
        .headline3
        ?.copyWith(fontSize: 8.px, overflow: TextOverflow.ellipsis),
  );*/
}
