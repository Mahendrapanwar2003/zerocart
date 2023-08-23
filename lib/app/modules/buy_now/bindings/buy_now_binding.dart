import 'package:get/get.dart';

import '../controllers/buy_now_controller.dart';

class BuyNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyNowController>(
      () => BuyNowController(),
    );
  }
}
