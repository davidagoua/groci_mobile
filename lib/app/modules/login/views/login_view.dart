import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../controllers/login_controller.dart';
import 'package:groci/utils/contants.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      body: VStack([
        Container(child: Image.asset("images/logo_front.png", height: 40,).centered())
            .backgroundColor(Get.theme.primaryColor).h(MediaQuery.of(context).size.height / 10 * 2),
        Container(

          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border(top: BorderSide(color: Get.theme.primaryColor))
          ),
          child: "Connexion".text.size(25).bold.white.make().p(10).centered(),
        ),
        Container(
          child: Form(
            key: controller.formKey,
            child: VStack([
              "Numero de téléphone".text.bold.make(),
              10.heightBox,
              TextFormField(
                controller: controller.contactCtl,
                keyboardType: TextInputType.phone,
                validator: (value)=> value == null || value.isEmpty ? "Champ requis" : null,
                decoration: const InputDecoration(
                    hintText: "Saisissez votre numero de téléphone",
                    hintStyle: TextStyle(color: Vx.gray500),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Vx.black, width: 2.0)),
                    focusColor: Vx.black
                ),
              ),
              15.heightBox,
              "Ville".text.bold.make(),
              10.heightBox,
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
              15.heightBox,

              GFButton(
                onPressed: controller.login,
                size: GFSize.LARGE,
                blockButton: true,
                color: Get.theme.primaryColor,
                text: "Valider",
              )
            ], alignment: MainAxisAlignment.center,).marginSymmetric(horizontal: 25, vertical: 20),
          ),
        ).expand(flex: 1),

        10.heightBox,

        Container(
          color: Vx.white,
          child: HStack([
            Image.asset("images/amoirie.png").h(40),
            Image.asset("images/group.png").h(40),
          ], alignment: MainAxisAlignment.spaceAround,),
        ).w(double.maxFinite),

        7.heightBox,
        "Copyright 2023. Tous droits reservés".text.size(10).white.make().p(3).centered().backgroundColor(Get.theme.primaryColor)
      ]),
    );
  }
}
