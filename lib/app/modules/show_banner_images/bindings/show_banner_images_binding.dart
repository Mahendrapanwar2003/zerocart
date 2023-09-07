import 'package:get/get.dart';
import '../controllers/show_banner_images_controller.dart';

class ShowBannerImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowBannerImagesController>(
      () => ShowBannerImagesController(),
    );
  }
}
