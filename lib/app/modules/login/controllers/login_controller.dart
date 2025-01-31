import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:groci/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final contactCtl = TextEditingController();
  final ville = "".obs;
  

  void validate() {
    if (formKey.currentState!.validate()) {
      login();
    } else {}
  }

  Future<void> changeVille(String ville) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ville", ville);
    this.ville.value = ville;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("SHOW_ONBOARDING", false);
    prefs.setString("CONTACT", contactCtl.value.text);
    Get.offAllNamed(Routes.HOME);
  }
}
