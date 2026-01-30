import 'package:digital_pathshala_batch/controller/pagination_product_con.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class PaginationProductScreen extends StatefulWidget {
  const PaginationProductScreen({super.key});

  @override
  State<PaginationProductScreen> createState() =>
      _PaginationProductScreenState();
}

class _PaginationProductScreenState extends State<PaginationProductScreen> {
  final PaginationProductCon controller = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.fetchProduct();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Pagination")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: scrollController,
          itemCount:
              controller.product.length +
              (controller.isMoreLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.product.length) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Center(child: CupertinoActivityIndicator()),
              );
            }
            return ListTile(
              leading: Image.network(controller.product[index].images.first),
              title: Text(controller.product[index].title ?? 'No Title'),
              subtitle: Text(
                controller.product[index].description ?? 'No Description',
              ),
              trailing: Text("Rs. ${controller.product[index].price}"),
            );
          },
        );
      }),
    );
  }
}
