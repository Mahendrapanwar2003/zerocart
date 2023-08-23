import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zerocart/app/custom/custom_appbar.dart';

import '../controllers/tailor_controller.dart';

class TailorView extends GetView<TailorController> {
  const TailorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyCustomContainer().myAppBar(
          text: 'Tailor',
          backIconOnPressed: () => controller.clickOnBackButton(),
          isIcon: true),
      body: const Center(
        child: Text(
          'TailorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
