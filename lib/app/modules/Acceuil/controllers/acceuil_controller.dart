import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AcceuilController extends GetxController {
  final categories = [].obs;
  final products = [].obs;
  final query_ctl = TextEditingController();
  final search = "".obs;
  final selectedCategorie = <String, dynamic>{"nom":"Produits vivrier", "id":  1}.obs;

  final product_loading = false.obs;
  final formKey = GlobalKey<FormBuilderState>();
  final villes = <dynamic>[].obs;
  final animated = false.obs;

  @override
  void onInit() {
    super.onInit();
    CoreProvider().getCategories().then((value) => {
          if (value.statusCode! != 200)
            {}
          else
            {categories.value = value.body!["categories"]}
        });
    fetchProducts();
    fetchVilles();


  }

  void fetchProducts({int? categorie_id = 5}) async {
    product_loading.value = true;

    print("categorie: "+ selectedCategorie.value.toString());


    fetchVilles();
    await CoreProvider()
        .getroducts(categorie: categorie_id, search: search())
        .then((value) {
      if (value.statusCode! != 200) {
      } else {
        products(value.body!["produits"]);
      }
    });
    product_loading.value = false;
    animated.toggle();
    selectedCategorie.value =
        categories.firstWhere((cat) => cat['id'] == categorie_id) ?? {"nom":"Toutes les categories", "id":  null};

  }

  void fetchVilles() async {
    await CoreProvider().getVilles().then((value) {
      if (value.statusCode! != 200) {
      } else {
        villes(value.body!["villes"]);
        villes().insert(0, "Toutes les villes");
      }
    });
  }
}
