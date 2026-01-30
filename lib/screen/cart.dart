import 'package:digital_pathshala_batch/controller/create_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CreateProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                labelText: "Product Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.priceController,
              decoration: const InputDecoration(
                labelText: "Product Price",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.descController,
              decoration: const InputDecoration(
                labelText: "Product Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            Obx(() {
              return Column(
                children: [
                  GestureDetector(
                    onTap: controller.pickPick,
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: controller.selectedImage.value == null
                          ? const Center(child: Text('Select the image'))
                          : ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              child: Image.file(
                                controller.selectedImage.value!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 10),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.createProduct,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Text("Create Product"),
                ),
              ),
            ),

            Obx(() {
              if (controller.product.value == null) return const SizedBox();

              final product = controller.product.value!;

              return Card(
                elevation: 2,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Image.network(
                      product!.images != null && product.images.isNotEmpty
                          ? product!.images.first
                          : 'https://placehold.co/600x400',
                    ),
                  ),
                  title: Text(product.title ?? 'No Title'),
                  subtitle: Text(product.price.toString()),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
