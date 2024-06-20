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
        title: Obx(()=>"${controller.total} FCFA".text.bold.make()),
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

        if(controller.oneLoading.value)
          const CircularProgressIndicator(),

        if (controller.boutiques().isNotEmpty)
          ...controller.boutiques.mapIndexed((element, index) => getBoutiqueCard(context, element, index)).toList(),

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

  Widget getResumeCard(BuildContext context, dynamic element, int index){
    return ListTile(
      leading: Image.network("${element['image']}/${element['image_in']}"),
      title: HStack([
        VStack([
          "${element['nom']}".text.bold.make(),
          "${element['nombre_produit']}/${element['required_nombre']} produits trouvés".text.size(13).gray700.make()
        ]),
        "${element['prix_total']} FCFA".text.red500.italic.bold.make(),
      ], alignment: MainAxisAlignment.spaceBetween,),
      subtitle: getProductItem(element),
    ).p(10).card.make();
  }

  Widget getBoutiqueCard(BuildContext, dynamic element, int index){
    return Container(
      child: VStack([
        HStack([
          Image.network("${element['image']}/${element['image_in']}", width: 70,).card.make(),
          10.widthBox,
          VStack([
            "${element['nom']}".text.bold.make(),
            "${element['prix_total']} FCFA".text.red500.italic.size(17).bold.make(),
            "${element['nombre_produit']}/${element['required_nombre']} produits trouvés".text.size(13).black.make()
          ])
        ]),

         true
            ? VStack([
                getProductItem(element)
              ])
            : 0.heightBox
      ]),
    ).p(7).card.make().backgroundColor(Colors.white).w(double.maxFinite);
  }

  Widget getProductItem(element) {

    final controller = Get.find<BasketController>();

    return VStack(
        element['propositions'].map<Widget>((e)=>HStack([
            Image.network("${element['image']}/${e['image']}", height: 50,),
            5.widthBox,
            "${e['produit']['nom']} x ${e['quantite']} \n${e['somme']} FCFA".text.make(),
            const Spacer(),
            IconButton(
              onPressed: ()=> controller.removeProposition(e['id']),
              icon: const LineIcon.times(color: Colors.red)
            )
          ]
        ).backgroundColor(Colors.white).marginOnly(top: 5).card.roundedSM.make()).toList()
    ).backgroundColor(Vx.gray100);
  }
  

}
