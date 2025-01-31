import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_network_status/network_status.dart';
import 'package:groci/app/data/core_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await initilizeProviders();

  bool initial = prefs.getBool('SHOW_ONBOARDING') ?? true;

  runApp(
    NetworkProvider(
      child: GetMaterialApp(
        title: "Cmoinscher",
        initialRoute: initial ? AppPages.INITIAL : AppPages.NEXT,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Vx.red500,
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.montserrat()
          )
        ),
      ),
    )
  );
}


Future<void> initilizeProviders() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(CoreProvider());
  Get.put(prefs, tag: 'prefs');
}