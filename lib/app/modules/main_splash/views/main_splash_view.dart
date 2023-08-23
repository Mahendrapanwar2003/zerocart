import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zerocart/app/common_widgets/common_widgets.dart';
import '../controllers/main_splash_controller.dart';

class MainSplashView extends GetView<MainSplashController> {
  const MainSplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonWidgets.zeroCartBagImage(),
          CommonWidgets.loaderAnimation(controller.colorTween,),
          //test
        ],
      ),
    );
  }
}
