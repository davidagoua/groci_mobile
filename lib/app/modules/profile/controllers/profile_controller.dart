import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  var contact = "".obs;

  @override
  void onInit() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     contact(prefs.getString("CONTACT") ?? "");
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

  void increment() => count.value++;
}
