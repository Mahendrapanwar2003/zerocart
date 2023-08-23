import 'package:get/get.dart';

import '../controllers/cancel_order_controller.dart';

class CancelOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelOrderController>(
      () => CancelOrderController(),
    );
  }
}
