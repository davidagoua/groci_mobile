import 'package:get/get.dart';

import '../../../data/core_provider.dart';
import 'package:logger/logger.dart';


final logger = Logger();

class SearchController extends GetxController {

  final isLoading = false.obs;
  final searchResult = [].obs;
  final filter = ''.obs;

  @override
  void onInit() async{
    super.onInit();
    await fetchProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchProducts({String? searchQuery=""}) async {
    try{
      isLoading.value = true;
      searchResult.value = [];
      await CoreProvider()
        .getProducts(
          search: searchQuery,
        ).then((value) {
          if (value.statusCode! != 200) {
          } else {
            searchResult(value.body!["produits"]);
          }
        });
    }catch(e, s){
      logger.e(e, stackTrace: s);
    }finally{
      isLoading.value = false;
    }

  }

}
