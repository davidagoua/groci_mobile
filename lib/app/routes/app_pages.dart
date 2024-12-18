import 'package:get/get.dart';

import '../modules/Acceuil/bindings/acceuil_binding.dart';
import '../modules/Acceuil/views/acceuil_view.dart';
import '../modules/Categorie/bindings/categorie_binding.dart';
import '../modules/Categorie/views/categorie_view.dart';
import '../modules/Landing/bindings/landing_binding.dart';
import '../modules/Landing/views/landing_view.dart';
import '../modules/ProductDetail/bindings/product_detail_binding.dart';
import '../modules/ProductDetail/views/product_detail_view.dart';
import '../modules/ShopResume/bindings/shop_resume_binding.dart';
import '../modules/ShopResume/views/shop_resume_view.dart';
import '../modules/aide/bindings/aide_binding.dart';
import '../modules/aide/views/aide_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;
  static const NEXT = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.ACCEUIL,
      page: () => const AcceuilView(),
      binding: AcceuilBinding(),
    ),
    GetPage(
      name: _Paths.AIDE,
      page: () => const AideView(),
      binding: AideBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIE,
      page: () => const CategorieView(),
      binding: CategorieBinding(),
    ),
    GetPage(
        name: _Paths.PRODUCT_DETAIL,
        page: () => const ProductDetailView(),
        binding: ProductDetailBinding(),
        transition: Transition.downToUp),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_RESUME,
      page: () => const ShopResumeView(),
      binding: ShopResumeBinding(),
    ),
  ];
}
