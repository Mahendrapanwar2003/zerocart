import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zerocart/app/constant/zconstant.dart';
import 'package:zerocart/app/custom/custom_gradient_text.dart';
import 'package:zerocart/app/custom/custom_outline_button.dart';

import 'package:zerocart/my_colors/my_colors.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';

class CommonWidgets {
  static Widget zeroCartBagImage() {
    return Image.asset(
      Theme.of(Get.context!).brightness == Brightness.dark
          ? "assets/zerocart_bag_light.png"
          : "assets/zerocart_bag_dark.png",
      width: 100.w,
    );
  }

  static Widget zeroCartImage() {
    return Image.asset(
      Theme.of(Get.context!).brightness == Brightness.dark
          ? "assets/logo_white.png"
          : "assets/logo_black.png",
      width: 75.w,
    );
  }

  static Widget mySizeBox({double? height}) {
    return SizedBox(
      height: height ?? 2.h,
      width: double.infinity,
    );
  }

  static Widget commonDisForError({required String dis}) {
    return Text(
      dis,
      textAlign: TextAlign.center,
      style: Theme.of(Get.context!).textTheme.titleMedium,
    );
  }

  static Widget commonRefreshIndicator(
      {required Widget child, required RefreshCallback onRefresh}) {
    return RefreshIndicator(onRefresh: onRefresh, child: child);
  }

  static Widget commonNoInternetImage({required RefreshCallback onRefresh}) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Zconstant.imageNoInternetConnection),
                  commonTitleForError(title: Zconstant.textNoInternetTitle),
                  commonDisForError(dis: Zconstant.textNoInternetDis)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  CustomScrollView(
  slivers: <Widget>[
  */ /*SliverToBoxAdapter(
            child: Container(color: Colors.red,),
          ),
          */ /*
  SliverFillRemaining(
  hasScrollBody: true,
  child: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Image.asset(Zconstant.imageNoInternetConnection),
  commonTitleForError(title: Zconstant.textNoInternetTitle),
  commonDisForError(dis: Zconstant.textNoInternetDis)
  ],
  )),
  ),
  ],
  ),*/

  static Widget commonNoDataFoundImage({required RefreshCallback onRefresh}) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Zconstant.imageNoDataFound),
                  commonTitleForError(title: Zconstant.textNoDataTitle),
                  commonDisForError(dis: Zconstant.textNoDataDis)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  CustomScrollView(
  slivers: <Widget>[
  SliverFillRemaining(
  hasScrollBody: true,
  child: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Image.asset(Zconstant.imageNoDataFound),
  commonTitleForError(title: Zconstant.textNoDataTitle),
  commonDisForError(dis: Zconstant.textNoDataDis)
  ],
  )),
  ),
  ],
  ),*/

  static Widget commonSomethingWentWrongImage(
      {required RefreshCallback onRefresh}) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Zconstant.imageSomethingWentWrong),
                  commonTitleForError(
                      title: Zconstant.textSomethingWentWrongTitle),
                  commonDisForError(dis: Zconstant.textSomethingWentWrongDis)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  CustomScrollView(
  slivers: <Widget>[
  SliverFillRemaining(
  hasScrollBody: true,
  child: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Image.asset(Zconstant.imageSomethingWentWrong),
  commonTitleForError(
  title: Zconstant.textSomethingWentWrongTitle),
  commonDisForError(dis: Zconstant.textSomethingWentWrongDis)
  ],
  ),
  ),
  ),
  ],
  ),*/
  static Widget commonTitleForError({required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.px),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(Get.context!)
            .textTheme
            .titleMedium
            ?.copyWith(fontSize: 24.px),
      ),
    );
  }

  static Widget myStackAppBarSizeBox(
      {required Widget child, bool? wantProfileMenuDash = false}) {
    return Column(
      children: [
        SizedBox(
          height: 20.85.h,
          width: double.infinity,
        ),
        Container(
            width: double.infinity,
            height: 50.px,
            color: Theme.of(Get.context!)
                .colorScheme
                .onBackground
                .withOpacity(0.8),
            child: wantProfileMenuDash == true
                ? Column(
                    children: [
                      child,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: CommonWidgets.profileMenuDash(),
                      ),
                    ],
                  )
                : child),
      ],
    );
  }

  static Widget loaderAnimation(Animation<Color?> colorTween) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.px,
        left: 35.w,
        right: 35.w,
      ),
      alignment: Alignment.topCenter,
      child: LinearProgressIndicator(
        minHeight: 4.px,
        backgroundColor: Colors.transparent,
        valueColor: colorTween,
      ),
    );
  }

  static Widget myElevatedButton({
    required Widget text,
    required VoidCallback onPressed,
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? margin,
    double? borderRadius,
  }) {
    return Container(
      height: height ?? 50.px,
      margin: margin ?? EdgeInsets.symmetric(horizontal: Zconstant.margin),
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: color,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(Get.context!).primaryColor,
            Theme.of(Get.context!).colorScheme.primary,
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 25.px),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25.px),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.all(3.5.px),
        ),
        child: text,
      ),
    );
  }

  static Widget myElevatedButtonContainer({
    required Widget text,
    double? width,
    double? height,
    double? borderRadius,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.px),
      height: height ?? 30.px,
      decoration: BoxDecoration(
        /*gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(Get.context!).primaryColor,
            Theme.of(Get.context!).colorScheme.primary,
          ],
        ),*/
        border: Border.all(
            color:
                Theme.of(Get.context!).textTheme.button!.color ?? Colors.white),
        borderRadius: BorderRadius.circular(borderRadius ?? 2.px),
      ),
      child: Center(child: text),
    );
  }

  static Widget myOutlinedButton(
      {required Widget text,
      required VoidCallback onPressed,
      double? strokeWidth,
      double? height,
      double? width,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      double? radius,
      bool wantFixedSize = true,
      LinearGradient? linearGradient}) {
    return wantFixedSize
        ? Container(
            height: height ?? 50.px,
            width: width ?? double.infinity,
            margin:
                margin ?? EdgeInsets.symmetric(horizontal: Zconstant.margin),
            child: CustomOutlineButton(
              onPressed: onPressed,
              strokeWidth: strokeWidth ?? 1,
              radius: radius ?? 25.px,
              gradient: linearGradient ??
                  LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(Get.context!).primaryColor,
                      Theme.of(Get.context!).colorScheme.primary,
                    ],
                  ),
              child: text,
            ),
          )
        : Container(
            height: height ?? 50.px,
            margin:
                margin ?? EdgeInsets.symmetric(horizontal: Zconstant.margin),
            child: CustomOutlineButton(
              onPressed: onPressed,
              strokeWidth: strokeWidth ?? 1,
              padding: padding,
              radius: radius ?? 25.px,
              gradient: linearGradient ??
                  LinearGradient(
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

  static Widget myTextField(
      {required String labelText,
      required String hintText,
      required bool iconVisible,
      int? maxLength,
      bool readOnly = false,
      String? counterText = '',
      Widget? icon,
      List<TextInputFormatter>? inputFormatters,
      TextInputType? inputType,
      ValueChanged<String>? onChanged,
      String? Function(String?)? validator,
      TextCapitalization textCapitalization = TextCapitalization.none,
      TextEditingController? controller,
      bool autofocus = false,
      GestureTapCallback? onTap,
      EdgeInsetsGeometry? contentPadding,
      bool obscureText = false}) {
    return iconVisible
        ? TextFormField(
            onTap: onTap,
            autofocus: autofocus,
            maxLength: maxLength,
            keyboardType: inputType,
            obscureText: obscureText,
            controller: controller,
            validator: validator,
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            onChanged: onChanged ??
                (value) {
                  value = value.trim();
                  if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
                    controller?.text = "";
                  }
                },
            readOnly: readOnly,
            cursorColor: Theme.of(Get.context!).colorScheme.primary,
            style: Theme.of(Get.context!)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: 16.px),
            decoration: InputDecoration(
              counterText: counterText,
              labelText: labelText,
              labelStyle: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .onSurface
                      .withOpacity(.4)),
              hintText: hintText,
              constraints: const BoxConstraints(),
              contentPadding: contentPadding ?? EdgeInsets.only(top: 7.px),
              hintStyle: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
                  fontSize: 16.px,
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .onSurface
                      .withOpacity(.4)),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: icon,
              ),
            ),
          )
        : TextFormField(
            onTap: onTap,
            maxLength: maxLength,
            keyboardType: inputType,
            obscureText: obscureText,
            controller: controller,
            autofocus: autofocus,
            onChanged: onChanged ??
                (value) {
                  value = value.trim();
                  if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
                    controller?.text = "";
                  }
                },
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization,
            readOnly: readOnly,
            validator: validator,
            cursorColor: Theme.of(Get.context!).colorScheme.primary,
            style: Theme.of(Get.context!)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: 16.px),
            decoration: InputDecoration(
              counterText: counterText,
              labelText: labelText,
              constraints: const BoxConstraints(),
              labelStyle: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .onSurface
                      .withOpacity(.4)),
              hintText: hintText,
              contentPadding: contentPadding,
              hintStyle: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
                  fontSize: 16.px,
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .onSurface
                      .withOpacity(.4)),
            ),
          );
  }

  static LinearGradient commonLinearGradientView() => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(Get.context!).primaryColor,
          Theme.of(Get.context!).colorScheme.primary,
        ],
      );

  static Widget profileMenuDash(
      {double? width, double? height, double? borderRadius, Color? color}) {
    return Container(
      height: height ?? 1,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          color: color ?? method(),
          borderRadius: BorderRadius.circular(borderRadius ?? 0.px)),
    );
  }

  static Color method() {
    return Theme.of(Get.context!).brightness == Brightness.dark
        ? MyColorsDark().dashMenuColor
        : MyColorsLight().dashMenuColor;
  }

  static Widget noDataTextView({String? text}) => Center(
        child: GradientText(
          text ?? "NO DATA FOUND!",
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 16.px),
          gradient: CommonWidgets.commonLinearGradientView(),
        ),
      );

  static Widget somethingWentWrongTextView({String? text}) => Center(
        child: GradientText(
          text ?? "",
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 16.px),
          gradient: CommonWidgets.commonLinearGradientView(),
        ),
      );

  static Widget noInternetTextView({String? text}) => Center(
        child: GradientText(
          text ?? "Check Your Internet Connection!",
          style: Theme.of(Get.context!)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 16.px),
          gradient: CommonWidgets.commonLinearGradientView(),
        ),
      );

  static Widget buttonProgressBarView({double? height, double? width}) =>
      SizedBox(
        height: height ?? 25.px,
        width: width ?? 25.px,
        child: CircularProgressIndicator(
          backgroundColor: MyColorsLight().textGrayColor,
          color: MyColorsLight().secondary,
          strokeWidth: 4.px,
        ),
      );

  static Widget registrationOtpButtonProgressBar() => SizedBox(
        height: 15.px,
        width: 15.px,
        child: CircularProgressIndicator(
          backgroundColor: MyColorsLight().textGrayColor,
          color: MyColorsLight().secondary,
          strokeWidth: 2.px,
        ),
      );

  static Widget progressBarView({double? height, double? width}) => Center(
        child: SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            backgroundColor: MyColorsLight().textGrayColor.withOpacity(.5),
            strokeWidth: 3.px,
          ),
        ),
      );

  static Widget myPadding({required Widget child, double? top}) {
    return Padding(padding: EdgeInsets.only(top: top ?? 17.8.h), child: child);
  }

  static Widget defaultImage() => Image.asset("assets/default_image.jpg");

  static AssetImage defaultProfilePicture() =>
      const AssetImage("assets/profile_pic.png");

  static Widget myDropDownView(
      {required String hintText,
      required List<DropdownMenuItem<String>> itemsText,
      required ValueChanged<String?> onChanged,
      required String value}) {
    return Container(
      padding: EdgeInsets.only(left: 2.px, right: 3.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.px)),
      child: DropdownButton<String>(
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
        ),
        underline: Container(color: Colors.transparent),
        hint: Text(hintText),
        isExpanded: true,
        items: itemsText,
        onChanged: onChanged,
        value: value != "" ? value : null,
      ),
    );
  }

  static Widget commonShimmerViewForImage({
    double? width,
    double? height,
  }) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1200),
      baseColor: MyColorsLight().onText,
      highlightColor: MyColorsLight().backgroundFilterColor,
      enabled: true,
      child: Container(
        width: width ?? 50.w,
        height: height ?? 28.w,
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).brightness == Brightness.dark
              ? MyColorsLight().secondary.withOpacity(0.15)
              : MyColorsDark().secondary.withOpacity(0.03),
          borderRadius: BorderRadius.circular(6.px),
        ),
      ),
    );
  }

  static Widget dropDownElseContainer({
    required String hintText,
    bool valueForValidation = false,
  }) {
    return Container(
      height: 48.px,
      width: double.infinity,
      padding: EdgeInsets.only(right: 2.5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.px),
        border: valueForValidation == true
            ? Border(
                bottom: BorderSide(color: MyColorsLight().error),
              )
            : const Border(),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w, bottom: 5.px),
        child: Text(
          hintText,
          style: Theme.of(Get.context!).textTheme.subtitle2?.copyWith(
              fontSize: 16.px,
              color:
                  Theme.of(Get.context!).colorScheme.onSurface.withOpacity(.4)),
        ),
      ),
    );
  }
}
