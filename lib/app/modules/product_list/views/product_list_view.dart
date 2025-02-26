import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:groci/utils/contants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/product_list_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:groci/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VStack([
        getHeader(context),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          color: Colors.red[500],
          child: "${controller.categorie['nom'] ?? "Toutes les categories"}"
              .text
              .white
              .bold
              .makeCentered(),
        ),

        10.heightBox,
        Expanded(
          child: getProduitsWidget(),
        ),

      ])
    );
  }



  Widget getHeader(BuildContext context){
    return VStack([
      Navigator.canPop(context) ? HStack([
        Icon(Icons.arrow_back).onTap(Get.back),
        1.heightBox.expand()
      ]) : 1.widthBox,
      [
        Image.asset("images/amoirie.jpg", height: 30,),
        Image.asset("images/group.png", height: 30,),
      ].hStack(alignment: MainAxisAlignment.spaceBetween).w(double.maxFinite)
      ,
      5.heightBox,
      Image.asset("images/logo.jpg", height: 50,)
    ], crossAlignment: CrossAxisAlignment.center).p(15).backgroundColor(Vx.white);
  }

  Widget getProductListCart(Map<String, dynamic> produit) {
    return BounceInDown(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        leading: CachedNetworkImage(
          width: 40,
          height: 40,
          imageUrl: produit["image"],
          placeholder: (context, url)=> GFLoader(type: GFLoaderType.ios),
          errorWidget: (context, url, error) => LineIcon.image(color: Colors.red)
        ).card.make(),
        title: "${produit['nom']}".text.bold.size(17).make(),
        subtitle: "${produit['unite']}".text.gray500.size(15).make(),
        trailing: VStack([
          produit['min_price'] == null
              ? "Aucune".text.green700.size(10).make()
              : "${produit['min_price']} fcfa".text.size(10).color(Vx.gray500).make()
        ]),
      ).card.make().onTap(()  {
        Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {"product": produit});
      })
    );
  }

  Widget getProduitsWidget() {
    return Container(
      color: Colors.grey[100],
      transformAlignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Obx(() => controller.loading()
          ? SizedBox(child: Lottie.asset("images/product_loading.json"),)
          : AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        width: 0,
        child: controller.products().isEmpty
            ? Container(
          child:
          "Aucun produits retrouvés".text.make().centered(),
        )
            : VStack(controller
            .products()
            .map((e) => getProductListCart(e))
            .toList())
            .scrollVertical(physics: BouncingScrollPhysics()),
      )),
    ).w(double.maxFinite);
  }
}
