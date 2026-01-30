import 'dart:io';

import 'package:digital_pathshala_batch/dio_client/dio_client.dart';
import 'package:digital_pathshala_batch/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProductController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var product = Rxn<ProductModel>();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  var selectedImage = Rxn<File>();

  var isDeleteProductLoading = false.obs;

  XFile? myImage;

  Future pickPick() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    myImage = image;

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> createProduct() async {
    try {
      isLoading(true);

      final imageUrl = selectedImage.value;

      final body = {
        "title": titleController.text,
        "price": int.tryParse(priceController.text),
        "description": descController.text,
        "categoryId": 2,
        "images": [imageUrl],
      };

      /// title -> slug
      /// so title must be unique.....

      // final body = {
      //   "title": "Title",
      //   "price": 100,
      //   "description": "description",
      //   "categoryId": 1,
      //   "images": ["https://placehold.co/600x400"],
      // };

      final result = await _apiService.createProduct(body, myImage!);
      product.value = result;

      Get.snackbar(
        "Success",
        " Product Created Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Failure", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteproduct(int id) async {
    try {
      isLoading.value = true;

      final result = await _apiService.deleteProduct(id: id);
      // result -> true | false
      // if(result)-> if(true) | if(!result) -> if(false)

      if (result) {
        product.value = null;
        Get.snackbar("Success", "Product Deleted Successfully");
      } else {
        Get.snackbar("Failure", "Failed to delete product");
      }
    } catch (e) {
      Get.snackbar("Failure", e.toString());
    } finally {
      isDeleteProductLoading.value = false;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }
}
