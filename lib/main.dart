import 'package:digital_pathshala_batch/controller/create_product_controller.dart';
import 'package:digital_pathshala_batch/controller/pagination_product_con.dart';
import 'package:digital_pathshala_batch/responsive/res.dart';
import 'package:digital_pathshala_batch/router/app_pages.dart';
import 'package:digital_pathshala_batch/router/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Background Handler Setup.
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Get.put(PaginationProductCon());
  Get.put(CreateProductController());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      // home: const LoginScreen(),
    );
  }
}
