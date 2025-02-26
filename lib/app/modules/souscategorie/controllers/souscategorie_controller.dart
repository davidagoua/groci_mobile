import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class SouscategorieController extends GetxController {
  //TODO: Implement SouscategorieController

  final loading = false.obs;
  final RxMap selectedCategorie = {}.obs;
  final sousCategories = <Map<String, dynamic>>[].obs;
  final coreProvider = Get.find<CoreProvider>();

  @override
  void onInit() {
    super.onInit();
    selectedCategorie.value = Get.arguments['categorie'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<Map<String, dynamic>>> fetchSousCategories() async {
    try {
      loading.value = true;
      var response =
          await coreProvider.getCategorieChildren(selectedCategorie['id']);

      if (response.statusCode == 200) {
        sousCategories.value = (response.body!['data'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
        logger.d(sousCategories);
        return sousCategories;
      } else {
        logger.e(response.body);

      }

      return [];
    } catch (e, s) {
      logger.e(e, stackTrace: s);
      rethrow;
    } finally {
        loading.value = false;
      }
    return [];
  }
}
