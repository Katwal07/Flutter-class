import 'package:digital_pathshala_batch/router/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _naviagateToNext();
  }

  void _naviagateToNext() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(AppRoutes.onboard);
  }
}
