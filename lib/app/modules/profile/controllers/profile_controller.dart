import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:groci/app/data/core_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {

  final TextEditingController contactCtrl = TextEditingController();
  final TextEditingController villeCtrl = TextEditingController();
  final CoreProvider coreProvider = CoreProvider();
  var contact = "".obs;
  var ville = "Toutes les villes".obs;
  var villes = [].obs;

  @override
  void onInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    contact(prefs.getString("CONTACT") ?? "");
    contactCtrl.value = TextEditingValue(text: contact.value);

    ville(prefs.getString("VILLE") ?? "");
    getVilles();
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

  void updateContact() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    contact(contactCtrl.value.text);
    prefs.setString('CONTACT', contact.value);
    Get.snackbar("Contact enregistrer", "");
    Get.back(closeOverlays: false);
  }

  void updateVille(String? newVille) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ville(newVille);
    prefs.setString('VILLE', newVille ?? "Toutes les villes");
  }

  void getVilles() async{
    await CoreProvider().getVilles().then((value) {
      if (value.statusCode! != 200) {
      } else {
        villes(value.body!["villes"]);
        villes().insert(0, "Toutes les villes");
      }
    });
  }
}
