import 'package:get/get.dart';

import '../controllers/main_splash_controller.dart';

class MainSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainSplashController>(
      () => MainSplashController(),
    );
  }
}
