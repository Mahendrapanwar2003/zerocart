import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_library/ui_library.dart';

class MyAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

   const MyAlertDialog(
      {Key? key, this.title, this.content, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: actions,
      insetAnimationDuration: const Duration(seconds: 1),
    );
  }
}


class CommonDialog{

  static commonAlertDialogBox(
      {required String title,
        required String content,
        required String leftButtonTitle,
        required String rightButtonTitle,
        Color? leftButtonTitleColor,
        Color? rightButtonTitleColor,
        required VoidCallback leftButtonOnPressed,
        required VoidCallback rightButtonOnPressed}) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: Theme.of(Get.context!).textTheme.subtitle1,
      ),
      content: Text(
        content,
        style: Theme.of(Get.context!).textTheme.headline3,
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: leftButtonOnPressed,
          child: Text(
            leftButtonTitle,
            style: Theme.of(Get.context!).textTheme.bodyText1
                ?.copyWith(fontSize: 12.px,color: leftButtonTitleColor),
          ),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: rightButtonOnPressed,
          child: Text(
            rightButtonTitle,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyText1
                ?.copyWith(fontSize: 12.px,color: rightButtonTitleColor),
          ),
        ),
      ],
      insetAnimationDuration: const Duration(seconds: 1),
    );
  }

}