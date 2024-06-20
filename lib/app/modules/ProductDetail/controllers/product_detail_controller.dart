import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groci/app/controllers/basket_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/core_provider.dart';

class ProductDetailController extends GetxController {
  //TODO: Implement ProductDetailController

  final count = 1.obs;
  dynamic product = {};
  final proposition_loading = false.obs;
  final propositions = [].obs;
  final BasketController basketController = Get.find<BasketController>();

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments["product"];

    fetchPropositions();
  }

  void fetchPropositions(){
    proposition_loading.toggle();
    CoreProvider().getPropositions(product['id']).then((value)  {
      if(value.statusCode! != 200){
      }else{
        propositions(value.body!["propositions"]);
      }
      proposition_loading.toggle();
    });

  }

  void addCommandeToBacket(int proposition_id){
    basketController.addCommande(proposition_id, count.value, product_name: product['nom']);
  }
}
