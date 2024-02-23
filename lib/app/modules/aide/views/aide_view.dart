import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/aide_controller.dart';

class AideView extends GetView<AideController> {
  const AideView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var inputBorder = OutlineInputBorder();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Aide'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Get.theme.primaryColor,
      ),
      body: VStack([
        25.heightBox,
        Container(
          child: "Contactez-nous".text.size(25).make().centered(),
        ).w(double.maxFinite).centered(),
        15.heightBox,
        Expanded(flex: 1, child: FormBuilder(
          key: controller.formKey,
          child: VStack([
            "Nom & Prénoms".text.make(),
            10.heightBox,
            FormBuilderTextField(
              name: "nom_prenoms",
              validator: (value)=> value == null || value.isEmpty ? "Champ requis" : null,
              decoration: InputDecoration(
                border: inputBorder
              ),
            ),

            20.heightBox,
            "Numero de téléphone".text.make(),
            10.heightBox,
            FormBuilderTextField(
              validator: (value)=> value!.isEmpty ? "Champ requis" : null,
              name: "telephone",
              decoration: InputDecoration(
                border: inputBorder
              ),
            ),

            20.heightBox,
            "Email".text.make(),
            10.heightBox,
            FormBuilderTextField(
              name: "email",
              decoration: InputDecoration(
                border: inputBorder
              ),
            ),

            20.heightBox,
            "Message".text.make(),
            10.heightBox,
            FormBuilderTextField(
              minLines: 5,
              maxLines: 7,
              name: "telephone",
              validator: (value)=> value!.isEmpty ? "Champ requis" : null,
              decoration: InputDecoration(
                border: inputBorder
              ),
            ),

            25.heightBox,

            GFButton(
              color: Get.theme.primaryColor,
              onPressed: controller.validateForm,
              size: GFSize.LARGE,
              text: "Envoyer",

              blockButton: true,
            ),

            25.heightBox,

            getContactCard(),

            10.heightBox,

            HStack(
              [
                Image.asset("images/amoirie.png").h(30),
                Image.asset("images/group.png").h(30)
              ],
              alignment: MainAxisAlignment.spaceBetween,
            ).w(double.maxFinite),
          ]).scrollVertical(),
        ).p(25)),
      ], alignment: MainAxisAlignment.center,).backgroundColor(Vx.white,),
    );
  }

  Widget getContactCard(){
    return Container(
      color: Vx.white,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: HStack([
        Icon(Icons.phone, size: 50, ),
        35.widthBox,
        VStack([
          "+225 0000000".text.make(),
          "info@c-moinscger.ci".text.make(),
          "c-moinscher.ci".text.make(),
        ])
      ]).w(double.maxFinite),
    );
  }
}
