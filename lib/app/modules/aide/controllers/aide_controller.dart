import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AideController extends GetxController {

  var formKey = GlobalKey<FormBuilderState>();


  void validateForm(){
    formKey.currentState?.saveAndValidate();

    Get.snackbar("Message Envoyé", "Message envoyé, nous vous reviendrons dès que possible",
        backgroundColor: Vx.gray800, colorText: Vx.white);
  }

  @override
  void onInit() {
    super.onInit();
  }


}
