import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shop_resume_controller.dart';

class ShopResumeView extends GetView<ShopResumeController> {
  const ShopResumeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopResumeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShopResumeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
