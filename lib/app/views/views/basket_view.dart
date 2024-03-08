import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:groci/app/controllers/basket_controller.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class BasketView extends GetView {

  const BasketView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final controller = Get.find<BasketController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const LineIcon.shoppingBasket(color: Vx.red500,),
        backgroundColor: Colors.transparent,
        title: Obx(()=>"Panier (${controller.boutiques.length})".text.bold.make()),
        titleTextStyle: TextStyle(color: Get.theme.primaryColor, fontSize: 20),
      ),
      body: Obx(()=>VStack([
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: Vx.gray200,
          child: HStack([
            "Resumé du panier par boutique".text.make(),
            GFIconButton(
              borderSide: const BorderSide(color: Colors.red),
              onPressed: controller.clearCommande,
              icon: const LineIcon.trash(color: Colors.red,),
              size: GFSize.SMALL,
              type: GFButtonType.outline,
            )
          ], alignment: MainAxisAlignment.spaceBetween,),
        ).w(Get.width),

        if (controller.boutiques().isNotEmpty)
          ...controller.boutiques.mapIndexed((element, index) => ListTile(
            leading: Image.network("${element['image']}/${element['image_in']}"),
            title: HStack([
              VStack([
                "${element['nom']}".text.bold.make(),
                "${element['nombre_produit']}/${element['required_nombre']} produits trouvés".text.size(13).gray700.make()
              ]),
              "${element['prix_total']} FCFA".text.red500.italic.bold.make()
            ], alignment: MainAxisAlignment.spaceBetween,),
            subtitle: VStack(
              element['propositions'].map<ListTile>((e)=>ListTile(
                leading: Image.network("${element['image']}/${e['image']}"),
                title: "${e['produit']['nom']} x ${e['quantite']}".text.make(),
                trailing: "${e['somme']} FCFA".text.make(),
              )).toList()
            ).backgroundColor(Vx.gray100),
          ).p(10).card.make()).toList(),

        if (controller.boutiques().isEmpty)
          getEmptyStateWidget()
      ]).scrollVertical()),
    );
  }

  Widget getEmptyStateWidget(){
    return Container(
      alignment: Alignment.center,
      child: Lottie.network("https://c-moinscher.ci/images/paniervide.json"),
    );
  }
}
