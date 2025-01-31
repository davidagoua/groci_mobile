import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:groci/app/modules/home/controllers/home_controller.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:groci/app/routes/app_pages.dart';
import '../controllers/sous2categorie_controller.dart';
import '../../product_list/controllers/product_list_controller.dart';
import 'package:animate_do/animate_do.dart';



class Sous2categorieView extends GetView<Sous2categorieController> {
  const Sous2categorieView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Sous Sous Categories'),
        centerTitle: true,
      ),
      body: VStack([
        getHeader(),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          color: Colors.red[500],
          child: "${controller.selectedCategorie['nom']}"
              .text
              .white
              .bold
              .makeCentered(),
        ),
        10.heightBox,
        Expanded(
          child: FutureBuilder(
            future: controller.fetchSousCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 3,
                  children:
                      List.generate(controller.sousCategories.length, (index) {
                    final categorie = controller.sousCategories[index];
                    return InkWell(
                      onTap: () {
                        ProductListController productController =
                            Get.find<ProductListController>();
                        productController.categorie.value = categorie;
                        productController.onSous2CategorieSelect(categorie);

                        HomeController homeController =
                            Get.find<HomeController>();

                        homeController.index(1);
                        Get.toNamed(Routes.HOME);
                      },
                      child: ZoomIn(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(7)),
                            child: VStack(
                              [
                                CachedNetworkImage(
                                    imageUrl: categorie["image"],
                                    placeholder: (context, url)=> GFLoader(type: GFLoaderType.ios),
                                    errorWidget: (context, url, error) => LineIcon.image(color: Colors.red)
                                ).h(40),
                                5.heightBox,
                                "${categorie['nom']}"
                                    .text
                                    .size(10)
                                    .align(TextAlign.center)
                                    .make()
                                    .centered()
                              ],
                              alignment: MainAxisAlignment.center,
                              crossAlignment:
                              CrossAxisAlignment.center,
                            ),
                          )
                      )
                    );

                  }),
                );
              }
            },
          ),
        )
      ]),
    );
  }

  Widget getHeader(){
    return Container(
      child: VStack([
         HStack(
          [
            Container(
              child: Image.asset("images/amoirie.jpg"),
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
