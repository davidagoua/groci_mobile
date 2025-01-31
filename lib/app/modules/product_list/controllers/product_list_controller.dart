import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


final logger = Logger();


class ProductListController extends GetxController {

  final categorie = {}.obs;
  final loading = false.obs;
  final products = [].obs;
  final villes = <String>[].obs;
  final SharedPreferences prefs = Get.find(tag: "prefs");
  final search = "".obs;
  final ville = "".obs;

  get productsFiltered => products
      .where((element) => element["nom"]
          .toString()
          .toLowerCase()
          .contains(search.value.toLowerCase()))
      .toList();

  @override
  void onInit() {
    super.onInit();
    ville.value = prefs.getString("ville") ?? "ABIDJAN";
    fetchVilles();
    fetchProducts();
  }

  void onSous2CategorieSelect(Map<String, dynamic> c) async {
    await fetchProducts(sous_sous_categorie_id: c['id']);
  }

  Future<void> fetchProducts({int? sous_sous_categorie_id}) async {
    loading.value = true;
    products.value = [];
    await CoreProvider()
        .getProducts(
            search: search.value,
            sous_sous_categorie_id: sous_sous_categorie_id)
        .then((value) {
      if (value.statusCode! != 200) {
      } else {
        products(value.body!["produits"]);
      }
    });
    loading.value = false;
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

  void changeVille(String ville) {
    prefs.setString("ville", ville);
    this.ville.value = ville;
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
