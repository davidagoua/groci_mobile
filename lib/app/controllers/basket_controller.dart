import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class BasketController extends GetxController {

  final commandes = <String, int>{}.obs;
  final CoreProvider coreProvider = CoreProvider();
  final boutiques = [].obs;
  final total = 0.obs;
  final oneLoading = false.obs;
  final showIndex = null;

  @override
  void onInit() {
    super.onInit();
  }


  void updateBasket() async {
    try {
      final response = await coreProvider.getResume({'commandes': commandes});
      boutiques.value = response.body?['boutiques'] ?? <dynamic>[];
      // calculer le total
      if(boutiques.value.isNotEmpty){
        total.value = boutiques.sumBy((p0) => p0['prix_total']);
      }else{
        total(0);
        commandes({});
      }

    }on Exception catch(e ){
        total.value = 0;
        boutiques.value = [];
    }

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
    total.value = 0;
  }

  void removeProposition(int proposition_id){
    this.oneLoading.value = true;
    commandes.remove(proposition_id.toString());
    updateBasket();
    this.oneLoading.value = false;
  }
}
