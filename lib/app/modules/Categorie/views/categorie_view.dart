import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:groci/app/modules/Acceuil/controllers/acceuil_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
      body: Container(
        child: VStack([
           getHeader(),

          Obx(() => controller.categories().isEmpty
            ? Center(child: SizedBox(child: Lottie.asset("images/product_loading.json"),),)
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
                    children: controller.categories().map((e) => ZoomIn(
                      child: Container(

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
                        acceuilController.onCategorieSelect(categorie_id: e['id']);
                        controller.index(1);
                      }),
                    )).toList(),

                  ).expand(),
                  110.heightBox
                ]).h(MediaQuery.of(context).size.height / 10 * 8.5).marginOnly(top: 5)).pOnly(bottom: 20),
              ),

        ]).scrollVertical(physics: BouncingScrollPhysics()),
      ),
    );
  }

  Widget getHeader(){
    return Container(
        child: VStack([
          Obx(()=>  !controller.load.value ? GFLoader(type: GFLoaderType.ios) : HStack(
            [
              Container(
                child: Image.asset("images/amoirie.png"),
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
        ], crossAlignment: CrossAxisAlignment.center,).p(15).backgroundColor(Vx.white),
    );
  }

  Future<void> handleRefresh() async {
    controller.fetchCategories();

  }
}
