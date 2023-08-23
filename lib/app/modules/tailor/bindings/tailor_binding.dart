import 'package:get/get.dart';

import '../controllers/tailor_controller.dart';

class TailorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TailorController>(
      () => TailorController(),
    );
  }
}
