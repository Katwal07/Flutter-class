import 'package:digital_pathshala_batch/router/app_routes.dart';
import 'package:digital_pathshala_batch/screen/onboard/onboard_screen.dart';
import 'package:digital_pathshala_batch/screen/product.dart';
import 'package:digital_pathshala_batch/screen/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboard, page: () => OnBoardScreen()),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
  ];
}
