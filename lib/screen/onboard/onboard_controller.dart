import 'package:digital_pathshala_batch/router/app_routes.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  var pageIndex = 0.obs;

  void nextPage() {
    if (pageIndex.value < 2) {
      pageIndex.value++;
    } else {
      Get.offNamed(AppRoutes.home);
    }
  }
}
