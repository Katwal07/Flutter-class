import 'package:digital_pathshala_batch/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ProductDescriptionScreen extends StatefulWidget {
  final int productId;
  const ProductDescriptionScreen({super.key, required this.productId});

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    controller.fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Image.network('src'), Text('title'), Text('description')],
      ),
    );
  }
}
