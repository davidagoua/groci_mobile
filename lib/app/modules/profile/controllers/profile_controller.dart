import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  final TextEditingController contactCtrl = TextEditingController();
  var contact = "".obs;

  @override
  void onInit() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     contact(prefs.getString("CONTACT") ?? "");
    super.onInit();
    contactCtrl.value = TextEditingValue(text: contact.value);
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

  void increment() => count.value++;
}
