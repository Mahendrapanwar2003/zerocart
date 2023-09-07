import 'package:flutter/material.dart';

class MyDatePicker{
  static Future<DateTime?> datePicker(
      {DateTime? lastDate, DateTime? firstDate, DateTime? initialDate,required BuildContext context,required Color lightColorPrimaryColor,required Color darkColorPrimaryColor}) async {
    MaterialColor materialColor = MaterialColor(
      darkColorPrimaryColor.value,
      <int, Color>{
        50: Color(0xFFFFF8E1),
        100: Color(0xFFFFECB3),
        200: Color(0xFFFFE082),
        300: Color(0xFFFFD54F),
        400: Color(0xFFFFCA28),
        500: darkColorPrimaryColor,
        600: Color(0xFFFFB300),
        700: Color(0xFFFFA000),
        800: Color(0xFFFF8F00),
        900: Color(0xFFFF6F00),
      },
    );
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData(
          brightness: Theme.of(context).brightness,
          primarySwatch: materialColor,
          cardColor: Theme.of(context).brightness == Brightness.dark
              ? darkColorPrimaryColor
              : lightColorPrimaryColor,
        ),
        child: child ?? const SizedBox(),
      ),
    );
    return pickedDate;
  }
}