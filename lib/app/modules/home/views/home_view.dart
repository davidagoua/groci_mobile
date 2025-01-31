import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_icon_badge.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:groci/app/modules/Acceuil/views/acceuil_view.dart';
import 'package:groci/app/modules/Categorie/views/categorie_view.dart';
import 'package:groci/app/modules/profile/views/profile_view.dart';
import 'package:groci/app/modules/Search/views/search_view.dart';
import 'package:groci/app/modules/product_list/views/product_list_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_network_status/network_status.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Obx(()=> getBottomBar(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        onPressed: ()=> controller.scanBarCode(),
        child: LineIcon.barcode(color: Colors.white,),
      ),
      body: SafeArea(
        child: ZStack([

          VStack([
            Obx(()=>IndexedStack(
              index: controller.index.value,
              children: const [
                CategorieView(),
                ProductListView(),
                SearchView(),
                ProfileView(),
              ],
            ).expand()),

          ]),

          Obx(() => controller.barcodeLoading.value ? Container(
            decoration: BoxDecoration(
                color: const Color(0xFF0E3311).withOpacity(0.2)
            ),
            child: LimitedBox(
              child: GFLoader(type: GFLoaderType.square),
            ),
          ) :  1.heightBox),
        ]),
      ),
    );
  }
  
  Widget getBottomBar(BuildContext context){

    return StylishBottomBar(
      fabLocation: StylishBarFabLocation.center,
      option: AnimatedBarOptions(
        iconStyle: IconStyle.animated,
      ),
      items: [
        BottomBarItem(icon: Icon(Icons.menu_open), title: "Categories".text.make(), selectedColor: Get.theme.primaryColor),
        BottomBarItem(icon: LineIcon.home(), title: "Produits".text.make(), selectedColor: Get.theme.primaryColor),
        BottomBarItem(icon: LineIcon.search(), title: "Recherche".text.make(), selectedColor: Get.theme.primaryColor),
        /*
        BottomBarItem(
          icon: Obx(()=>GFIconBadge(
            counterChild: GFBadge(text: controller.basketController.commandes.keys.count().toString(),),
            child: const LineIcon.shoppingCart(),
          )),
          title: "Panier".text.make(),
          selectedColor: Get.theme.primaryColor
        ),
        */
        BottomBarItem(icon: LineIcon.user(), title: "Profile".text.make(), selectedColor: Get.theme.primaryColor),
      ],
      currentIndex: controller.index.value,
      onTap: controller.index,
      elevation: 8 ,
    );
  }


}
