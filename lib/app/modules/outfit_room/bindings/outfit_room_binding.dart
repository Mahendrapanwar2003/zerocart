import 'package:get/get.dart';

import '../controllers/outfit_room_controller.dart';

class OutfitRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutfitRoomController>(
      () => OutfitRoomController(),
    );
  }
}
