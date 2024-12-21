import 'package:logger/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class AcceuilController extends GetxController {
  final FocusNode searchFocus = FocusNode();
  final categories = [].obs;
  final products = [].obs;
  final query_ctl = TextEditingController();
  final search = "".obs;
  final selectedCategorie = <String, dynamic>{"nom":"Produits vivrier", "id":  1}.obs;
  final showCategorie = true.obs;
  final selectedVille = "".obs;

  final product_loading = false.obs;
  final formKey = GlobalKey<FormBuilderState>();
  final villes = <dynamic>[].obs;
  final animated = false.obs;

  final sousCategories = [].obs;
  final RxInt selectedSousCategorie = 0.obs;

  final sous2Categories = [].obs;
  final RxInt selectedSous2Categorie = 0.obs;

  final RxList<Categorie> allCategories = <Categorie>[].obs;

  final categorieLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();

    await fetchCategories();
    allCategories.value = await CoreProvider().getAllCategories();
    fetchProducts();
    fetchVilles();

    await fetchCategorieChildren(this.selectedCategorie.value["id"]);
    await fetchSous2Categories(selectedSousCategorie.value);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedVille(prefs.getString("VILLE"));

    /*
    searchFocus.addListener(() {
      if(searchFocus.hasFocus){
        showCategorie.value = false;
      }else{
        showCategorie.value = true;
      }
    });

     */
  }

  void fetchProducts({int? categorie_id = 5, int? sous_sous_categorie_id = null}) async {

    await CoreProvider()
        .getProducts(categorie: categorie_id, search: search.value, sous_sous_categorie_id: sous_sous_categorie_id)
        .then((value) {
      if (value.statusCode! != 200) {
      } else {
        products(value.body!["produits"]);
      }
    });
    product_loading.value = false;
    animated.toggle();
    selectedCategorie.value =
        categories.firstWhere((cat) => cat['id'] == categorie_id) ?? {"nom":"Toutes les categories", "id":  1};
  }

  void fetchVilles() async {
    await CoreProvider().getVilles().then((value) {
      if (value.statusCode! == 200) {
        villes(value.body!["villes"]);
        villes().insert(0, "Toutes les villes");
      } else {
        Logger().e(value);
      }
    });
  }

  Future<void> fetchCategories() async {
    final response = await CoreProvider().getCategories();

    if(response.statusCode! != 200){

    }else{
      categories.value = response.body!["categories"];
      selectedCategorie.value = categories.value[0];
    }

  }

  Future<void> fetchCategorieChildren(int categorie_id) async{
    //sousCategories.value = allCategories.value.where((element)=> element.parentId == categorie_id).toList();


    try{
      categorieLoading.value = true;
      final result = await CoreProvider()
          .getCategorieChildren(categorie_id);

      if(result.statusCode != 200){

      }else{
        sousCategories(result.body!['data']);
      }
    }catch(e,t){
      Logger().e(e);
    }finally{
      categorieLoading.value = false;
    }

  }

  Future<void> fetchSous2Categories(int id) async {

    sous2Categories.value = allCategories.value.where((element)=> element.parentId == id && element.generation == 3).toList();

    /*
    try{
      final result = await CoreProvider()
          .getCategorieChildren(id);
      if(result.statusCode != 200){

      }else{
        sous2Categories(result.body!['data']);
      }
    }catch(e){
      Get.snackbar('Erreur', "Desolé nous recontrons des difficultés actuellement");
    }
    */
  }

  void onSousCategorieSelect({int? categorie_id = 5}) async {
    selectedSousCategorie.value = categorie_id!;
    product_loading.value = true;
    Logger().d(sousCategories.value);
    fetchVilles();
    await fetchCategorieChildren(this.selectedCategorie.value["id"]);
    await fetchSous2Categories(categorie_id!);
    fetchProducts(categorie_id: categorie_id);
  }

  void onSous2CategorieSelect(int categorie_id) async {
    selectedSous2Categorie.value = categorie_id;
    fetchProducts(sous_sous_categorie_id: categorie_id);
  }

  void onCategorieSelect({int? categorie_id = null}) async {
    fetchProductsFromParentCategorie(categorie_id!);
    await fetchCategorieChildren(categorie_id!);
    sous2Categories.value = [];
  }

  Future<void> fetchProductsFromParentCategorie(int categorie_id) async {
    product_loading.value = true;
    await CoreProvider()
        .getProductsFromParentCategorie(categorie_id)
        .then((value) {
      if (value.statusCode! == 200) {
        products(value.body!["produits"]);
        Logger().d(value.body!["produits"]);
      } else {

      }
    });
    product_loading.value = false;
    animated.toggle();
    selectedCategorie.value =
        categories.firstWhere((cat) => cat['id'] == categorie_id) ?? {"nom":"Toutes les categories", "id":  1};
  }
}
