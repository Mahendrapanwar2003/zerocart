import 'package:get/get.dart';

import '../controllers/measurements_controller.dart';

class MeasurementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeasurementsController>(
      () => MeasurementsController(),
    );
  }
}
