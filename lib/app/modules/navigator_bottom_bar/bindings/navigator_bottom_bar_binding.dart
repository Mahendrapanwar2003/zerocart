import 'package:get/get.dart';

import '../controllers/navigator_bottom_bar_controller.dart';

class NavigatorBottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatorBottomBarController>(
      () => NavigatorBottomBarController(),
    );
  }
}
