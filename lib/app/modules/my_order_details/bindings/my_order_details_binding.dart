import 'package:get/get.dart';

import '../controllers/my_order_details_controller.dart';

class MyOrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderDetailsController>(
      () => MyOrderDetailsController(),
    );
  }
}
