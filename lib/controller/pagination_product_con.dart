import 'package:digital_pathshala_batch/dio_client/dio_client.dart';
import 'package:digital_pathshala_batch/model/product_model.dart';
import 'package:flutter/rendering.dart';
import 'package:get/state_manager.dart';

class PaginationProductCon extends GetxController {
  final ApiService _apiService = ApiService();

  /// Inital Loading.
  var isLoading = false.obs;
  // Our list of prodcut.
  var product = <ProductModel>[].obs;
  // If limit exist and new product is fetching.
  var isMoreLoading = false.obs;
  // to check if we have to call our api next time or not.
  var hasMore = true.obs;

  int offset = 0;
  final int limit = 10;

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  Future<void> fetchProduct() async {
    /// true || true || false
    if (isLoading.value || isMoreLoading.value || !hasMore.value) return;
    try {
      if (offset == 0) {
        isLoading.value = true;
      } else {
        isMoreLoading.value = true;
      }

      final newProduct = await _apiService.getProductByPagination(
        offset: offset,
        limit: limit,
      );

      print("I am called inside controller");

      if (newProduct.isEmpty || newProduct.length < limit) {
        hasMore.value = false;
      }

      product.addAll(newProduct);
      offset += limit;
    } catch (e) {
      debugPrint("Error is: ${e.toString()}");
    } finally {
      isMoreLoading.value = false;
      isLoading.value = false;
    }
  }
}
