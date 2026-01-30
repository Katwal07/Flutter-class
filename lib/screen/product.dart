import 'package:digital_pathshala_batch/controller/product_controller.dart';
import 'package:digital_pathshala_batch/screen/product_desc_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

/// List of pages -> Screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController _productController = Get.put(ProductController());

  // @override
  // void initState() {
  //   super.initState();
  //   _productController.fetchProducts();
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_productController.isLoading.value) {
        return const Center(child: CupertinoActivityIndicator());
      }
      return ListView.builder(
        itemCount: _productController.product.length,
        itemBuilder: (context, index) {
          final product = _productController.product[index];
          return ListTile(
            leading: Image.network(
              product.images.first,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  child: Icon(Icons.image),
                );
              },
            ),
            title: Text(product.title ?? 'No Title'),
            subtitle: Text(product.description ?? 'No Description'),
            onTap: () =>
                Get.to(() => ProductDescriptionScreen(productId: product.id!)),
            trailing: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: Colors.green),
            ),
          );
        },
      );
    });
  }
}
