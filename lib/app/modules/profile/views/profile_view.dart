import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: VStack([
        Container(
          height: MediaQuery.of(context).size.height / 10 * 2,
          padding: EdgeInsets.all(30),
          color: Get.theme.primaryColor,
          child: Center(
            child: Icon(Icons.supervised_user_circle_sharp, size: 80, color: Get.theme.primaryColor).circle(backgroundColor: Vx.white,),
          ),
        ).card.make(),
        Container(
          color: Vx.gray100,
          child: VStack([
            ListTile(
              leading: LineIcon.phone(),
              title: Obx(()=>"${controller.contact}".text.make()),
              subtitle: "Numero de téléphone".text.make(),
              trailing:  LineIcon.edit(
                color: Vx.white,
              ).p(5).cornerRadius(7)
                  .backgroundColor(Get.theme.primaryColor)
                  .onTap(()=> Get.defaultDialog(
                  title: "Modifier mon contact",
                  titleStyle: TextStyle(fontSize: 19),
                  textConfirm: "Enregistrer",
                  content: updateContactWidget(),
                  onConfirm: (){controller.updateContact(); Get.back();}
              )
              ).card.make(),
            ).backgroundColor(Colors.white),
            /*
            ListTile(
              leading: LineIcon.locationArrow(),
              title: Obx(()=>"${controller.ville}".text.make()),
              subtitle: "Ville".text.make(),
              trailing: const LineIcon.edit(
                color: Vx.white,
              ).p(5).cornerRadius(7)
                  .backgroundColor(Get.theme.primaryColor)
                  .onTap(()=> Get.defaultDialog(
                  title: "Modifier la ville",
                  titleStyle: TextStyle(fontSize: 19),
                  textConfirm: "Enregistrer",
                  content: updateVilleWidget(),
                  onConfirm: (){ Get.back();}
              )
              ).card.make(),
            ).backgroundColor(Colors.white),
            */


          ], ),
        ).h(MediaQuery.of(context).size.height / 10 * 3).expand(flex: 1),

        20.heightBox,

        getContactCard(),
        10.heightBox,
        "Copyright ${DateTime.now().year} Tous droits reservé".text.size(7).color(Vx.gray500).make().centered(),
        10.heightBox,

        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: HStack(
            [
              Image.asset("images/amoirie.jpg").h(30),
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
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: VStack([
        Icon(Icons.phone, size: 50, ),
        35.widthBox,
        "1343".text.white.make().p(3).card.elevation(0).green700.make(),
        "info@c-moinscher.ci".text.make(),
        "c-moinscher.ci".text.make(),
      ], alignment: MainAxisAlignment.center, crossAlignment: CrossAxisAlignment.center,).w(double.maxFinite),
    );
  }

  Widget updateContactWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Form(
        child: VStack([
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: controller.contactCtrl,
            decoration: InputDecoration(
                hintText: "Entrez votre contact"
            ),
          ),

        ], crossAlignment: CrossAxisAlignment.center,),
      ),
    );
  }

  Widget updateVilleWidget(){
    return Obx(() => FormBuilderDropdown<String>(
      name: 'villes',
      onChanged: (String? value)=>{ controller.updateVille(value)},
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
    ));
  }
}
