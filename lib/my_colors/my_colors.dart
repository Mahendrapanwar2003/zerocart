import 'package:flutter/material.dart';

abstract class MyColors {
  /* --------------------------Primary Colors Collection--------------------------*/
  Color get primaryColor;

  Color get primary;

  Color get primaryContainer => const Color(0xff);

  Color get onPrimary;

  Color get dashMenuColor;

  Color get onPrimaryContainer => const Color(0xff);

  Color get primaryVariant => const Color(0xff);

  Color get inversePrimary => const Color(0xff);

  /* --------------------------Secondary Colors Collection--------------------------*/
  Color get secondary;

  Color get secondaryContainer => const Color(0xff);

  Color get onSecondary;

  Color get onSecondaryContainer => const Color(0xff);

  Color get secondaryVariant => const Color(0xff);

  Color get inverseSecondary => const Color(0xff);

  /* --------------------------Tertiary Colors Collection--------------------------*/
  Color get tertiary => const Color(0xff);

  Color get tertiaryContainer => const Color(0xff);

  Color get onTertiary => const Color(0xff);

  Color get onTertiaryContainer => const Color(0xff);

  /* --------------------------Background / ScaffoldBackgroundColor / DialogBackgroundColor Colors Collection--------------------------*/
  Color get backgroundColor => const Color(0xff);

  Color get backGround;

  Color get onBackGround => const Color(0xff);

  Color get scaffoldBackgroundColor;

  Color get dialogBackgroundColor => const Color(0xff);

  /* --------------------------  BottomAppBarColor / AppBarBackgroundColor / AppBarColor Colors Collection--------------------------*/
  Color get bottomAppBarColor => const Color(0xff);

  Color get appBarBackgroundColor => const Color(0xff);

  Color get appBarColor => const Color(0xff);

  /* --------------------------Error / DisabledColor/ IndicatorColor Colors Collection--------------------------*/
  Color get errorColor => const Color(0xff);

  Color get error;

  Color get onError => const Color(0xff);

  Color get errorContainer => const Color(0xff);

  Color get onErrorContainer => const Color(0xff);

  Color get disabledColor => const Color(0xff);

  Color get buttonBlueColor;

  Color get indicatorColor => const Color(0xff);

  /* --------------------------Success Colors Collection--------------------------*/

  Color get success;

  Color get onSuccess => const Color(0xff);

  /* --------------------------Surface Colors Collection--------------------------*/
  Color get surface => const Color(0xff);

  Color get onSurface => const Color(0xff);

  Color get surfaceVariant => const Color(0xff);

  Color get onSurfaceVariant => const Color(0xff);

  Color get inverseSurface => const Color(0xff);

  Color get onInverseSurface => const Color(0xff);

  Color get surfaceTin => const Color(0xff);

  /* -------------------------- DividerColor / CardColor / FocusColor / CanvasColor Colors Collection--------------------------*/
  Color get dividerColor => const Color(0xff);

  Color get borderColor;

  Color get cardColor => const Color(0xff);

  Color get focusColor => const Color(0xff);

  Color get canvasColor => const Color(0xff);

  /* -------------------------- HoverColor / HintColor / ShadowColorColors / SplashColor Collection--------------------------*/
  Color get hoverColor => const Color(0xff);

  Color get hintColor => const Color(0xff);

  Color get shadowColor => const Color(0xff);

  Color get splashColor => const Color(0xff);

  /* --------------------------Text Colors Collection--------------------------*/

  Color get text;

  Color get onText;

  Color get textGrayColor;

  /* --------------------------bottomBarColor Colors Collection--------------------------*/

  Color get bottomBar;

  /* --------------------------NormalColors Colors Collection--------------------------*/

  Color get greyColor;

  Color get backgroundFilterColor;

  Color get bottomBarColor;
}

class MyColorsLight extends MyColors {
  @override
  Color get primaryColor => const Color(0xFFFBAD33);

  @override
  Color get primary => const Color(0xFFF2653A);

  @override
  Color get onPrimary => const Color(0xFF9E9E9E);

  @override
  Color get secondary => const Color(0xFFffffff);

  @override
  Color get dashMenuColor => const Color(0xFFE0E0E0);

  @override
  // Color get scaffoldBackgroundColor => const Color(0xfff2f2f2);
  Color get scaffoldBackgroundColor => const Color(0xffF2F2F2);

  @override
  Color get backGround => const Color(0xffF5F5F5);

  @override
  Color get bottomBar => const Color(0xFFFFFFFF);

  @override
  Color get success => const Color(0xff74FF82);

  @override
  Color get error => const Color(0xFFFF3333);

  @override
  Color get greyColor => const Color(0x99FFFFFF);

  @override
  Color get text => const Color(0xffffffff);

  @override
  Color get textGrayColor => const Color(0xff7C7C7C);

  @override
  Color get onText => const Color(0xff000000);

  @override
  Color get backgroundFilterColor => const Color(0xff939393);

  @override
  // TODO: implement buttonBlueColor
  Color get buttonBlueColor => throw UnimplementedError();

  @override
  // TODO: implement onSecondary
  Color get onSecondary => const Color(0xfff0f0f0);

  @override
  Color get borderColor => const Color(0xffD5DEEB);

  get card => const Color(0xffD9D9D9);

  @override
  Color get bottomBarColor => const Color(0xffFFFFFF);
}

class MyColorsDark extends MyColors {
  @override
  Color get primaryColor => const Color(0xFFFBAD33);

  @override
  Color get primary => const Color(0xFFF2653A);

  @override
  Color get onPrimary => const Color(0xFF9E9E9E);

  @override
  Color get dashMenuColor => const Color(0x40FFFFFF);

  @override
  Color get secondary => const Color(0xFF000000);

  @override
  Color get scaffoldBackgroundColor => const Color(0xff101010);

  @override
  Color get backGround => const Color(0xff0a0a0a);

  @override
  Color get bottomBar => const Color(0xff141414);

  @override
  Color get success => const Color(0xff74FF82);

  @override
  Color get error => const Color(0xFFFF3333);

  @override
  Color get greyColor => const Color(0x99FFFFFF);

  @override
  Color get text => const Color(0xff000000);

  @override
  Color get textGrayColor => const Color(0xff7C7C7C);

  @override
  Color get onText => const Color(0xffffffff);

  @override
  Color get backgroundFilterColor => const Color(0xff939393);

  @override
  // TODO: implement buttonBlueColor
  Color get buttonBlueColor => throw UnimplementedError();

  @override
  Color get onSecondary => const Color(0xff263238);

  @override
  Color get borderColor => const Color(0xffD5DEEB);

  @override
  Color get bottomBarColor => const Color(0xff1F1F1F);
}
