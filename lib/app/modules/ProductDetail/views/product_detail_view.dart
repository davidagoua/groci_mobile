import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:counter_button/counter_button.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray100,
      appBar: AppBar(
        title: const Text('Comparer'),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: VStack([
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: VStack([
            "${controller.product['nom']} / ${controller.product['unite']}"
                .upperCamelCase
                .text
                .color(Vx.red500)
                .bold
                .make(),
            5.heightBox,
            Image.network(controller.product["image"], height: 120,).centered()
            /*
            CachedNetworkImage(
              imageUrl: ,
              height: 120,
              placeholder: (context, url)=> GFLoader(type: GFLoaderType.ios),
              errorWidget: (context, url, error) => LineIcon.image(color: Colors.red)
            ).centered()
            */
          ]),
        ).backgroundColor(Vx.white).w(MediaQuery.of(context).size.width).h(MediaQuery.of(context).size.height / 10 * 2.5),
        Padding(
          padding: EdgeInsets.all(10),
          child: HStack(
            [
              "Unité".text.color(Vx.gray400).make(),
              "${controller.product['unite']}"
                  .text
                  .color(Vx.gray800)
                  .bold
                  .make()
            ],
            alignment: MainAxisAlignment.spaceBetween,
          ).w(double.maxFinite),
        ).backgroundColor(Vx.white),

        10.heightBox,
        "Vos boutiques".text.make().paddingAll(10),
        Container(
          child: Obx(() => controller.propositions().isEmpty
              ?  Center(
                  child: controller.proposition_loading.value
                      ? SizedBox(child: Lottie.asset("images/product_loading.json"),)
                      : Text("Aucune proposition pour cet article")
                )
              : VStack(controller
                      .propositions()
                      .map((e) => PropositionCard(e))
                      .toList())
                  .scrollVertical(physics: const BouncingScrollPhysics())
                  .h(double.maxFinite)),
        ).pSymmetric(h: 10).expand()
      ]),
    );
  }

}


class PropositionCard extends GetView<ProductDetailController> {

  final Map<String, dynamic> proposition;

  const PropositionCard(Map<String, dynamic> this.proposition, {super.key});

  @override
  Widget build(BuildContext context) {
    return BounceInLeft(
      key: Key('proposition_boutique_${proposition['id']}'),
      from: 15,
      child: Container(

        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 5),
        child: HStack(
          [
            CachedNetworkImage(
                width: 50,
                imageUrl: proposition["boutique_id"]["image"],
                placeholder: (context, url)=> GFLoader(type: GFLoaderType.ios),
                errorWidget: (context, url, error) => LineIcon.image(color: Colors.red)
            ).card.make(),
            "${proposition['prix']} fcfa"
                .text
                .size(10)
                .bold
                .color(Vx.red500)
                .make(),

            HStack([
              /*
              const LineIcon.shoppingBasket(
                color: Vx.white,
              ).p(5).backgroundColor(Get.theme.primaryColor).onTap(
                      ()=> controller.addCommandeToBacket(proposition['id'])
              ).card.make(),

               */

              const LineIcon.phone(
                color: Vx.white,
              ).p(5).cornerRadius(7).backgroundColor(Get.theme.primaryColor)
                  .onTap(this.showBoutiqueContact).card.make(),

              const LineIcon.mapMarker(
                color: Vx.white,
              ).p(5).cornerRadius(7).backgroundColor(Get.theme.primaryColor).onTap(() {
                var url =
                    "https://www.google.ci/maps/@${proposition['boutique_id']['lat']},${proposition['boutique_id']['lng']},12z?hl=fr&entry=ttu";
                //launchUrl(Uri.parse(url));

                controller.showMarker(
                    boutique: proposition["boutique_id"]["nom"] as String,
                    latitude: double.parse(proposition['boutique_id']['lat'])  ,
                    longitude: double.parse(proposition['boutique_id']['lng']) ,

                );

              }).card.make(),
            ])
          ],
          alignment: MainAxisAlignment.spaceBetween,
        ),
      ).backgroundColor(Colors.white).w(double.maxFinite).card.make(),
    );
  }

  void showBoutiqueContact(){
    Get.bottomSheet(VStack(key:Key(''),[
      HStack([
        CachedNetworkImage(
            width: 90,
            imageUrl: proposition["boutique_id"]["image"],
            placeholder: (context, url)=> GFLoader(type: GFLoaderType.ios),
            errorWidget: (context, url, error) => LineIcon.image(color: Colors.red)
        ).card.make(),
        5.widthBox,
        VStack([
          "${proposition["boutique_id"]["nom"]}".text.size(18).bold.make(),
          5.heightBox,
          "${proposition["boutique_id"]["contact"]}".text.gray500.bold.make(),
          "${proposition["boutique_id"]["email"] ?? ""}".text.gray500.bold.make(),
          "${proposition["boutique_id"]["ville"] ?? ""}, ${proposition["boutique_id"]["quartier"] ?? ""}".text.gray500.bold.make(),
        ])
      ]).p(3),
      15.heightBox,
      GFButton(
        onPressed: ()=> launchUrl(new Uri(scheme: "tel", path: proposition['boutique_id']['contact'])),
        blockButton: true,
        icon: LineIcon.phone(color: Vx.white,),
        color: Get.theme.primaryColor,
        child: "Appeler".text.white.make(),
      ).centered()
    ]).card.white.topRounded(value: 7).make());
  }
}
