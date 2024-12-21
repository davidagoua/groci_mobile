import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:groci/app/routes/app_pages.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZStack([
        BackgroundImage(context),
        VStack([
          50.heightBox,
          Container(child: Image.asset("images/logo_front.png").centered()),
          Container().expand(flex: 1),
          Container(
            child: VStack([
              "C'moins cher \nest un comparateur de prix"
                  .text
                  .bold
                  .size(18)
                  .white
                  .make()
                  .pSymmetric(h: 20, v: 10),
              "Pour: \n- Trouver où les produits sont moins cher \n- Faire des achat a moindre coûts \n- Maitriser son budget \n- Réaliser de bonne affaires"
                  .text
                  .white
                  .make()
                  .p(25),
              15.heightBox,
              HStack(
                [
                  "Suivant".text.white.make(),
                  10.widthBox,
                  Pulse(
                    infinite: true,
                    child: LineIcon.angleRight(
                      size: 30,
                      color: Vx.red500,
                    )
                        .circle(
                      backgroundColor: Vx.white,
                    )
                        .w(40)
                        .h(40)
                  )
                      .onTap(() { Get.offAllNamed(Routes.LOGIN); })
                ],
                alignment: MainAxisAlignment.end,
                crossAlignment: CrossAxisAlignment.center,
              ).w(double.maxFinite).pSymmetric(h: 30),

              10.heightBox,

              Container(
                color: Vx.white,
                child: HStack([
                  Image.asset("images/amoirie.png").h(40),
                  Image.asset("images/group.png").h(40),
                ], alignment: MainAxisAlignment.spaceAround,),
              ).w(double.maxFinite),

              7.heightBox,
              "Copyright 2023. Tous droits reservés".text.size(10).white.make().centered()
            ]),
          ).w(double.maxFinite)
        ])
      ]),
    );
  }



  Widget BackgroundImage(BuildContext context) => Image.asset(
    "images/splash_back.png",
    height: MediaQuery. of(context).size.height,
    width: MediaQuery.of(context).size.width
  );
}
