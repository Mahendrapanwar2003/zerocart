import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/app/apis/api_modals/get_state_model.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/custom/dropdown_zerocart.dart';
import 'package:zerocart/app/validator/form_validator.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../../../../my_common_method/my_common_method.dart';
import '../../../apis/api_modals/get_city_model.dart';
import '../../../constant/zconstant.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AbsorbPointer(
        absorbing: controller.absorbing.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Obx(
            () {
              return controller.isResponse.value
                  ? GestureDetector(
                      onTap: () => MyCommonMethods.unFocsKeyBoard(),
                      child: Form(
                        key: controller.key,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Zconstant.margin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView(
                                  physics: const ScrollPhysics(),
                                  children: [
                                    SizedBox(height: 10.h),
                                    Center(
                                        child: CommonWidgets.zeroCartImage()),
                                    SizedBox(
                                      height: Zconstant.margin + 10.px,
                                    ),
                                    wellComeTextView(),
                                    SizedBox(height: 2.h),
                                    nameTextFieldView(),
                                    SizedBox(height: 2.h),
                                    emailTextFieldView(),
                                    SizedBox(height: 2.h),
                                    mobileNumberTextFieldView(),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    passwordTextFieldView(),
                                    SizedBox(height: 2.h),
                                    confirmPasswordTextFieldView(),
                                    SizedBox(height: 2.h),
                                    stateTextFieldView(),
                                    SizedBox(height: 2.h),
                                    cityTextFieldView(),
                                    SizedBox(height: 1.h),
                                    titleTextView(text: 'Type Of Products'),
                                    SizedBox(height: 1.h),
                                    SizedBox(
                                      height: 30.px,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.checkBoxTitle.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Obx(() {
                                                  return controller
                                                              .count.value >=
                                                          0
                                                      ? myCheckBox(
                                                          checkBoxValue: controller
                                                                      .checkTypeOfProductsValue
                                                                      .value ==
                                                                  index
                                                                      .toString()
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
                                                        .checkBoxTitle[index]
                                                        .toString()),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    if (controller.fashionCategoryList !=
                                            null &&
                                        controller
                                            .fashionCategoryList!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          titleTextView(
                                              text: 'Fashion Category'),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? MyColorsLight()
                                                          .onPrimary
                                                          .withOpacity(.1)
                                                      : MyColorsLight()
                                                          .onPrimary,
                                                  width: 1.px,
                                                ),
                                              ),
                                            ),
                                            child: MultiSelectBottomSheetField(
                                              buttonText: Text(
                                                  'Select Fashion Category',
                                                  style: TextStyle(
                                                      color:
                                                          Theme.of(Get.context!)
                                                              .colorScheme
                                                              .onSecondary)),
                                              initialChildSize: 0.4,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: MyColorsLight()
                                                        .backgroundFilterColor,
                                                    width: .5.px),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.px),
                                              ),
                                              listType:
                                                  MultiSelectListType.LIST,
                                              items: controller
                                                  .fashionCategoryList!
                                                  .map(
                                                    (e) => MultiSelectItem(
                                                      e,
                                                      e.name.toString(),
                                                    ),
                                                  )
                                                  .toList(),
                                              onConfirm: (value) {
                                                controller
                                                    .selectedFashionCategory
                                                    .value = value;
                                                for (var element in controller
                                                    .selectedFashionCategory) {
                                                  controller.fashionCategoryId
                                                      .add(element
                                                          .fashionCategoryId);
                                                }
                                              },
                                              title: Text(
                                                'Select Fashion Category',
                                                style: Theme.of(Get.context!)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.copyWith(
                                                        fontSize: 16.px,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: MyColorsLight()
                                                            .onText),
                                              ),
                                              unselectedColor: MyColorsDark()
                                                  .onPrimary
                                                  .withOpacity(.4),
                                              backgroundColor:
                                                  MyColorsLight().secondary,
                                              buttonIcon: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 22.px),
                                              selectedItemsTextStyle:
                                                  Theme.of(Get.context!)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.copyWith(
                                                          fontSize: 16.px,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: MyColorsLight()
                                                              .primaryColor),
                                              selectedColor:
                                                  MyColorsDark().primaryColor,
                                              searchable: true,
                                              searchHint: "Search",
                                              separateSelectedItems: true,
                                              closeSearchIcon: Icon(Icons.close,
                                                  color:
                                                      MyColorsLight().onText),
                                              searchHintStyle:
                                                  Theme.of(Get.context!)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.copyWith(
                                                          fontSize: 16.px,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: MyColorsLight()
                                                              .dashMenuColor),
                                              searchIcon: Icon(Icons.search,
                                                  color:
                                                      MyColorsLight().onText),
                                              searchTextStyle: Theme.of(
                                                      Get.context!)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.copyWith(
                                                    fontSize: 16.px,
                                                    fontWeight: FontWeight.w800,
                                                    color:
                                                        MyColorsLight().onText,
                                                  ),
                                              chipDisplay:
                                                  MultiSelectChipDisplay.none(),
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Obx(() {
                                            return controller.count.value >= 0
                                                ? my(
                                                    items: controller
                                                        // ignore: invalid_use_of_protected_member
                                                        .selectedFashionCategory
                                                        .value
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
                                                        // ignore: invalid_use_of_protected_member
                                                        .selectedFashionCategory
                                                        .value,
                                                  )
                                                : const SizedBox();
                                          }),
                                          SizedBox(height: 1.h),
                                        ],
                                      ),
                                    if (controller.brandList != null &&
                                        controller.brandList!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          titleTextView(
                                              text: 'Favourite Brand'),
                                          SizedBox(height: 1.h),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? MyColorsLight()
                                                        .onPrimary
                                                        .withOpacity(.1)
                                                    : MyColorsLight().onPrimary,
                                                width: 1.px,
                                              ),
                                            )),
                                            child: MultiSelectBottomSheetField(
                                              buttonText: Text(
                                                  'Select Favourite Brand',
                                                  style: TextStyle(
                                                      color:
                                                          Theme.of(Get.context!)
                                                              .colorScheme
                                                              .onSecondary)),
                                              initialChildSize: 0.4,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: MyColorsLight()
                                                        .backgroundFilterColor,
                                                    width: .5.px),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.px),
                                              ),
                                              listType:
                                                  MultiSelectListType.LIST,
                                              items: controller.brandList!
                                                  .map((e) => MultiSelectItem(e,
                                                      e.brandName.toString()))
                                                  .toList(),
                                              onConfirm: (value) {
                                                controller.selectedBrands
                                                    .value = value;
                                                for (var element in controller
                                                    .selectedBrands) {
                                                  controller.idBrand
                                                      .add(element.brandId);
                                                }
                                              },
                                              title: Text(
                                                'Select Fashion Brands',
                                                style: Theme.of(Get.context!)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.copyWith(
                                                        fontSize: 16.px,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: MyColorsLight()
                                                            .onText),
                                              ),
                                              unselectedColor: MyColorsDark()
                                                  .onPrimary
                                                  .withOpacity(.4),
                                              backgroundColor:
                                                  MyColorsLight().secondary,
                                              buttonIcon: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 22.px),
                                              selectedItemsTextStyle:
                                                  Theme.of(Get.context!)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.copyWith(
                                                          fontSize: 16.px,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: MyColorsLight()
                                                              .primaryColor),
                                              selectedColor:
                                                  MyColorsDark().primaryColor,
                                              searchable: true,
                                              searchHint: "Search",
                                              separateSelectedItems: true,
                                              closeSearchIcon: Icon(Icons.close,
                                                  color:
                                                      MyColorsLight().onText),
                                              searchHintStyle:
                                                  Theme.of(Get.context!)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.copyWith(
                                                          fontSize: 16.px,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: MyColorsLight()
                                                              .dashMenuColor),
                                              searchTextStyle: Theme.of(
                                                      Get.context!)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.copyWith(
                                                    fontSize: 16.px,
                                                    fontWeight: FontWeight.w800,
                                                    color:
                                                        MyColorsLight().onText,
                                                  ),
                                              searchIcon: Icon(Icons.search,
                                                  color:
                                                      MyColorsLight().onText),
                                              chipDisplay:
                                                  MultiSelectChipDisplay.none(),
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          my(
                                            // ignore: invalid_use_of_protected_member
                                            items: controller
                                                .selectedBrands.value
                                                .map((e) => MultiSelectItem(
                                                    e, e.brandName.toString()))
                                                .toList(),
                                            scrollController:
                                                ScrollController(),
                                            scroll: true,
                                            scrollBar: HorizontalScrollBar(
                                                isAlwaysShown: true),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: MyColorsLight()
                                                    .backgroundFilterColor,
                                                width: .5.px,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: MyColorsLight()
                                                      .backgroundFilterColor,
                                                  width: .5.px),
                                              borderRadius:
                                                  BorderRadius.circular(5.px),
                                            ),
                                            chipColor: Colors.transparent,
                                            textStyle: Theme.of(Get.context!)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(fontSize: 12.px),
                                            // ignore: invalid_use_of_protected_member
                                            list:
                                                controller.selectedBrands.value,
                                          ),
                                          SizedBox(height: 1.h),
                                        ],
                                      ),
                                    SizedBox(height: Zconstant.margin * 5),
                                  ],
                                ),
                              ),
                              if (controller.isSubmitButtonVisible.value)
                                SizedBox(height: Zconstant.margin / 2),
                              if (controller.isSubmitButtonVisible.value)
                                submitButtonView(),
                              if (controller.isSubmitButtonVisible.value)
                                SizedBox(height: Zconstant.margin),
                            ],
                          ),
                        ),
                      ),
                    )
                  : CommonWidgets.progressBarView();
            },
          ),
        ),
      );
    });
  }

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
    if (items == null || items.isEmpty) return Container();
    return Obx(() {
      return controller.count.value >= 0
          ? Container(
              decoration: decoration,
              alignment: alignment ?? Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: scroll ? 0 : 10),
              child: /*scroll
          ?*/
                  Container(
                padding: EdgeInsets.symmetric(horizontal: 2.px),
                width: MediaQuery.of(Get.context!).size.width,
                height:
                    height ?? MediaQuery.of(Get.context!).size.height * 0.08,
                child: scrollBar != null
                    ? Obx(() {
                        return controller.count.value >= 0
                            ? Scrollbar(
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
                              )
                            : const SizedBox();
                      })
                    : ListView.builder(
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
              )
              /*: Wrap(
        children: items != null
            ? items!.map((item) => _buildItem(item!, Get.context!)).toList()
            : <Widget>[
          Container(),
        ],
      ),*/
              )
          : const SizedBox();
    });
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
    return Obx(() {
      return controller.count.value >= 0
          ? Container(
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
                      // ignore: prefer_null_aware_operators
                      fontSize: textStyle != null ? textStyle.fontSize : null,
                    ),
                  ),
                ),
                selected: items.contains(item),
                selectedColor: colorator ??
                    (chipColor ??
                        Theme.of(Get.context!).primaryColor.withOpacity(0.33)),
                onSelected: (_) {
                  if (onTap != null) onTap(item.value);
                },
              ),
            )
          : const SizedBox();
    });
  }

  Widget wellComeTextView() => Text('Welcome',
      style: Theme.of(Get.context!)
          .textTheme
          .subtitle1
          ?.copyWith(fontSize: 24.px));

  Widget nameTextFieldView() => CommonWidgets.myTextField(
      labelText: 'User Name',
      hintText: 'User Name',
      iconVisible: false,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) => FormValidator.isNameValid(value: value),
      controller: controller.nameController);

  Widget emailTextFieldView() => CommonWidgets.myTextField(
      controller: controller.emailController,
      labelText: 'Verified Email',
      inputType: TextInputType.emailAddress,
      readOnly: true,
      validator: (value) => FormValidator.isEmailValid(value: value),
      hintText: 'mailto:dollop@gmail.com',
      icon: IconButton(
        onPressed: () {},
        icon: Icon(Icons.verified, color: MyColorsLight().success, size: 20.px),
        splashRadius: 24.px,
      ),
      iconVisible: true);

  Widget mobileNumberTextFieldView() => Obx(() => CommonWidgets.myTextField(
        labelText: controller.isSubmitButtonVisible.value
            ? 'Verified Mobile Number'
            : 'Mobile Number',
        hintText: '1234567890',
        maxLength: 10,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) => FormValidator.isNumberValid(value: value),
        iconVisible: true,
        readOnly: controller.isSubmitButtonVisible.value,
        inputType: TextInputType.number,
        icon: controller.isVisibleIcon.value
            ? controller.isSendOtpVisible.value
                ? SizedBox(child: sendOTPButtonView())
                : IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.verified,
                        color: MyColorsLight().success, size: 20.px),
                    splashRadius: 24.px,
                  )
            : const SizedBox(),
        controller: controller.mobileNumberController,
        onChanged: (value) {
          if (value.toString().isNotEmpty) {
            controller.isVisibleIcon.value = true;
            controller.isSendOtpVisible.value = true;
          } else {
            controller.isVisibleIcon.value = false;
            controller.isSendOtpVisible.value = false;
          }
        },
      ));

  Widget sendOTPButtonView() {
    return Obx(() {
      if (!controller.isSendOtpButtonClicked.value) {
        return myElevatedButton(
          height: 25.px,
          borderRadius: 5.px,
          margin: EdgeInsets.zero,
          onPressed: !controller.isSendOtpButtonClicked.value
              ? () => controller.clickOnSendOtpButton()
              // ignore: avoid_returning_null_for_void
              : () => null,
          text: Text('Send OTP',
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: MyColorsLight().primary, fontSize: 12.px)),
        );
      } else {
        return myElevatedButton(
          text: CommonWidgets.registrationOtpButtonProgressBar(),
          // ignore: avoid_returning_null_for_void
          onPressed: () => null,
          margin: EdgeInsets.zero,
          height: 25.px,
          borderRadius: 5.px,
        );
      }
    });
  }

  Widget passwordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.passwordVisible.value,
        labelText: 'Password',
        hintText: '.........',
        validator: (value) => FormValidator.isPasswordValid(value: value),
        controller: controller.passwordController,
        icon: IconButton(
            icon: Icon(
                controller.passwordVisible.value
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(Get.context!)
                    .colorScheme
                    .onSurface
                    .withOpacity(.4),
                size: 20.px),
            splashRadius: 24.px,
            onPressed: () => controller.clickOnPasswordEyeButton()),
        iconVisible: true,
      );

  Widget confirmPasswordTextFieldView() => CommonWidgets.myTextField(
        obscureText: !controller.confirmPasswordVisible.value,
        validator: (value) => FormValidator.isConfirmPasswordValid(
            value: value, password: controller.passwordController.text),
        labelText: 'Confirm Password',
        hintText: '..........',
        controller: controller.confirmPasswordController,
        icon: IconButton(
            icon: Icon(
              controller.confirmPasswordVisible.value
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4),
              size: 20.px,
            ),
            splashRadius: 24.px,
            onPressed: () => controller.clickOnConfirmPasswordEyeButton()),
        iconVisible: true,
      );

  Widget stateTextFieldView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.stateModel.value != null &&
            controller.stateModel.value?.states != null &&
            controller.stateModel.value!.states!.isNotEmpty)
          DropdownZeroCart(
            wantDividerError: controller.isStateSelectedValue.value,
            selected: controller.selectedState.value,
            items: controller.stateModel.value!.states!.map((States e) => DropdownMenuItem<States>(
                value: e,
                child: Text(e.name!),
              ),).toList(),
            hint: Text(
              'Select state',
              style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
                  fontSize: 16.px,
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .onSurface
                      .withOpacity(.4)),
            ),
            onChanged: (States? value) async {
              controller.stateId = value?.id??'';
              controller.selectedState.value = value;
              if (value != null && value.id != null) {
                controller.cityModel.value = null;
                controller.cityId = "";
                controller.isStateSelectedValue.value = false;
                await controller.getCityApiCalling(sId: controller.stateId);
              }


            },
          ),

      ],
    );
  }

  Widget cityTextFieldView() {
    return (controller.cityModel.value != null &&
        controller.cityModel.value?.cities != null &&
        controller.cityModel.value!.cities!.isNotEmpty)? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          DropdownZeroCart(
            wantDividerError: controller.isCitySelectedValue.value,
            selected: controller.selectedCity.value,
            items: controller.cityModel.value!.cities!
                .map(
                  (Cities e) => DropdownMenuItem<Cities>(
                value: e,
                child: Text(e.name!),
              ),
            ).toList(),
            hint: Text(
              'Select city',
              style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
                  fontSize: 16.px,
                  color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
            ),
            onChanged: (Cities? value) {
              controller.selectedCity.value = value;
              controller.cityId = value?.id ?? '';
              if ( value != null && value.id != null) {
                controller.isCitySelectedValue.value = false;
              }
            },
          ),

        if(controller.isCitySelectedValue.value)
        SizedBox(height: 5.px),
        if(controller.isCitySelectedValue.value)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.px),
          child: Text(
            'Please Select City',
            style: Theme.of(Get.context!)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: 14.px, color: MyColorsLight().error),
          ),
        )

      ],
    ):const SizedBox();
  }

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

  /*  Widget stateTextFieldView() {
    return DropdownSearch<States>(
      items: controller.stateModel.value!.states!,
      selectedItem: controller.selectedState,
      itemAsString: (item) {
        return "${item.name}";
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
  }
  */
  /* return DropdownButtonFormField(
      style: Theme
          .of(Get.context!)
          .textTheme
          .subtitle2
          ?.copyWith(fontSize: 16.px),
      hint: Text("Select State"),
      decoration: InputDecoration(labelText: "Select State",
          hintText: "Select State",hintStyle: Theme
              .of(Get.context!)
              .textTheme
              .subtitle2
              ?.copyWith(fontSize: 16.px)),
      dropdownColor: Colors.greenAccent,
      value: controller.selectedState,
      onChanged: (States? newValue) async {
        controller.selectedState = newValue!;
        controller.isCityTextFieldNotVisible.value = true;
        controller.stateId = newValue.id;
        await controller.getCityApiCalling(sId: controller.stateId!);
        controller.isCityTextFieldNotVisible.value = false;
      },
      items: controller.statesList!.map<DropdownMenuItem<States>>((States value) {
        return DropdownMenuItem<States>(
          value: value,
          child: Text(
            value.name.toString(),
            style: const TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );*/
  /*
  Widget cityTextFieldView() {
    return DropdownSearch<Cities>(
      items: controller.citiesList!,
      selectedItem: controller.selectedCity.value,
      itemAsString: (item) {
        return "${item.name}";
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
  /* return DropdownButtonFormField(
      style: Theme.of(Get.context!)
          .textTheme
          .subtitle2
          ?.copyWith(fontSize: 16.px),
      hint: Text("Select city"),
      decoration: InputDecoration(labelText: "Select city",
          hintText: "Select city",hintStyle: Theme
          .of(Get.context!)
          .textTheme
          .subtitle2
          ?.copyWith(fontSize: 16.px)),
      dropdownColor: Colors.greenAccent,
      value: controller.selectedCity,
      onChanged: (Cities? newValue) {
        controller.selectedCity = newValue!;
        controller.cityId = newValue.id;
      },
      items: controller.citiesList!.map<DropdownMenuItem<Cities>>((Cities value) {
        return DropdownMenuItem<Cities>(
          value: value,
          child: Text(
            value.name.toString(),
            style: const TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );*/

  Widget submitButtonView() {
    return Obx(() {
      if (!controller.isSubmitButtonClicked.value) {
        return CommonWidgets.myElevatedButton(
            text:
                Text('Submit', style: Theme.of(Get.context!).textTheme.button),
            // ignore: avoid_returning_null_for_void
            onPressed: !controller.isSubmitButtonClicked.value
                ? () => controller.clickOnSubmitButton()
                // ignore: avoid_returning_null_for_void
                : () => null,
            height: 52.px,
            margin: EdgeInsets.zero);
      } else {
        return CommonWidgets.myElevatedButton(
            text: CommonWidgets.buttonProgressBarView(),
            // ignore: avoid_returning_null_for_void
            onPressed: () => null,
            height: 52.px,
            margin: EdgeInsets.zero);
      }
    });
  }

  Widget myElevatedButton({
    required Widget text,
    required VoidCallback onPressed,
    double? height,
    EdgeInsetsGeometry? margin,
    double? borderRadius,
  }) {
    return Container(
      height: height ?? 50.px,
      margin: margin ?? EdgeInsets.symmetric(horizontal: Zconstant.margin),
      color: Colors.transparent,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25.px),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: text,
      ),
    );
  }
}
