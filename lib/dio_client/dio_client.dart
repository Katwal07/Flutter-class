import 'dart:developer';

import 'package:digital_pathshala_batch/local_storage/get_storage.dart';
import 'package:digital_pathshala_batch/model/login_model.dart';
import 'package:digital_pathshala_batch/model/product_model.dart';
import 'package:digital_pathshala_batch/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        // baseUrl: "https://api.escuelajs.co/api/v1/",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'multipart/form-data'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final accessToken = TokenStorage.getAccessToken;
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          print("The response is: ${response.data}");
          handler.next(response);
        },
        onError: (error, handler) {
          print("The error is: $error");
          handler.next(error);
        },
      ),
    );
  }

  Future<void> createUser(UserModel model) async {
    try {
      await dio.post("/users/", data: model.toMap());
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> loginUser(LoginModel model) async {
    try {
      final response = await dio.post("auth/login", data: model.toMap());
      return response.data;
    } on DioException catch (e) {
      throw Exception("Login Failed: ${e.message}");
    }
  }

  /// Get Product
  Future<List<ProductModel>> getProduct() async {
    final response = await dio.get('products');
    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await dio.get('products/$id');
    return ProductModel.fromJson(response.data);
  }

  /// Named Parameters
  Future<List<ProductModel>> getProductByPagination({
    required int offset,
    required int limit,
  }) async {
    try {
      print("I am called");
      final response = await dio.get(
        'products',
        queryParameters: {'offset': offset, 'limit': limit},
      );
      print("The response is: $response");

      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception("Login Failed: ${e.message}");
    }
  }

  /// Positional Positional
  Future<List<ProductModel>> searchProductByTitle({
    required String title,
  }) async {
    try {
      final response = await dio.get(
        'products',
        queryParameters: {"title": title},
      );

      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception("Filtering Failed: ${e.toString()}");
    }
  }

  /// Create Product
  Future<ProductModel> createProduct(
    Map<String, dynamic> body,
    XFile image,
  ) async {
    final formData = FormData.fromMap({
      "title": "New Productfeayhsbhafjkdsc",
      "price": 10,
      "description": "A description",
      "categoryId": 1,
      "images": [image.name],
    });
    log("The body is: $body");
    final response = await dio.post(
      'https://api.escuelajs.co/api/v1/products/',
      data: formData,
    );

    return ProductModel.fromJson(response.data);
  }

  /// Delete Product
  Future<bool> deleteProduct({required int id}) async {
    final response = await dio.delete("products/$id");

    return response.statusCode == 200;
  }
}
