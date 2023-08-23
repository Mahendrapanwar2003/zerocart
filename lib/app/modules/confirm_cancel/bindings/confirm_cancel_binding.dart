import 'package:get/get.dart';

import '../controllers/confirm_cancel_controller.dart';

class ConfirmCancelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmCancelController>(
      () => ConfirmCancelController(),
    );
  }
}
