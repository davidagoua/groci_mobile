import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../data/core_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CategorieController extends GetxController {

  final categories = [].obs;
  final load = false.obs;
  final  image1 = "images/amoirie.png".obs;
  final  image2 = Image.asset("images/group.png").obs;
  final ville = "Abidjan".obs;
  final villes = <String>[].obs;
  final SharedPreferences prefs = Get.find(tag: "prefs");


  void fetchCategories({int? id}){
    CoreProvider().getCategories().then((value){
      if(value.statusCode! == 200){
      
        categories.value = value.body!["categories"];
      }else{

      }
    });
  }

  void changeVille(String ville){
    prefs.setString("ville", ville);
    this.ville.value = ville;
  }


  @override
  void onInit() async {
    super.onInit();
    fetchCategories();
    ville.value = prefs.getString("ville") ?? "ABIDJAN";

    Future.delayed(const Duration(milliseconds: 100), ()=>{
      load.value = true
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<String>> getVilles(String? pattern) async {
    var response = await CoreProvider().getVilles();
    final responseVilles = response.body['villes'] as List<String>;
    return responseVilles.where((element) => element.toLowerCase().contains(pattern!.toLowerCase())).toList();
  }

}
