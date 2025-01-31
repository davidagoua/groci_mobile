import 'package:get/get.dart';

import '../controllers/souscategorie_controller.dart';

class SouscategorieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SouscategorieController>(
      () => SouscategorieController(),
    );
  }
}
