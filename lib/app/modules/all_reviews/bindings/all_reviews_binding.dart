import 'package:get/get.dart';

import '../controllers/all_reviews_controller.dart';

class AllReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllReviewsController>(
      () => AllReviewsController(),
    );
  }
}
