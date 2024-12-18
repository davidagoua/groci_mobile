import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:groci/app/routes/app_pages.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/basket_controller.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class HomeController extends GetxController {

  final index = 0.obs;
  final barcodeLoading = false.obs;
  BasketController basketController = Get.find<BasketController>();
  final core_provider = CoreProvider();

  void scanBarCode() async{


    // scanner le code barre
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Annuler",
        true,
        ScanMode.DEFAULT);
    barcodeLoading.value = true;

    // retrouver le le produit a partir de code barre
    if(barcodeScanRes != '-1'){

      var response =  await core_provider.getProducts(barcode: barcodeScanRes);

      if(! response.isOk){

      }else{
        List produits = response.body['produits'];

        if( produits.isEmpty){
          // show notification
          //VxToast.show(Get.context!, msg: "Article indisponible");
          Get.defaultDialog(title: "Produit Introuvable", radius: 10, content: "Désolé sur code barre ne correspond a aucun produit enrégistré !".text.center.make() );
        }else{
          Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {"product": produits[0]});
        }
      }
    }
    barcodeLoading.value = false;
  }
  
  @override
  void onInit() {
    super.onInit();
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
