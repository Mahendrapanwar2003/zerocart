import 'package:get/get.dart';
import 'package:zerocart/app/modules/add_address/controllers/add_address_controller.dart';

import '../controllers/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
  /*  Get.lazyPut<AddAddressController>(
      () => AddAddressController(),
    );*/
  }
}
