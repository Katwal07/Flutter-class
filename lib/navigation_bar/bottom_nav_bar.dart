import 'package:digital_pathshala_batch/screen/cart.dart';
import 'package:digital_pathshala_batch/screen/pagination_product_screen.dart';
import 'package:digital_pathshala_batch/screen/product.dart';
import 'package:digital_pathshala_batch/controller/nav_bar_controller.dart';
import 'package:digital_pathshala_batch/screen/profile.dart';
import 'package:digital_pathshala_batch/screen/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController userController = Get.put(NavBarController());
    final pages = [
      HomeScreen(),
      const PaginationProductScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: userController.index.value, children: pages),
        //body: pages[userController.index.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: userController.index.value,
          onTap: userController.changeIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.vaping_rooms),
              label: 'Products',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
