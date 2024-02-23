import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class BasketController extends GetxController {

  final commandes = <String, int>{}.obs;
  final CoreProvider coreProvider = CoreProvider();
  final boutiques = [].obs;


  @override
  void onInit() {
    super.onInit();
  }


  void updateBasket() async {
    final response = await coreProvider.getresume({'commandes': commandes});
    boutiques.value = response.body!['boutiques'];
  }

  void addCommande(int proposition_id, int quantite, {String? product_name}) async {
    if(quantite > 0){
      commandes[proposition_id.toString()] = quantite;
      Get.snackbar("$quantite x ${product_name ?? ""}", "Produit Ajouté" );
    }else{
      Get.snackbar("Oups !", "Veuillez préciser la quantité", backgroundColor: Vx.red100 );
    }
    updateBasket();
  }

  void clearCommande(){
    boutiques([]);
    commandes({});
    print("Boutique listener: ${boutiques.value.length}");
  }
}
