import 'package:get/get.dart';

import '../controllers/shop_resume_controller.dart';

class ShopResumeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopResumeController>(
      () => ShopResumeController(),
    );
  }
}
