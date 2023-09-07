
import 'package:flutter/material.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';

class MyTextThemeStyle {
  static TextStyle headline1(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 96,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headline2(Color color, {String? fontFamily}) {
    return TextStyle(
      //fontSize: 60.px,
      fontSize: 40.px,
      fontFamily: fontFamily,
      //fontWeight: FontWeight.w300,
      fontWeight: FontWeight.w700,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headline3(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 48.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headline4(Color color, {String? fontFamily}) {
    return TextStyle(
      //fontSize: 34.px,
      fontSize: 12.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headline5(Color color, {String? fontFamily}) {
    return TextStyle(
      //fontSize: 24.px,
      fontSize: 16.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headline6(Color color, {String? fontFamily}) {
    return TextStyle(
      //fontSize: 20.px,
      fontSize: 10.px,
      fontFamily: fontFamily,
      //fontWeight: FontWeight.w500,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle subtitle1(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 16.px,
      fontFamily: fontFamily,
      // fontWeight: FontWeight.w400,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle subtitle2(Color color, {String? fontFamily}) {
    return TextStyle(
      //fontSize: 12.px,
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodyText1(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 16.px,
      fontFamily: fontFamily,
      //fontWeight: FontWeight.w400,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodyText2(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle caption(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      //fontWeight: FontWeight.w500,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle button(Color color, {String? fontFamily}) {
    return TextStyle(
//      fontSize: 12.px,
      fontSize: 16.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle overline(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 10.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle displayLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 57.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle displayMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 45.px,
      fontFamily: fontFamily,
      //fontWeight: FontWeight.w400,
      fontWeight: FontWeight.w800,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle displaySmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 36.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headlineLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 32.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      // fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headlineMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 28.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle headlineSmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 24.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle labelLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle labelMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 10.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle labelSmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 11.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle titleLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 22.px,
      fontFamily: fontFamily,
      //  fontWeight: FontWeight.w600,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle titleMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 16.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle titleSmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodyLarge(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 16.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodyMedium(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 14.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle bodySmall(Color color, {String? fontFamily}) {
    return TextStyle(
      fontSize: 12.px,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );
  }
}

class MyTextThemeLight {
  TextTheme myTextTheme({String? fontFamily}) {
    String semiBold = "${fontFamily}SemiBold";
    String regular = "${fontFamily}Regular";
    String light = "${fontFamily}Light";
    String bold = "${fontFamily}Bold";
    return TextTheme(
      headline1: MyTextThemeStyle.displayMedium(
        MyColorsLight().text,
        fontFamily: fontFamily,
      ),
      headline2: MyTextThemeStyle.headline2(
        MyColorsLight().onText,
        fontFamily: fontFamily,
      ),
      headline3: MyTextThemeStyle.headline4(
        MyColorsLight().onText,
        fontFamily: fontFamily,
      ),
      headline4: MyTextThemeStyle.headline4(
        MyColorsLight().text,
        fontFamily: fontFamily,
      ),
      overline: MyTextThemeStyle.headline4(
        MyColorsLight().textGrayColor,
        fontFamily: fontFamily,
      ),
      headline5: MyTextThemeStyle.headline5(
        MyColorsLight().textGrayColor,
        fontFamily: fontFamily,
      ),
      headline6: MyTextThemeStyle.headline6(
        MyColorsLight().textGrayColor,
        fontFamily: fontFamily,
      ),
      labelMedium: MyTextThemeStyle.headline6(
        MyColorsLight().text,
        fontFamily: semiBold,
      ),
      headlineLarge: MyTextThemeStyle.headline6(
        MyColorsLight().onText,
        fontFamily: fontFamily,
      ),
      subtitle1: MyTextThemeStyle.subtitle1(
        MyColorsLight().onText,
        fontFamily: fontFamily,
      ),
      subtitle2: MyTextThemeStyle.subtitle2(
        MyColorsLight().onText,
        fontFamily: fontFamily,
      ),
      bodyText1: MyTextThemeStyle.bodyText1(
        MyColorsLight().text,
        fontFamily: fontFamily,
      ),
      bodyText2: MyTextThemeStyle.bodyText2(
        MyColorsLight().text,
        fontFamily: fontFamily,
      ),
      button: MyTextThemeStyle.button(
        MyColorsLight().text,
        fontFamily: fontFamily,
      ),
      caption: MyTextThemeStyle.caption(
        MyColorsLight().textGrayColor,
        fontFamily: fontFamily,
      ),


    );
  }
}

class MyTextThemeDark {
  TextTheme myTextTheme({String? fontFamily}) {
    String semiBold = "${fontFamily}SemiBold";
    String regular = "${fontFamily}Regular";
    String light = "${fontFamily}Light";
    String bold = "${fontFamily}Bold";

    return TextTheme(
      headline1: MyTextThemeStyle.displayMedium(
        MyColorsDark().onText,
        fontFamily: fontFamily,
      ),
      headline2: MyTextThemeStyle.headline2(
        MyColorsDark().onText,
        fontFamily: fontFamily,
      ),
      headline3: MyTextThemeStyle.headline4(
        MyColorsDark().onText,
        fontFamily: fontFamily,
      ),
      headline4: MyTextThemeStyle.headline4(
        MyColorsDark().text,
        fontFamily: fontFamily,
      ),
      overline: MyTextThemeStyle.headline4(
        MyColorsLight().textGrayColor,
        fontFamily: fontFamily,
      ),
      headline5: MyTextThemeStyle.headline5(
        MyColorsDark().textGrayColor,
        fontFamily: fontFamily,
      ),
      headline6: MyTextThemeStyle.headline6(
        MyColorsDark().textGrayColor,
        fontFamily: fontFamily,
      ),
      labelMedium: MyTextThemeStyle.headline6(
        MyColorsDark().text,
        fontFamily: semiBold,
      ),
      headlineLarge: MyTextThemeStyle.headline6(
        MyColorsDark().onText,
        fontFamily: fontFamily,
      ),
      subtitle1: MyTextThemeStyle.subtitle1(
        MyColorsDark().onText,
        fontFamily: fontFamily,
      ),
      subtitle2: MyTextThemeStyle.subtitle2(
        MyColorsDark().onText,
        fontFamily: fontFamily,
      ),
      bodyText1: MyTextThemeStyle.bodyText1(
        MyColorsDark().text,
        fontFamily: fontFamily,
      ),
      bodyText2: MyTextThemeStyle.bodyText2(
        MyColorsDark().text,
        fontFamily: fontFamily,
      ),
      button: MyTextThemeStyle.button(
        MyColorsDark().onText,
        fontFamily: fontFamily,
      ),
      caption: MyTextThemeStyle.caption(
        MyColorsDark().textGrayColor,
        fontFamily: fontFamily,
      ),


    );
  }
}
