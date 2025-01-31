import 'package:get/get.dart';
import 'package:groci/app/controllers/basket_controller.dart';
import 'package:groci/app/modules/Search/controllers/search_controller.dart' as search;
import 'package:groci/app/modules/Acceuil/controllers/acceuil_controller.dart';
import 'package:groci/app/modules/Categorie/controllers/categorie_controller.dart';
import 'package:groci/app/modules/aide/controllers/aide_controller.dart';
import 'package:groci/app/modules/profile/controllers/profile_controller.dart';
import 'package:groci/app/modules/product_list/controllers/product_list_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<AcceuilController>(() => AcceuilController());
    Get.lazyPut<ProductListController>(() => ProductListController());
    Get.lazyPut<AideController>(() => AideController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<CategorieController>(() => CategorieController());
    Get.put<search.SearchController>(search.SearchController());
    Get.lazyPut<BasketController>(() => BasketController());
  }
}
