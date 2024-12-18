import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../data/core_provider.dart';

class CategorieController extends GetxController {

  final categories = [].obs;
  final load = false.obs;
  final  image1 = "images/amoirie.png".obs;
  final  image2 = Image.asset("images/group.png").obs;


  void fetchCategories({int? id}){
    CoreProvider().getCategories().then((value){
      if(value.statusCode! == 200){
        Logger().d(value.body);
        categories.value = value.body!["categories"];
      }else{

      }
    });
  }



  @override
  void onInit() {
    super.onInit();
    fetchCategories();

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

}
