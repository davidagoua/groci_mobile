import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:groci/app/modules/Acceuil/controllers/acceuil_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/categorie_controller.dart';

class CategorieView extends GetView<CategorieController> {

  const CategorieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Vx.gray100 ,
      body: VStack([
        VStack([
          HStack(
            [
              Image.asset("images/amoirie.png").h(30),
              Image.asset("images/group.png").h(30)
            ],
            alignment: MainAxisAlignment.spaceBetween,
          ).w(double.maxFinite),
          5.heightBox,
          Image.asset("images/logo.jpg").h(50),
        ], crossAlignment: CrossAxisAlignment.center,).h(Get.height / 10 * 1.5).p(15).backgroundColor(Vx.white),

        Obx(() => controller.categories().isEmpty
          ? Center(child: SizedBox(child: Lottie.asset("images/product_loading.json"),),)
          : GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: controller.categories().map((e) => Container(

            padding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7)),
            child: VStack(
              [
                Image.network(e['image']).h(40),
                5.heightBox,
                "${e['nom']}".text.size(10).align(TextAlign.center).make().centered()
              ],
              alignment: MainAxisAlignment.center,
              crossAlignment: CrossAxisAlignment.center,
            ),
          ).cornerRadius(5).onTap(() {
            HomeController controller = Get.find<HomeController>();
            AcceuilController acceuilController = Get.find<AcceuilController>();
            acceuilController.fetchProducts(categorie_id: e['id']);
            controller.index(1);
          })).toList(),
        ).h(Get.height / 10 * 7).marginOnly(top: 5).scrollVertical())
      ]),
    );
  }
}
