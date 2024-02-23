import 'package:get/get.dart';

import '../../../data/core_provider.dart';

class CategorieController extends GetxController {

  final categories = [].obs;


  void fetchCategories({int? id}){
    CoreProvider().getCategories().then((value) =>{
      if(value.statusCode! != 200){

      }else{
        categories.value = value.body!["categories"]
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
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
