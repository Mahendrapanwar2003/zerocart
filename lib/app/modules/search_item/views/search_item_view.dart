import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../apis/api_modals/get_categories_modal.dart';
import '../../../common_methods/common_methods.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../custom/custom_appbar.dart';
import '../../../custom/dropdown_zerocart.dart';
import '../controllers/search_item_controller.dart';

class SearchItemView extends GetView<SearchItemController> {
  const SearchItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: GestureDetector(
          onTap: () => MyCommonMethods.unFocsKeyBoard(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Obx(
              () {
                controller.count.value;
                if (CommonMethods.isConnect.value) {
                  if ((controller.categoriesModal != null ||
                          controller.searchProductSuggestionModel != null) &&
                      controller.responseCode == 200) {
                    if (controller.listOfCategories.isNotEmpty ||
                        controller.suggestionList.isNotEmpty) {
                      return CommonWidgets.commonRefreshIndicator(
                        onRefresh: () => controller.onRefresh(),
                        child: Stack(
                          children: [
                            ListView(
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
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
                                            .myCustomContainer(
                                          isSearchActive: true,
                                          isSearch: controller.isSearch,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (controller.suggestionList.isNotEmpty)
                                      suggestionsList(),
                                    if (controller.suggestionList.isEmpty)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: Zconstant.margin16,
                                          ),
                                          CommonWidgets.noDataTextView(
                                              text: "No Product Found"),
                                          SizedBox(
                                            height: Zconstant.margin16,
                                          )
                                        ],
                                      ),
                                    CommonWidgets.profileMenuDash(),
                                    SizedBox(height: 4.5.h),
                                    customizeYourWardrobeButton(),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.5),
                                  child: const MyCustomContainer()
                                      .myCustomContainer(
                                    isSearchActive: true,
                                    isSearch: controller.isSearch,
                                    categoriesDropdown: categoriesDropdown(),
                                    textEditingController:
                                        controller.searchController,
                                    onFieldSubmitted: (value) => controller
                                        .clickOnSearchInTextField(value: value),
                                    onChanged: (value) => controller
                                        .onChangeSearchTextField(value: value),
                                  ),
                                ),
                              ],
                            ),
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
        ),
      );
    });
  }

  Widget categoriesDropdown() {
    return DropdownZeroCart<Categories>(
      wantDivider: false,
      hint: Text(
        "Category",
        style:
            Theme.of(Get.context!).textTheme.caption?.copyWith(fontSize: 10.px),
      ),
      icon: Icon(Icons.keyboard_arrow_down_rounded,
          color: MyColorsLight().textGrayColor, size: 18.px),
      selected: controller.categoryObject,
      items: controller.listOfCategories.reversed
          .map(
            (Categories e) => DropdownMenuItem<Categories>(
              value: e,
              child: Text(
                e.categoryName.toString(),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 10.px),
              ),
            ),
          )
          .toList(),
      onChanged: (Categories? value) async {
        controller.categoryObject = value;
      },
    );
  }

  Widget suggestionsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.suggestionList.length,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => controller.clickOnSearchedListIem(index: index),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
            child: Row(
              children: [
                controller.searchController.value.text.trim().toString().isEmpty
                    ? Expanded(
                        flex: 1,
                        child: commonIconButton(
                          icon: const Icon(Icons.access_time_sharp),
                          onPressed: () => {},
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  flex: 5,
                  child: RichText(
                    strutStyle: StrutStyle(
                      fontSize: 12.px,
                    ),
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text:
                          controller.suggestionList[index].resName ?? "Search",
                      style: Theme.of(Get.context!).textTheme.subtitle2,
                      children: <TextSpan>[
                        if (controller.suggestionList[index].inSearch != null &&
                            controller.suggestionList[index].inSearch != '')
                          TextSpan(
                            text:
                                "  ${controller.suggestionList[index].inSearch}",
                            style: Theme.of(Get.context!)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 10.px),
                          ),
                      ],
                    ),
                  ),
                ),
                controller.searchController.value.text.trim().toString().isEmpty
                    ? Expanded(
                        flex: 1,
                        child: commonIconButton(
                          icon: Image.asset("assets/search_arrow.png"),
                          onPressed: () =>
                              controller.clickOnArrowIcon(index: index),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CommonWidgets.profileMenuDash();
      },
    );
  }

  Widget customizeYourWardrobeButton() {
    return CommonWidgets.myOutlinedButton(
      radius: 5.px,
      text: Text(
        'Customize Your Wardrobe',
        style: Theme.of(Get.context!).textTheme.subtitle1,
      ),
      onPressed: () {
        MyCommonMethods.unFocsKeyBoard();
      },
      //width: 65.w,
      height: 42.px,
    );
  }

  Widget commonIconButton(
          {required Widget icon, required VoidCallback onPressed}) =>
      IconButton(
        constraints: const BoxConstraints(),
        onPressed: onPressed,
        icon: icon,
        color: MyColorsLight().textGrayColor,
        iconSize: 16,
        splashRadius: 20,
      );
}
