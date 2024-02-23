import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.theme.primaryColor,
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: VStack([
        Container(
          padding: EdgeInsets.all(30),
          color: Get.theme.primaryColor,
          child: Center(
            child: Icon(Icons.supervised_user_circle_sharp, size: 80,).circle(backgroundColor: Vx.white,),
          ),
        ).h(Get.height / 10 * 2),
        Container(
          color: Vx.gray100,
          child: Center(
            child: VStack([
              "Numero de téléphone".text.make().centered(),
              10.heightBox,
              Obx(() => "${controller.contact}".text.make().centered()),
              10.heightBox,
              GFButton(
                elevation: 0,
                type: GFButtonType.outline,
                borderSide: BorderSide(color: Vx.black),
                color: Get.theme.primaryColor,
                onPressed: ()=>{},
                child: "Modifier mon numero de téléphone".text.bold.make(),
              ).centered(),

            ], alignment: MainAxisAlignment.center,),
          ),
        ).h(Get.height / 10 * 3).expand(flex: 1),

        20.heightBox,

        getContactCard(),
        10.heightBox,
        "Copyright 2023 Tous droits reservé".text.size(7).color(Vx.gray500).make().centered(),
        10.heightBox,

        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: HStack(
            [
              Image.asset("images/amoirie.png").h(30),
              Image.asset("images/group.png").h(30)
            ],
            alignment: MainAxisAlignment.spaceBetween,
          ).w(double.maxFinite),
        ),

      ]),
    );
  }

  Widget getContactCard(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: VStack([
        Icon(Icons.phone, size: 50, ),
        35.widthBox,
        "+225 0000000".text.make(),
        "info@c-moinscger.ci".text.make(),
        "c-moinscher.ci".text.make(),
      ], alignment: MainAxisAlignment.center, crossAlignment: CrossAxisAlignment.center,).w(double.maxFinite),
    );
  }
}
