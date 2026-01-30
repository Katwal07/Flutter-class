import 'package:digital_pathshala_batch/dio_client/dio_client.dart';
import 'package:digital_pathshala_batch/model/product_model.dart';
import 'package:get/get.dart';

class ProductSearchController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = false.obs;

  var products = <ProductModel>[].obs;

  Future<void> search(String title) async {
    if (title.isEmpty) return;
    try {
      isLoading(true);

      final result = await _apiService.searchProductByTitle(title: title);

      products.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
