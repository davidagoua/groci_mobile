import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:groci/app/routes/app_pages.dart';
import 'package:line_icons/line_icon.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/categorie_controller.dart';
import 'package:groci/utils/contants.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CategorieView extends GetView<CategorieController> {
  const CategorieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray100,
      body: Container(
        child: VStack([
          getHeader(),
          Obx(()=>Container(
              child: DropdownSearch<String>(
            selectedItem: controller.ville.value,
            items: (filter, infiniteScrollProps) => kVilles,
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) => controller.changeVille(value!),
            popupProps: PopupProps.menu(
                fit: FlexFit.loose, constraints: BoxConstraints()),
          ))),
          5.heightBox,
          Obx(
            () => controller.categories().isEmpty
                ? Center(
                    child: SizedBox(
                      child: Lottie.asset("images/product_loading.json"),
                    ),
                  )
                : LiquidPullToRefresh(
                        height: 50,
                        backgroundColor: Colors.white,
                        color: Colors.red[500],
                        onRefresh: handleRefresh,
                        child: VStack([
                          GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: controller
                                .categories()
                                .map((e) => ZoomIn(
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
                                                imageUrl: e["image"],
                                                placeholder: (context, url)=> GFLoader(type: GFLoaderType.ios),
                                                errorWidget: (context, url, error) => LineIcon.image(color: Colors.red)
                                            ).h(40),
                                            5.heightBox,
                                            AutoSizeText(
                                              "${e['nom']}",
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 10),
                                            ).centered()
                                          ],
                                          alignment: MainAxisAlignment.center,
                                          crossAlignment:
                                              CrossAxisAlignment.center,
                                        ),
                                      ).cornerRadius(5).onTap(() => Get.toNamed(
                                          Routes.SOUSCATEGORIE,
                                          arguments: {"categorie": e}))
                                      ,
                                    ))
                                .toList(),
                          ).expand(),
                          110.heightBox
                        ])
                            .h(MediaQuery.of(context).size.height / 10 * 8.5)
                            .marginOnly(top: 5))
                    .pOnly(bottom: 40),
          ),
        ]).scrollVertical(physics: BouncingScrollPhysics()),
      ),
    );
  }

  Widget getHeader() {
    return Container(
      child: VStack(
        [
          Obx(() => !controller.load.value
              ? GFLoader(type: GFLoaderType.ios)
              : HStack(
                  [
                    Container(
                      child: Image.asset("images/amoirie.jpg"),
                    ).h(30),
                    Container(
                      child: Image.asset("images/group.png"),
                    ).h(30),
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                ).w(double.maxFinite)),
          5.heightBox,
          Container(
            child: Image.asset("images/logo.jpg"),
          ).h(50),
        ],
        crossAlignment: CrossAxisAlignment.center,
      ).p(15).backgroundColor(Vx.white),
    );
  }

  Future<void> handleRefresh() async {
    controller.fetchCategories();
  }
}
