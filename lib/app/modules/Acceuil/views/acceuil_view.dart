import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:groci/app/routes/app_pages.dart';
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

        getCategorieWidget(),
        10.heightBox,
        getSearchesBox(),
        10.heightBox,
        getProduitsWidget()
      ]).w(double.maxFinite),
    );
  }

  Widget getCategorieWidget() {
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
                    .categories()
                    .map((e) => Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                  controller.fetchProducts(categorie_id: e['id']);
                }))
                    .toList(),
              ).scrollHorizontal()
            ])),
    ).h(Get.height / 10 * 1.8).w(double.maxFinite);
  }

  Widget getSearchesBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FormBuilder(
        key: controller.formKey,
        child: VStack([
          Obx(() => FormBuilderDropdown<String>(
                name: 'villes',
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Choisissez votre ville",
                    suffixIconColor: Vx.red500),
                items: controller.villes().map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
              )),
          5.heightBox,
          FormBuilderTextField(
            name: 'query',
            onChanged: (value) {
              controller.search(value);
              controller.fetchProducts();
            },
            controller: controller.query_ctl,
            decoration: const InputDecoration(
              hintText: "Rechercher un produit...",
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          )
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
                        .scrollVertical(),
              )),
      ).w(double.maxFinite),
    );
  }

  Widget getProductListCart(Map<String, dynamic> produit) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      leading: Image.network(produit["image"]).card.make(),
      title: "${produit['nom']}".text.bold.size(17).make(),
      subtitle: "${produit['unite']}".text.gray500.size(15).make(),
      trailing: VStack([
        produit['min_price'] == null
            ? "Aucune".text.green700.size(10).make()
            : "${produit['min_price']}f".text.size(10).color(Vx.gray500).make()
      ]),
    ).card.white.make().onTap(() =>
        Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {"product": produit}));
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
}
