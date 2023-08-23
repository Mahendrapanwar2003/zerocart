import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/validator/form_validator.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import '../controllers/add_address_controller.dart';

class AddAddressView extends GetView<AddAddressController> {
  const AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(context: context),
      child: Obx(() {
        return AbsorbPointer(
          absorbing: controller.absorbing.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const MyCustomContainer().myAppBar(
                isIcon: true,backIconOnPressed: () => controller.clickOnBackIcon(context: context),
                text: 'Add Addresses'),
            body: GestureDetector(
              onTap: () => MyCommonMethods.unFocsKeyBoard(),
              child: Form(
                key: controller.key,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: Zconstant.margin,),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Zconstant.margin),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                nameTextFieldView(),
                                SizedBox(height: 2.h),
                                phoneNumberTextFieldView(),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Expanded(child: pinCodeTextFieldView()),
                                    SizedBox(width:Zconstant.margin16),
                                    Expanded(
                                      child: useLocationElevatedButtonView(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Expanded(child: stateTextFieldView()),
                                    SizedBox(width: 4.w),
                                    Expanded(child: cityTextFieldView()),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                houseNoBuildingNameTextFieldView(),
                                SizedBox(height: 2.h),
                                roadNameAreaColonyTextFieldView(),
                                SizedBox(height: 3.h),
                                typeOfAddressTextView(),
                                SizedBox(height: 1.h),
                                Obx(() {
                                  return Row(
                                    children: [
                                      homeButtonView(),
                                      SizedBox(width: Zconstant.margin16),
                                      workButtonView(),
                                      SizedBox(width: Zconstant.margin16),
                                      otherButtonView()
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: Zconstant.margin),

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Zconstant.margin),
                      child: saveAddressButtonView(context: context),
                    ),
                    SizedBox(height: Zconstant.margin),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
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

  Widget addAddressesTextView() => Text(
        "Add Addresses",
        style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(),
      );

  Widget myOutLineTextField(
      {required String labelText,
      required String hintText,
      TextInputType? keyboardType,
      TextEditingController? controller,
      String? Function(String?)? validator,
      bool obscureText = false,
        int? maxLength,
        List<TextInputFormatter>? inputFormatters,
        TextInputType? inputType,
        TextCapitalization textCapitalization = TextCapitalization.none,
        ValueChanged<String>? onChanged,}) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      cursorColor: Theme.of(Get.context!).colorScheme.primary,
      onChanged: onChanged ??
              (value) {
            value = value.trim();
            if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
              controller?.text = "";
            }
          },
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(fontSize: 16.px),
      maxLength: maxLength,
      obscureText: false,
      decoration: InputDecoration(
        counterText: "",
        constraints: const BoxConstraints(),
        contentPadding: EdgeInsets.only(top: 7.px),
        hintStyle: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
            fontSize: 16.px,
            color: Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
        labelText: labelText,
          labelStyle: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
              color: Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColorsDark().textGrayColor,
            width: 1.px,
          ),
          borderRadius: BorderRadius.circular(5.px),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(Get.context!).colorScheme.primary,
            width: 1.px,
          ),
          borderRadius: BorderRadius.circular(5.px),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(Get.context!).colorScheme.error,
            width: 1.px,
          ),
          borderRadius: BorderRadius.circular(5.px),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(Get.context!).colorScheme.error,
            width: 1.px,
          ),
          borderRadius: BorderRadius.circular(5.px),
        ),
      ),
    );
  }

  Widget nameTextFieldView() => myOutLineTextField(
        controller: controller.nameController,
        validator: (value) => FormValidator.isAddressValid(value: value, content: 'name', ),
        labelText: 'Name (Required)*',
        keyboardType: TextInputType.text,
        hintText: 'Enter Your Name',
      );

  Widget phoneNumberTextFieldView() => myOutLineTextField(
        controller: controller.numberController,
    validator: (value) => FormValidator.isAddressValid(value: value, content: 'number'),
        labelText: 'Phone Number (Required)*',
        keyboardType: TextInputType.number,
        hintText: 'Enter Your Phone Number',
    onChanged: (value){},
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    maxLength: 10
  );

  Widget pinCodeTextFieldView() => myOutLineTextField(
        controller: controller.pinCodeController,
    validator: (value) => FormValidator.isAddressValid(value: value, content: 'pincode'),
    labelText: 'Pin Code (Required)*',
        keyboardType: TextInputType.number,
        hintText: 'Enter Your Pin Code',
    onChanged: (value){},
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    maxLength: 6
  );

  Widget useLocationElevatedButtonView() {
    return Obx(() {
      if (!controller.isUseMyLocationButtonClicked.value) {
        return CommonWidgets.myElevatedButton(
          borderRadius: 5.px,
          margin: EdgeInsets.zero,
          text: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              locationIconView(),
              useMyLocationTextView(),
            ],
          ),
          onPressed: () => controller.clickOnMyLocationButton(),
        );
      } else {
        return CommonWidgets.myElevatedButton(
          borderRadius: 5.px,
          margin: EdgeInsets.zero,
          text: SizedBox(height: 20.px,
          width: 20.px
            ,child: CommonWidgets.buttonProgressBarView(),),
          onPressed: () => null,
        );
      }
    });
  }

  Widget locationIconView() => Icon(
        Icons.my_location_rounded,
        size: 18.px,
        color: MyColorsLight().secondary,
      );

  Widget useMyLocationTextView() => Text(
        "Use my location",
        style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
              color: MyColorsLight().secondary,
            ),
      );

  Widget stateTextFieldView() => myOutLineTextField(
        controller: controller.stateController,
        labelText: 'State (Required)*',
        hintText: 'Enter Your State Name',
    validator: (value) => FormValidator.isAddressValid(value: value, content: 'state'),
  );

  Widget cityTextFieldView() => myOutLineTextField(
        controller: controller.cityController,
        labelText: 'City (Required)*',
        hintText: 'Enter Your City Name',
    validator: (value) => FormValidator.isAddressValid(value: value, content: 'city'),
  );

  Widget houseNoBuildingNameTextFieldView() => myOutLineTextField(
        controller: controller.houseController,
        labelText: 'House No. Building Name (Required)*',
        hintText: 'Enter Your House No. Building Name',
    validator: (value) => FormValidator.isAddressValid(value: value, content: 'house number'),
  );

  Widget roadNameAreaColonyTextFieldView() => myOutLineTextField(
        controller: controller.colonyController,
        labelText: 'Road Name, Area, Colony (Required)*',
        hintText: 'Enter Your Road Name, Area, Colony',
    validator: (value) => FormValidator.isAddressValid(value: value, content: 'road name'),
  );

  Widget typeOfAddressTextView() => Text(
        "Type Of Address",
        style: Theme.of(Get.context!).textTheme.headline5?.copyWith(fontSize: 14.px),
      );

  Widget addressTypeTextView({required Widget text, required Widget icon}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 2.w),
          text,
        ],
      );

  Widget homeButtonView() => CommonWidgets.myOutlinedButton(
      text: controller.addressType.value == "Home"
          ? addressTypeTextView(
              icon: GradientIconColor(
                Icons.home_outlined,
                size: 16.px,
                gradient: CommonWidgets.commonLinearGradientView(),
              ),
              text: GradientText(
                'Home',
                style: Theme.of(Get.context!).textTheme.subtitle2,
                gradient: CommonWidgets.commonLinearGradientView(),
              ),
            )
          : addressTypeTextView(
              icon: Icon(Icons.home_outlined,
                  size: 16.px,
                  color: Theme.of(Get.context!).textTheme.subtitle2?.color),
              text: Text(
                'Home',
                style: Theme.of(Get.context!).textTheme.subtitle2,
              ),
            ),
      onPressed: () => controller.clickOnHomeButton(),
      wantFixedSize: false,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      height: 35.px,
      linearGradient: controller.addressType.value == "Home" ? CommonWidgets.commonLinearGradientView() : commonLinearGradient(),
      radius: 17.px);

  Widget workButtonView() => CommonWidgets.myOutlinedButton(
      text: controller.addressType.value == "Work"
          ? addressTypeTextView(
              icon: GradientIconColor(
                Icons.work_outline_rounded,
                size: 16.px,
                gradient: CommonWidgets.commonLinearGradientView(),
              ),
              text: GradientText(
                'Work',
                style: Theme.of(Get.context!).textTheme.subtitle2,
                gradient: CommonWidgets.commonLinearGradientView(),
              ),
            )
          : addressTypeTextView(
              icon: Icon(Icons.work_outline_rounded,
                  size: 16.px,
                  color: Theme.of(Get.context!).textTheme.subtitle2?.color),
              text: Text(
                'Work',
                style: Theme.of(Get.context!).textTheme.subtitle2,
              ),
            ),
      onPressed: () => controller.clickOnWorkButton(),
      height: 35.px,
      padding: EdgeInsets.symmetric(horizontal: 15.px),
      linearGradient: controller.addressType.value == "Work" ? CommonWidgets.commonLinearGradientView() : commonLinearGradient(),
      radius: 17.px,
    wantFixedSize: false,
    margin: EdgeInsets.zero

  );

  Widget otherButtonView() => CommonWidgets.myOutlinedButton(
      text: controller.addressType.value == "Other"
          ? addressTypeTextView(
              icon: GradientIconColor(
                size: 16.px,
                Icons.maps_home_work_outlined,
                gradient: CommonWidgets.commonLinearGradientView(),
              ),
              text: GradientText(
                'Other',
                style: Theme.of(Get.context!).textTheme.subtitle2,
                gradient: CommonWidgets.commonLinearGradientView(),
              ),
            )
          : addressTypeTextView(
              icon: Icon(Icons.maps_home_work_outlined,
                  size: 16.px,
                  color: Theme.of(Get.context!).textTheme.subtitle2?.color),
              text: Text(
                'Other',
                style: Theme.of(Get.context!).textTheme.subtitle2,
              ),
            ),
      onPressed: () => controller.clickOnOtherButton(),
      height: 35.px,

      padding: EdgeInsets.symmetric(horizontal: 15.px),
      linearGradient: controller.addressType.value == "Other" ? CommonWidgets.commonLinearGradientView() : commonLinearGradient(),
      radius: 17.px,
    wantFixedSize: false,
    margin: EdgeInsets.zero

  );

  Widget saveAddressButtonView({required BuildContext context}) {
    return Obx(() {
      if (!controller.isSaveButtonClicked.value) {
        return CommonWidgets.myElevatedButton(
            margin: EdgeInsets.zero,
            borderRadius: 5.px,
            text: saveAddressTextView(),
            onPressed: () =>
                controller.clickOnSaveAddressButton(context: context));
      } else {
        return CommonWidgets.myElevatedButton(
            text: CommonWidgets.buttonProgressBarView(),
            // ignore: avoid_returning_null_for_void
            onPressed: () => null,
            margin: EdgeInsets.zero,
            borderRadius: 5.px);
      }
    });
  }

  Widget saveAddressTextView() =>
      Text("Save Address", style: Theme.of(Get.context!).textTheme.button);

  LinearGradient commonLinearGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(Get.context!).brightness == Brightness.dark ? MyColorsLight().secondary : MyColorsDark().secondary,
        Theme.of(Get.context!).brightness == Brightness.dark ? MyColorsLight().secondary : MyColorsDark().secondary,
      ],
    );
  }
}
