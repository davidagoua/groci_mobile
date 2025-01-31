import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/search_controller.dart' as search;
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:groci/app/routes/app_pages.dart';



class SearchView extends GetView<search.SearchController> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: VStack([
        HStack([
          TextField(
            onChanged: (value) async =>controller.fetchProducts(searchQuery: value),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: "Rechercher un article..."
            ),
          ).expand(),
          IconButton(onPressed: (){}, icon: LineIcon.filter()),
          IconButton(onPressed: (){}, icon: LineIcon.sortAlphabeticalUp()),
        ]).card.elevation(0).roundedLg.gray100.make(),
        10.heightBox,
        getProduitsWidget()
      ]).pSymmetric(v: 5, h: 10),
    );
  }

  Widget getProduitsWidget() {
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.white,
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Obx(() => controller.isLoading()
              ? SizedBox(child: Lottie.asset("images/product_loading.json"),)
              : AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  width: 0,
                  child: controller.searchResult().isEmpty
                      ? Container(
                          child:
                              "Aucun produits retrouvés".text.make().centered(),
                        )
                      : VStack(controller
                              .searchResult()
                              .map((e) => getProductListCart(e))
                              .toList())
                          .scrollVertical(physics: BouncingScrollPhysics()),
                )),
        ).w(double.maxFinite),
      );
    }

    Widget getProductListCart(Map<String, dynamic> produit) {
      return BounceInDown(
        child: Container(
        key: Key("acceuil_product_${produit['id']}"),
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          leading: CachedNetworkImage(
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
        }),
      )
      );
    }
}
