import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:groci/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final contactCtl = TextEditingController();

  void validate(){
    if(formKey.currentState!.validate()){
      login();
    }else{

    }
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
