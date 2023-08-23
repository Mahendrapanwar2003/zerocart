import 'package:get/get.dart';

import '../controllers/search_item_controller.dart';

class SearchItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchItemController>(
      () => SearchItemController(),
    );
  }
}
