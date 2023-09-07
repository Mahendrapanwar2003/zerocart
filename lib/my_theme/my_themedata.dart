
import 'package:flutter/material.dart';
import 'package:zerocart/my_colors/my_colors.dart';
import 'package:zerocart/my_responsive_sizer/src/extension.dart';
import 'package:zerocart/my_text_style/my_text_style.dart';

class MyThemeData {
  static ThemeData themeDataLight({
    required Orientation? orientation,
    String? fontFamily,
  }) {
    return ThemeData(
      textTheme: MyTextThemeLight() .myTextTheme(fontFamily: fontFamily),
      primaryColor: MyColorsLight().primaryColor,
      scaffoldBackgroundColor: MyColorsLight().scaffoldBackgroundColor,
      colorScheme: ColorScheme(
          primary: MyColorsLight().primary,
          onPrimary: MyColorsLight().onPrimary,
          secondary: MyColorsLight().secondary,
          onSecondary: MyColorsLight().textGrayColor,
          error: MyColorsLight().error,
          brightness: Brightness.light,
          onError: MyColorsLight().error,
          background: MyColorsLight().  backGround,
          onBackground: MyColorsLight().backGround,
          surface: MyColorsLight().text,
          onSurface: MyColorsLight().onText,
      onSecondaryContainer: MyColorsLight().onSecondary),
      textSelectionTheme:
      TextSelectionThemeData(cursorColor: MyColorsLight().primaryColor),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(top: 1),
        constraints: BoxConstraints(maxHeight: 70.px),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColorsLight().onPrimary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColorsLight().primary),
        ),
        /*errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyColors().error),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyColors().error),
          ),*/
        //hintStyle: MyTextThemeStyle.bodyText2(MyColors().caption),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.px),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.px),
              ),
              padding: EdgeInsets.zero,
              foregroundColor: MyColorsLight().primary)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.px),
            ),
            foregroundColor: MyColorsLight().text,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(3.5.px),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
    );
  }

  static ThemeData themeDataDark({
    required Orientation? orientation,
    String? fontFamily,
  }) {
    return ThemeData(
      textTheme: MyTextThemeDark().myTextTheme(fontFamily: fontFamily),
      primaryColor: MyColorsDark().primaryColor,
      scaffoldBackgroundColor: MyColorsDark().scaffoldBackgroundColor,
      colorScheme: ColorScheme(
          primary: MyColorsDark().primary,
          onPrimary: MyColorsDark().onPrimary,
          secondary: MyColorsDark().secondary,
          onSecondary: MyColorsDark().textGrayColor,
          error: MyColorsDark().error,
          brightness: Brightness.dark,
          onError: MyColorsDark().error,
          background: MyColorsDark().backGround,
          onBackground: MyColorsDark().backGround,
          surface: MyColorsDark().text,
          onSurface: MyColorsDark().onText,
          onSecondaryContainer: MyColorsDark().onSecondary),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: MyColorsDark().primaryColor),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(top: 1),
        constraints: BoxConstraints(maxHeight: 70.px),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColorsDark().onPrimary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColorsDark().primary),
        ),
        /*errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyColors().error),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyColors().error),
          ),*/
        //hintStyle: MyTextThemeStyle.bodyText2(MyColors().caption),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.px),
              ),
              padding: EdgeInsets.zero,
              foregroundColor: MyColorsDark().primary)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.px),
            ),
            foregroundColor: MyColorsLight().text,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(3.5.px),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
    );
  }
}
