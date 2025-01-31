import 'package:get/get.dart';

import '../controllers/sous2categorie_controller.dart';

class Sous2categorieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Sous2categorieController>(
      () => Sous2categorieController(),
    );
  }
}
