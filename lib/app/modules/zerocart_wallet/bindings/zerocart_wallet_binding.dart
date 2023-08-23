import 'package:get/get.dart';

import '../controllers/zerocart_wallet_controller.dart';

class ZerocartWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZerocartWalletController>(
      () => ZerocartWalletController(),
    );
  }
}
