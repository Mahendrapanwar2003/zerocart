import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_modals/get_city_model.dart';
import 'package:zerocart/app/apis/api_modals/get_state_model.dart';
import 'package:zerocart/app/common_methods/common_methods.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/dropdown_zerocart.dart';
import 'package:zerocart/app/custom/scroll_splash_gone.dart';
import 'package:zerocart/app/validator/form_validator.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: AbsorbPointer(
          absorbing: controller.absorbing.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const MyCustomContainer().myAppBar(
                isIcon: true,
                backIconOnPressed: () =>
                    controller.clickOnBackIcon(context: context),
                text: 'Update Profile'),
            body: GestureDetector(
              onTap: () => MyCommonMethods.unFocsKeyBoard(),
              child: Form(
                key: controller.key,
                child: Obx(() {
                  if (CommonMethods.isConnect.value) {
                    if (controller.responseCodeState == 200 &&
                        controller.responseCodeCity == 200 &&
                        controller.responseCodeBrandList == 200 &&
                        controller.responseCodeCategoryList == 200) {
                      if (controller.userDataMap.isNotEmpty) {
                        return Column(
                          children: [
                            Expanded(
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: CommonWidgets.commonRefreshIndicator(
                                  onRefresh: () => controller.onRefresh(),
                                  child: ListView(
                                    children: [
                                      SizedBox(
                                        height: Zconstant.margin,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              userProfilePicView(),
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: addIconButtonView(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Zconstant.margin),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 2.h),
                                            nameTextFieldView(),
                                            SizedBox(height: 2.h),
                                            emailTextFieldView(),
                                            SizedBox(height: 2.h),
                                            dobTextFieldView(),
                                            SizedBox(height: 2.h),
                                            mobileNumberTextFieldView(),
                                            /* Obx(() {
                                        return controller.isSendOtpVisible.value
                                            ? Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            sendOTPButtonView(),
                                          ],
                                        )
                                            : SizedBox(
                                          height: 0.h,
                                        );
                                      }),*/
                                            SizedBox(height: 2.h),
                                            if (controller.stateName != null &&
                                                controller.stateName != '')
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'State Name',
                                                  style: Theme.of(Get.context!)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.copyWith(
                                                        fontSize: 12.px,
                                                        color: Theme.of(
                                                                Get.context!)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(.4),
                                                      ),
                                                ),
                                              ),
                                            stateTextFieldView(),
                                            SizedBox(height: 2.h),
                                            if (controller.cityName != null &&
                                                controller.cityName != '' &&
                                                controller.cityModel != null &&
                                                controller.cityModel?.cities !=
                                                    null &&
                                                controller.cityModel!.cities!
                                                    .isNotEmpty)
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'City Name',
                                                  style: Theme.of(Get.context!)
                                                      .textTheme
                                                      .subtitle1
                                                      ?.copyWith(
                                                        fontSize: 12.px,
                                                        color: Theme.of(
                                                                Get.context!)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(.4),
                                                      ),
                                                ),
                                              ),
                                            cityTextFieldView(),
                                            SizedBox(height: 2.h),
                                            titleTextView(
                                                text: 'Type Of Products'),
                                            SizedBox(height: 1.h),
                                            SizedBox(
                                              height: 30.px,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .checkBoxTitle.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {},
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Obx(() {
                                                          return controller
                                                                      .count
                                                                      .value >=
                                                                  0
                                                              ? myCheckBox(
                                                                  checkBoxValue:
                                                                      controller.checkTypeOfProductsValue.value ==
                                                                              index.toString()
                                                                          ? true
                                                                          : false,
                                                                  onChanged:
                                                                      (value) async {
                                                                    controller
                                                                            .checkTypeOfProductsValue
                                                                            .value =
                                                                        index
                                                                            .toString();
                                                                    controller
                                                                        .checkValue
                                                                        .value = value!;
                                                                  },
                                                                )
                                                              : const SizedBox();
                                                        }),
                                                        titleTextView(
                                                            text: controller
                                                                .checkBoxTitle[
                                                                    index]
                                                                .toString()),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            if (controller
                                                .fashionCategoryList.isNotEmpty)
                                              Obx(() {
                                                return controller.count.value >=
                                                        0
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          titleTextView(
                                                              text:
                                                                  'Fashion Category'),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Theme.of(context)
                                                                              .brightness ==
                                                                          Brightness
                                                                              .light
                                                                      ? MyColorsLight()
                                                                          .onPrimary
                                                                          .withOpacity(
                                                                              .1)
                                                                      : MyColorsLight()
                                                                          .onPrimary,
                                                                  width: 1.px,
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                MultiSelectBottomSheetField(
                                                              initialValue:
                                                                  controller
                                                                      .selectFashionCategoryList
                                                                      .toList(),
                                                              title: Text(
                                                                'Select Fashion Brands',
                                                                style: Theme.of(Get
                                                                        .context!)
                                                                    .textTheme
                                                                    .subtitle2
                                                                    ?.copyWith(
                                                                        fontSize: 16
                                                                            .px,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w800,
                                                                        color: MyColorsLight()
                                                                            .onText),
                                                              ),
                                                              unselectedColor:
                                                                  MyColorsDark()
                                                                      .onPrimary
                                                                      .withOpacity(
                                                                          .4),
                                                              backgroundColor:
                                                                  MyColorsLight()
                                                                      .secondary,
                                                              buttonIcon: Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  size: 22.px),
                                                              selectedItemsTextStyle: Theme
                                                                      .of(Get
                                                                          .context!)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          16.px,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: MyColorsLight()
                                                                          .primaryColor),
                                                              selectedColor:
                                                                  MyColorsDark()
                                                                      .primaryColor,
                                                              searchable: true,
                                                              searchHint:
                                                                  "Search",
                                                              separateSelectedItems:
                                                                  true,
                                                              closeSearchIcon: Icon(
                                                                  Icons.close,
                                                                  color: MyColorsLight()
                                                                      .onText),
                                                              searchHintStyle: Theme
                                                                      .of(Get
                                                                          .context!)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          16.px,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: MyColorsLight()
                                                                          .dashMenuColor),
                                                              searchIcon: Icon(
                                                                  Icons.search,
                                                                  color: MyColorsLight()
                                                                      .onText),
                                                              searchTextStyle:
                                                                  Theme.of(Get
                                                                          .context!)
                                                                      .textTheme
                                                                      .subtitle2
                                                                      ?.copyWith(
                                                                        fontSize:
                                                                            16.px,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        color: MyColorsLight()
                                                                            .onText,
                                                                      ),
                                                              chipDisplay:
                                                                  MultiSelectChipDisplay
                                                                      .none(),
                                                              buttonText: Text(
                                                                'Select Fashion Category',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            Get.context!)
                                                                        .colorScheme
                                                                        .onSecondary),
                                                              ),
                                                              initialChildSize:
                                                                  0.4,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    color: MyColorsLight()
                                                                        .backgroundFilterColor,
                                                                    width:
                                                                        .5.px),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.px),
                                                              ),
                                                              listType:
                                                                  MultiSelectListType
                                                                      .LIST,
                                                              items: controller
                                                                  .fashionCategoryList
                                                                  .map(
                                                                    (e) => MultiSelectItem(
                                                                        e,
                                                                        e.name
                                                                            .toString()),
                                                                  )
                                                                  .toList(),
                                                              onConfirm:
                                                                  (value) {
                                                                controller
                                                                        .selectedFashionCategory =
                                                                    value;
                                                                controller
                                                                        .useObx
                                                                        .value =
                                                                    value;
                                                                controller
                                                                    .fashionCategoryId
                                                                    .clear();
                                                                for (var element
                                                                    in controller
                                                                        .selectedFashionCategory) {
                                                                  controller
                                                                      .fashionCategoryId
                                                                      .add(element
                                                                          .fashionCategoryId);
                                                                  controller.selectFashionCategoryList = controller
                                                                      .fashionCategoryList
                                                                      .where((element) => controller
                                                                          .fashionCategoryId
                                                                          .contains(element.fashionCategoryId ??
                                                                              ''));
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: 1.h),
                                                          my(
                                                            items: controller
                                                                .selectFashionCategoryList
                                                                .map((e) =>
                                                                    MultiSelectItem(
                                                                        e,
                                                                        e.name
                                                                            .toString()))
                                                                .toList(),
                                                            scrollController:
                                                                ScrollController(),
                                                            scroll: true,
                                                            scrollBar:
                                                                HorizontalScrollBar(
                                                                    isAlwaysShown:
                                                                        true),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: MyColorsLight()
                                                                    .backgroundFilterColor,
                                                                width: .5.px,
                                                              ),
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: MyColorsLight()
                                                                      .backgroundFilterColor,
                                                                  width: .5.px),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.px),
                                                            ),
                                                            chipColor: Colors
                                                                .transparent,
                                                            textStyle: Theme.of(
                                                                    Get
                                                                        .context!)
                                                                .textTheme
                                                                .subtitle2
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        12.px),
                                                            list: controller
                                                                .selectedFashionCategory,
                                                          ),
                                                          SizedBox(height: 1.h),
                                                        ],
                                                      )
                                                    : const SizedBox();
                                              }),
                                            SizedBox(height: 2.h),
                                            if (controller.brandList.isNotEmpty)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  titleTextView(
                                                      text: 'Favourite Brand'),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? MyColorsLight()
                                                                  .onPrimary
                                                                  .withOpacity(
                                                                      .1)
                                                              : MyColorsLight()
                                                                  .onPrimary,
                                                          width: 1.px,
                                                        ),
                                                      ),
                                                    ),
                                                    child:
                                                        MultiSelectBottomSheetField(
                                                      initialValue: controller
                                                          .selectBrandList
                                                          .toList(),
                                                      title: Text(
                                                        'Select Fashion Brands',
                                                        style: Theme.of(
                                                                Get.context!)
                                                            .textTheme
                                                            .subtitle2
                                                            ?.copyWith(
                                                                fontSize: 16.px,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color:
                                                                    MyColorsLight()
                                                                        .onText),
                                                      ),
                                                      unselectedColor:
                                                          MyColorsDark()
                                                              .onPrimary
                                                              .withOpacity(.4),
                                                      backgroundColor:
                                                          MyColorsLight()
                                                              .secondary,
                                                      buttonIcon: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 22.px),
                                                      selectedItemsTextStyle: Theme
                                                              .of(Get.context!)
                                                          .textTheme
                                                          .subtitle2
                                                          ?.copyWith(
                                                              fontSize: 16.px,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color: MyColorsLight()
                                                                  .primaryColor),
                                                      selectedColor:
                                                          MyColorsDark()
                                                              .primaryColor,
                                                      searchable: true,
                                                      searchHint: "Search",
                                                      separateSelectedItems:
                                                          true,
                                                      closeSearchIcon: Icon(
                                                          Icons.close,
                                                          color: MyColorsLight()
                                                              .onText),
                                                      searchHintStyle: Theme.of(
                                                              Get.context!)
                                                          .textTheme
                                                          .subtitle2
                                                          ?.copyWith(
                                                              fontSize: 16.px,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color: MyColorsLight()
                                                                  .dashMenuColor),
                                                      searchIcon: Icon(
                                                          Icons.search,
                                                          color: MyColorsLight()
                                                              .onText),
                                                      searchTextStyle:
                                                          Theme.of(Get.context!)
                                                              .textTheme
                                                              .subtitle2
                                                              ?.copyWith(
                                                                fontSize: 16.px,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color:
                                                                    MyColorsLight()
                                                                        .onText,
                                                              ),
                                                      chipDisplay:
                                                          MultiSelectChipDisplay
                                                              .none(),
                                                      buttonText: Text(
                                                          'Select Favourite Brand',
                                                          style: TextStyle(
                                                              color: Theme.of(Get
                                                                      .context!)
                                                                  .colorScheme
                                                                  .onSecondary)),
                                                      initialChildSize: 0.4,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: MyColorsLight()
                                                                .backgroundFilterColor,
                                                            width: .5.px),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.px),
                                                      ),
                                                      listType:
                                                          MultiSelectListType
                                                              .LIST,
                                                      items: controller
                                                          .brandList
                                                          .map((e) =>
                                                              MultiSelectItem(
                                                                  e,
                                                                  e.brandName
                                                                      .toString()))
                                                          .toList(),
                                                      onConfirm: (value) {
                                                        controller
                                                                .selectedBrands =
                                                            value;
                                                        controller.brandId
                                                            .clear();
                                                        controller.useObx
                                                            .value = value;
                                                        for (var element
                                                            in controller
                                                                .selectedBrands) {
                                                          controller.brandId
                                                              .add(element
                                                                  .brandId);
                                                          controller.selectBrandList = controller
                                                              .brandList
                                                              .where((element) =>
                                                                  controller
                                                                      .brandId
                                                                      .contains(
                                                                          element.brandId ??
                                                                              ''));
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  my(
                                                    items: controller
                                                        .selectBrandList
                                                        .map((e) =>
                                                            MultiSelectItem(
                                                                e,
                                                                e.brandName
                                                                    .toString()))
                                                        .toList(),
                                                    scrollController:
                                                        ScrollController(),
                                                    scroll: true,
                                                    scrollBar:
                                                        HorizontalScrollBar(
                                                            isAlwaysShown:
                                                                true),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: MyColorsLight()
                                                            .backgroundFilterColor,
                                                        width: .5.px,
                                                      ),
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: MyColorsLight()
                                                              .backgroundFilterColor,
                                                          width: .5.px),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.px),
                                                    ),
                                                    chipColor:
                                                        Colors.transparent,
                                                    textStyle:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .subtitle2
                                                            ?.copyWith(
                                                                fontSize:
                                                                    12.px),
                                                    list: controller
                                                        .selectedBrands,
                                                  ),
                                                ],
                                              ),
                                            SizedBox(
                                                height: Zconstant.margin * 5),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: Zconstant.margin),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            submitButtonView(context: context),
                            SizedBox(height: Zconstant.margin),
                          ],
                        );
                      } else {
                        return CommonWidgets.commonNoDataFoundImage(
                          onRefresh: () => controller.onRefresh(),
                        );
                      }
                    } else {
                      if (controller.responseCodeState == 0 ||
                          controller.responseCodeCity == 0 ||
                          controller.responseCodeBrandList == 0 ||
                          controller.responseCodeCategoryList == 0) {
                        return const SizedBox();
                      } else {
                        return CommonWidgets.commonSomethingWentWrongImage(
                          onRefresh: () => controller.onRefresh(),
                        );
                      }
                    }
                  } else {
                    return CommonWidgets.commonNoInternetImage(
                      onRefresh: () => controller.onRefresh(),
                    );
                  }
                }),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget backIconView({required BuildContext context}) => Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: () => controller.clickOnBackIcon(context: context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(Get.context!).textTheme.subtitle1?.color,
          ),
          splashRadius: 24.px,
          iconSize: 18.px,
        ),
      );

  Widget updateProfileTextView() => Text(
        "Update Profile",
        style: Theme.of(Get.context!).textTheme.subtitle1,
      );

  Widget userProfilePicView() => SizedBox(
        height: 158.px,
        child: Container(
          width: 158.px,
          height: 138.px,
          decoration: BoxDecoration(
            border:
                Border.all(width: 0.5.px, color: MyColorsLight().borderColor),
            borderRadius: BorderRadius.circular(80.px),
            image: DecorationImage(
              image: controller.selectImage(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  addIconButtonView() => CommonWidgets.myElevatedButton(
      height: 44.px,
      width: 44.px,
      borderRadius: 22.px,
      text: Icon(
        Icons.camera_alt,
        size: 20.px,
        color: MyColorsLight().secondary,
      ),
      onPressed: () {
        controller.clickOnCameraIcon();
      });

  Widget nameTextFieldView() => CommonWidgets.myTextField(
        validator: (value) => FormValidator.isNameValid(value: value),
        labelText: 'Name',
        hintText: 'Name',
        inputType: TextInputType.name,
        iconVisible: false,
        controller: controller.nameController,
      );

  Widget emailTextFieldView() => CommonWidgets.myTextField(
      validator: (value) => FormValidator.isEmailValid(value: value),
      labelText: 'Security Email',
      hintText: 'Security Email',
      inputType: TextInputType.emailAddress,
      iconVisible: false,
      controller: controller.securityEmailController);

/*  Widget dobTextFieldView() => TextFormField(
        controller: controller.dobController,
        decoration: InputDecoration(
          labelText: "DOB",
          hintText: 'DD/MM/YYYY',
          hintStyle: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
              fontSize: 16.px,
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
          labelStyle: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
        ),
        keyboardType: TextInputType.datetime,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle2
            ?.copyWith(fontSize: 16.px),
        readOnly: true,
        onTap: () => controller.pickDate(),
      );*/

  Widget dobTextFieldView() => TextFormField(
      onTap: () => controller.pickDate(),
      controller: controller.dobController,
      validator: (value) => FormValidator.isDobForYYYYMMDD(value: value),
      decoration: InputDecoration(
        labelText: "Date Of Birth",
        hintText: 'YYYY-MM-DD',
        hintStyle: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
            fontSize: 16.px,
            color:
                Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
        labelStyle: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
            color:
                Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
      ),
      style:
          Theme.of(Get.context!).textTheme.subtitle2?.copyWith(fontSize: 16.px),
      keyboardType: TextInputType.none,
      readOnly: true);

  Widget mobileNumberTextFieldView() => CommonWidgets.myTextField(
        labelText: 'Security Mobile Number',
        hintText: '0123456789',
        inputType: TextInputType.number,
        maxLength: 10,
        //iconVisible: controller.isSubmitButtonVisible.value,
        controller: controller.securityMobileNumberController,
        validator: (value) => FormValidator.isNumberValid(value: value),
        // readOnly: controller.isSubmitButtonVisible.value,
        icon: IconButton(
          onPressed: () {},
          icon:
              Icon(Icons.verified, color: MyColorsLight().success, size: 20.px),
          splashRadius: 24.px,
        ),
        onChanged: (value) {
          if (value.toString().isNotEmpty) {
            //  controller.isSendOtpVisible.value = true;
          } else {
            // controller.isSendOtpVisible.value = false;
          }
        },
        iconVisible: false,
      );

/*
  Widget sendOTPButtonView() {
    return Obx(() {
      if (!controller.isSendOtpButtonClicked.value) {
        return Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            CommonWidgets.myElevatedButton(
              height: 25.px,
              width: 20.w,
              borderRadius: 5.px,
              onPressed: !controller.isSendOtpButtonClicked.value
                  ? () => controller.clickOnSendOtpButton()
              // ignore: avoid_returning_null_for_void
                  : () => null,
              text: Text('Send OTP',
                  style: Theme
                      .of(Get.context!)
                      .textTheme
                      .subtitle1
                      ?.copyWith(
                      color: MyColorsLight().secondary, fontSize: 12.px)),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            CommonWidgets.myElevatedButton(
              text: CommonWidgets.registrationOtpButtonProgressBar(),
              // ignore: avoid_returning_null_for_void
              onPressed: () => null,
              height: 25.px,
              width: 20.w,
              borderRadius: 5.px,
            )
          ],
        );
      }
    });
  }
*/
/*
  Widget sendOTPButtonView() {
    return Obx(() {
      if (!controller.isSendOtpButtonClicked.value) {
        return Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            CommonWidgets.myElevatedButton(
              height: 25.px,
              width: 20.w,
              borderRadius: 5.px,
              onPressed: !controller.isSendOtpButtonClicked.value
                  ? () => controller.clickOnSendOtpButton()
              // ignore: avoid_returning_null_for_void
                  : () => null,
              text: Text('Send OTP',
                  style: Theme
                      .of(Get.context!)
                      .textTheme
                      .subtitle1
                      ?.copyWith(
                      color: MyColorsLight().secondary, fontSize: 12.px)),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            CommonWidgets.myElevatedButton(
              text: CommonWidgets.registrationOtpButtonProgressBar(),
              // ignore: avoid_returning_null_for_void
              onPressed: () => null,
              height: 25.px,
              width: 20.w,
              borderRadius: 5.px,
            )
          ],
        );
      }
    });
  }
*/

  Widget stateTextFieldView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.stateModel != null &&
            controller.stateModel?.states != null &&
            controller.stateModel!.states!.isNotEmpty)
          SizedBox(
            height: 6.h,
            child: DropdownZeroCart(
              wantDividerError: controller.isStateSelectedValue.value,
              selected: controller.selectedState,
              items: controller.stateModel!.states!
                  .map(
                    (States e) => DropdownMenuItem<States>(
                      value: e,
                      child: Text(e.name.toString()),
                    ),
                  )
                  .toList(),
              hint: controller.stateName != ''
                  ? Text(
                      "${controller.stateName}",
                      style: Theme.of(Get.context!)
                          .textTheme
                          .subtitle2
                          ?.copyWith(
                              fontSize: 16.px,
                              color:
                                  Theme.of(Get.context!).colorScheme.onSurface),
                    )
                  : Text(
                      'Select State',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .subtitle2
                          ?.copyWith(
                              fontSize: 16.px,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.4)),
                    ),
              onChanged: (States? value) async {
                controller.inAsyncCall.value=true;
                if (value?.id != controller.stateId) {
                  controller.selectedState = value;
                  controller.stateId = value?.id ?? '';
                  controller.stateName = value?.name;
                  if (value != null && value.id != null) {
                    controller.cityName = '';
                    controller.cityId = "";
                    controller.selectedCity = null;
                    controller.cityModel = null;
                    controller.isStateSelectedValue.value = false;
                    await controller.getCityApiCalling(
                        sId: controller.stateId.toString());
                  }
                }
                controller.inAsyncCall.value=false;
              },
            ),
          ),
        if (controller.isStateSelectedValue.value) SizedBox(height: 5.px),
        if (controller.isStateSelectedValue.value)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.px),
            child: Text(
              'Please Select State',
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontSize: 14.px, color: MyColorsLight().error),
            ),
          ),
      ],
    );
  }

  //3145.76

/*  Widget stateTextFieldView() {
    return DropdownSearch<States>(
      items: controller.stateModel.value!.states!,
      selectedItem: controller.selectedState.value,
      itemAsString: (item) {
        if(item != null)
        {
          return "${item.name}";
        }
        return "${controller.userDataMap[UserDataKeyConstant.selectedCity]}";
      },
      onChanged: (value) async {
        controller.isCityTextFieldNotVisible.value = true;
        controller.stateId = value?.id;
        await controller.getCityApiCalling(sId: controller.stateId!);
        controller.isCityTextFieldNotVisible.value = false;
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: const InputDecoration(
            labelText: "Select state",
            hintText: "Select state",
          ),
          baseStyle: Theme
              .of(Get.context!)
              .textTheme
              .subtitle2
              ?.copyWith(fontSize: 16.px)),
      popupProps: const PopupProps.dialog(
          showSearchBox: true,
          dialogProps: DialogProps(elevation: 16)
      ),
    );
  }*/

  Widget cityTextFieldView() {
    if (controller.cityModel != null &&
        controller.cityModel?.cities != null &&
        controller.cityModel!.cities!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 6.h,
            child: DropdownZeroCart(
              wantDividerError: controller.isCitySelectedValue.value,
              selected: controller.selectedCity,
              items: controller.citiesList
                  .map(
                    (Cities e) => DropdownMenuItem<Cities>(
                      value: e,
                      child: Text(e.name.toString()),
                    ),
                  )
                  .toList(),
              hint: controller.cityName != ''
                  ? Text(
                      "${controller.cityName}",
                      style: Theme.of(Get.context!)
                          .textTheme
                          .subtitle2
                          ?.copyWith(
                              fontSize: 16.px,
                              color:
                                  Theme.of(Get.context!).colorScheme.onSurface),
                    )
                  : Text(
                      'Select City',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .subtitle2
                          ?.copyWith(
                              fontSize: 16.px,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(Get.context!)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.4)),
                    ),
              onChanged: (Cities? value) async {
                controller.selectedCity = value;
                controller.cityId = value?.id ?? '';
                controller.cityName = value?.name;
                if (value != null && value.id != null) {
                  controller.isCitySelectedValue.value = false;
                }
              },
            ),
          ),
          if (controller.isCitySelectedValue.value) SizedBox(height: 5.px),
          if (controller.isCitySelectedValue.value)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.px),
              child: Text(
                'Please Select City',
                style: Theme.of(Get.context!)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: 14.px, color: MyColorsLight().error),
              ),
            ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

/*  Widget cityTextFieldView() {
    return DropdownSearch<Cities>(
      items: controller.citiesList!,
      selectedItem: controller.selectedCity.value,
      itemAsString: (item) {
        if(item != null)
          {
            return "${item.name}";
          }
        return "${controller.userDataMap[UserDataKeyConstant.selectedCity]}";
      },
      onChanged: (value) {
        controller.selectedCity.value = value!;
        controller.cityId = value.id;
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: const InputDecoration(
            labelText: "Select city",
            hintText: "Select city",
          ),
          baseStyle: Theme
              .of(Get.context!)
              .textTheme
              .subtitle2
              ?.copyWith(fontSize: 16.px)),
      popupProps: const PopupProps.dialog(
          showSearchBox: true,
          dialogProps: DialogProps(elevation: 16)
      ),
    );
  }*/
  Widget titleTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 14.px),
      );

  Widget myCheckBox(
          {required bool checkBoxValue,
          required ValueChanged<bool?> onChanged}) =>
      Checkbox(
        checkColor: Theme.of(Get.context!).brightness == Brightness.light
            ? MyColorsLight().text
            : MyColorsDark().text,
        activeColor: Theme.of(Get.context!).brightness == Brightness.light
            ? MyColorsDark().text
            : MyColorsLight().text,
        value: checkBoxValue,
        onChanged: onChanged,
      );

  Widget my(
      {Function(Value)? onTap,
      Color? chipColor,
      required List<MultiSelectItem>? items,
      required List<dynamic>? list,
      Alignment? alignment,
      BoxDecoration? decoration,
      TextStyle? textStyle,
      Color? Function()? colorator,
      Icon? icon,
      ShapeBorder? shape,
      required bool scroll,
      HorizontalScrollBar? scrollBar,
      required ScrollController scrollController,
      double? height,
      double? chipWidth,
      bool? disabled}) {
    // ignore: invalid_use_of_protected_member
    controller.useObx.value;
    if (items == null || items.isEmpty) return Container();
    return Container(
        decoration: decoration,
        alignment: alignment ?? Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: scroll ? 0 : 10),
        child: /*scroll
          ?*/
            Container(
          padding: EdgeInsets.symmetric(horizontal: 2.px),
          width: MediaQuery.of(Get.context!).size.width,
          height: height ?? MediaQuery.of(Get.context!).size.height * 0.08,
          child: scrollBar != null
              ? ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Scrollbar(
                    thumbVisibility: scrollBar.isAlwaysShown,
                    controller: scrollController,
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (ctx, index) {
                        return _buildItem(
                            item: items[index],
                            scroll: true,
                            items: items,
                            onTap: onTap,
                            icon: icon);
                      },
                    ),
                  ),
                )
              : ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return _buildItem(
                          item: items[index],
                          scroll: true,
                          items: items,
                          onTap: onTap,
                          icon: icon);
                    },
                  ),
                ),
        )
        /*: Wrap(
        children: items != null
            ? items!.map((item) => _buildItem(item!, Get.context!)).toList()
            : <Widget>[
          Container(),
        ],
      ),*/
        );
  }

  Widget _buildItem(
      {required List<dynamic> items,
      Function(Value)? onTap,
      Color? chipColor,
      TextStyle? textStyle,
      required MultiSelectItem item,
      Color? colorator,
      Icon? icon,
      ShapeBorder? shape,
      required bool scroll,
      double? chipWidth}) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        shape: shape as OutlinedBorder?,
        avatar: icon != null
            ? Icon(
                icon.icon,
                color: colorator != null
                    ? colorator.withOpacity(1)
                    : icon.color ?? Theme.of(Get.context!).primaryColor,
              )
            : null,
        label: SizedBox(
          width: chipWidth,
          child: Text(
            item.label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorator != null
                  ? textStyle != null
                      ? textStyle.color ?? colorator
                      : colorator
                  : textStyle != null && textStyle.color != null
                      ? textStyle.color
                      : chipColor?.withOpacity(1),
              fontSize: textStyle?.fontSize,
            ),
          ),
        ),
        selected: items.contains(item),
        selectedColor: colorator ??
            chipColor ??
            Theme.of(Get.context!).primaryColor.withOpacity(0.33),
        onSelected: (_) {
          if (onTap != null) onTap(item.value);
        },
      ),
    );
  }

  Widget submitButtonView({required BuildContext context}) {
    return Obx(() {
      if (!controller.isSubmitButtonClicked.value) {
        return CommonWidgets.myElevatedButton(
          text: Text('Submit', style: Theme.of(Get.context!).textTheme.button),
          onPressed: () => controller.clickOnSubmitButton(context: context),
          height: 52.px,
        );
      } else {
        return CommonWidgets.myElevatedButton(
          text: CommonWidgets.buttonProgressBarView(),
          // ignore: avoid_returning_null_for_void
          onPressed: () => null,
          height: 52.px,
        );
      }
    });
  }
}
