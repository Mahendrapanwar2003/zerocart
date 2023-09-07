import 'package:flutter/material.dart';

class MyTimePicker{
  Future<TimeOfDay?> timePickerView(
      {required BuildContext context,
        required Color lightColorPrimaryColor,
        required Color darkColorPrimaryColor}) {
    MaterialColor materialColor = MaterialColor(
      darkColorPrimaryColor.value,
      <int, Color>{
        50: const Color(0xFFFFF8E1),
        100: const Color(0xFFFFECB3),
        200: const Color(0xFFFFE082),
        300: const Color(0xFFFFD54F),
        400: const Color(0xFFFFCA28),
        500: darkColorPrimaryColor,
        600: const Color(0xFFFFB300),
        700: const Color(0xFFFFA000),
        800: const Color(0xFFFF8F00),
        900: const Color(0xFFFF6F00),
      },
    );
    return showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 00),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            brightness: Theme.of(context).brightness,
            primarySwatch: materialColor,
            cardColor: Theme.of(context).brightness == Brightness.dark
                ? darkColorPrimaryColor
                : lightColorPrimaryColor,
          ),
          child: child ?? const SizedBox(),
        );
      },
    );
  }

}