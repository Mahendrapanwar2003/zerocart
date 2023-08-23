import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/app/modules/category/controllers/category_controller.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../custom/custom_appbar.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.absorbing.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const MyCustomContainer().myAppBar(
            text: 'Categories',
          ),
          body: Obx(() {
            if (CommonMethods.isConnect.value) {
              if (controller.getCategories.value != null) {
                if (controller.listOfCategories!.isNotEmpty) {
                  return ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        categoriesListView(context: context),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  );
                } else {
                  return CommonWidgets.noDataTextView();
                }
              } else {
                if (!controller.absorbing.value) {
                  return CommonWidgets.somethingWentWrongTextView();
                } else {
                  return const SizedBox();
                }
              }
            } else {
              return CommonWidgets.noInternetTextView();
            }
          }),
        ),
      );
    });
  }

  Widget backIconView() => Material(
        color: Colors.transparent,
        child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                size: 18.px,
                color: Theme.of(Get.context!).textTheme.subtitle1?.color),
            splashRadius: 24.px),
      );

  Widget categoryTextView() => Text(
        'Categories',
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget categoriesListView({required BuildContext context}) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listOfCategories!.length,
        itemBuilder: (context, index) {
          controller.categories = controller.listOfCategories![index];
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Zconstant.margin, vertical: 4.px),
            child: InkWell(
              onTap: () =>
                  controller.clickOnCategory(index: index, context: context),
              borderRadius: BorderRadius.circular(6.px),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: Zconstant.margin - 10.px),
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).brightness == Brightness.dark
                      ? MyColorsLight().secondary.withOpacity(0.15)
                      : MyColorsDark().secondary.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(6.px),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: Zconstant.margin - 12.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            categoryImageView(index: index),
                            SizedBox(
                              width: Zconstant.margin - 8.px,
                            ),
                            Flexible(
                                child: categoryTitleTextView(index: index)),
                            SizedBox(
                              width: Zconstant.margin - 8.px,
                            ),
                          ],
                        ),
                      ),
                      arrowView(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget categoryImageView({required int index}) => FittedBox(
        child: Container(
          height: 60.px,
          width: 64.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.px),
          ),
          child: Image.network(
            CommonMethods.imageUrl(
                url: controller.categories!.categoryImage.toString()),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CommonWidgets.commonShimmerViewForImage();
            },
            errorBuilder: (context, error, stackTrace) =>
                CommonWidgets.defaultImage(),
          ),
        ),
      );

  Widget categoryTitleTextView({required int index}) => Text(
        controller.categories!.categoryName!,
        maxLines: 1,
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget arrowView() => Icon(Icons.arrow_forward_ios_rounded,
      size: 14.px, color: Theme.of(Get.context!).textTheme.subtitle1?.color);
}
