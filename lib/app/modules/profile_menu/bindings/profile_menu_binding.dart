import 'package:get/get.dart';

import '../controllers/profile_menu_controller.dart';

class ProfileMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileMenuController>(
      () => ProfileMenuController(),
    );
  }
}
