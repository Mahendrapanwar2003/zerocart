import 'package:get/get.dart';

import '../controllers/category_product_controller.dart';

class CategoryProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryProductController>(
      () => CategoryProductController(),
    );
  }
}
