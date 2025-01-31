import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:groci/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/acceuil_controller.dart';

class AcceuilView extends GetView<AcceuilController> {
  const AcceuilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VStack([

        getHeader(),
        
        /*
        Obx(() => controller.showCategorie.value ? ZoomIn(child: getCategorieWidget(context), duration: Duration(milliseconds: 300),) : 0.heightBox),
        10.heightBox,
        getSous2Catgeorie(),
        10.heightBox,
        */

        //getSearchesBox(),
        10.heightBox,
        getProduitsWidget()
      ]).w(double.maxFinite),
    );
  }

  Widget getCategorieWidget(BuildContext context) {
    return Container(
      color: Get.theme.primaryColor,
      child: Obx(() => controller.categories.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Get.theme.primaryColor,
                color: Colors.white,
              ),
            )
          : VStack([
              "${controller.selectedCategorie['nom'] ?? "" }".text.white.center.make().w(double.maxFinite),
              HStack(
                controller
                    .sousCategories()
                    .map((e) => Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      color: controller.selectedSousCategorie.value == e['id'] ? Colors.red[200] : Colors.white,
                      borderRadius: BorderRadius.circular(7)),
                  child: VStack(
                    [
                      Image.network(e['image']).h(40),
                      "${e['nom']}".text.make()
                    ],
                    alignment: MainAxisAlignment.center,
                    crossAlignment: CrossAxisAlignment.center,
                  ),
                ).onTap(() {
                  controller.onSousCategorieSelect(categorie_id: e['id']);
                }))
                    .toList(),
              ).scrollHorizontal()
            ])),
    ).h(MediaQuery.of(context).size.height / 10 * 1.8).w(double.maxFinite);
  }

  Widget getSearchesBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FormBuilder(
        key: controller.formKey,
        child: VStack([

          Obx(()=>Container(
            child: FormBuilderTextField(
              focusNode: controller.searchFocus,
              name: 'query',
              onChanged: (value) {
                controller.search(value);
                controller.fetchProducts();
              },
              controller: controller.query_ctl,
              decoration:  InputDecoration(
                hintText: "Rechercher un produit...",
                suffixIcon: controller.search.value.length <= 0 ? Icon(Icons.search) : Icon(LineIcons.times).onTap(() {
                  controller.search("");
                  controller.query_ctl.text = "";
                  controller.fetchProducts();
                  controller.searchFocus.unfocus();
                }),
                border: OutlineInputBorder(),
              ),
            )
          ))
        ]),
      ),
    );
  }

  Widget getProduitsWidget() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.grey[100],
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Obx(() => controller.product_loading()
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
        leading: Image.network(produit["image"]).card.make(),
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

  Widget getHeader(){
    return Container(
      child: VStack([
         HStack(
          [
            Container(
              child: Image.asset("images/amoirie.png"),
            ).h(30),
            Container(
              child: Image.asset("images/group.png"),
            ).h(30),

          ],
          alignment: MainAxisAlignment.spaceBetween,
        ).w(double.maxFinite)
        ,
        5.heightBox,
        Container(
          child: Image.asset("images/logo.jpg"),
        ).h(50),
      ], crossAlignment: CrossAxisAlignment.center,).p(15).backgroundColor(Vx.white),
    );
  }

  Widget getSous2Catgeorie(){
    return Container(
      child: Obx(()=> VStack([
        HStack(
          controller.sous2Categories.map((element) => GFButton(
            shape: GFButtonShape.pills,
            color: controller.selectedSous2Categorie.value == element.id ? Vx.red500 : Vx.white,
            onPressed: ()=>{
              controller.onSous2CategorieSelect(element.id)
            },
            child: HStack([
              Image.network(element.image),
              2.widthBox,
              "${element.nom}".text.color(controller.selectedSous2Categorie.value == element.id ? Vx.white : Vx.red500).make()
            ])
          ).pOnly(right: 2)).toList(),
        ).scrollHorizontal()
      ]))
    );
  }
}
