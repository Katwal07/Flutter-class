import 'dart:developer';

import 'package:digital_pathshala_batch/dio_client/dio_client.dart';
import 'package:digital_pathshala_batch/model/product_model.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();
  // Inital Loading..
  var isLoading = false.obs;
  // Overall Product
  var product = <ProductModel>[].obs;

  var productDesc = Rxn<ProductModel>();
  var isProductDesc = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      product.value = await _apiService.getProduct();
    } catch (e) {
      log(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductDetails(int id) async {
    try {
      isProductDesc(true);
      productDesc.value = await _apiService.getProductById(id);
    } catch (e) {
      isProductDesc(false);
      log(e.toString());
    } finally {
      isProductDesc(false);
    }
  }
}
