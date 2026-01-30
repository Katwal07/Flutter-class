import 'package:digital_pathshala_batch/controller/product_search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final ProductSearchController controller = Get.put(ProductSearchController());
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search by title...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              controller.search(value);
            },
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CupertinoActivityIndicator());
              }

              if (controller.products.isEmpty) {
                return const Center(child: Text('No product found'));
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                      controller.products[index].images.first,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.green,
                          child: Icon(Icons.image),
                        );
                      },
                    ),
                    title: Text(controller.products[index].title ?? 'No Title'),
                    subtitle: Text(
                      controller.products[index].description ??
                          'No Description',
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemCount: controller.products.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
