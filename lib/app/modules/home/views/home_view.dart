import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_icon_badge.dart';
import 'package:groci/app/controllers/basket_controller.dart';
import 'package:groci/app/modules/Acceuil/views/acceuil_view.dart';
import 'package:groci/app/modules/Categorie/views/categorie_view.dart';
import 'package:groci/app/modules/profile/views/profile_view.dart';
import 'package:groci/app/views/views/basket_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Obx(()=> getBottomBar(context)),
      body: SafeArea(
        child: VStack([
          Obx(()=>IndexedStack(
            index: controller.index.value,
            children: const [
              CategorieView(),
              AcceuilView(),
              BasketView(),
              ProfileView(),
            ],
          ).expand()),

        ]),
      ),
    );
  }
  
  Widget getBottomBar(BuildContext context){



    return BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.menu_open), label: "Menu"),
        const BottomNavigationBarItem(icon: LineIcon.home(), label: "Acceuil"),
        BottomNavigationBarItem(
          icon: Obx(()=>GFIconBadge(
            counterChild: GFBadge(text: controller.basketController.commandes.keys.count().toString(),),
            child: const LineIcon.shoppingCart(),
          )),
          label: "Aide"
        ),
        const BottomNavigationBarItem(icon: LineIcon.userCircle(), label: "Profile"),
      ],
      selectedItemColor: Get.theme.primaryColor,
      unselectedItemColor: Colors.black,
      currentIndex: controller.index.value,
      onTap: controller.index,
      useLegacyColorScheme: false,
      elevation: 0,
    );
  }


}
