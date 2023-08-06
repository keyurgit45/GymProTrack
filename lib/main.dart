import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pacific_gym/consts/app_routes.dart';
import 'package:pacific_gym/models/product.dart';
import 'package:pacific_gym/services/firebase_auth_helper.dart';
import 'package:pacific_gym/views/pages/home_page.dart';
import 'package:pacific_gym/views/pages/landing_page.dart';

import 'controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<AuthController>(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}
