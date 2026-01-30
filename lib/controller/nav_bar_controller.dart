import 'package:get/get.dart';

class NavBarController extends GetxController {
  var index = 0.obs;

  void changeIndex(int i) {
    index.value = i;
  }
}

// index-> 0
// App Open -> HomeScreen (0)

// Supoose , Maile 1st index click (SearchScreen)
