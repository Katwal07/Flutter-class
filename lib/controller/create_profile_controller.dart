import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import '../model/create_profile_model.dart';

class CreateProfileController extends GetxController {
  // --- State ---
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var errorMessage = "".obs;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.100.245:3000/api",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  /// Create profile API
  Future<void> createProfile(
    CreateProfileModel model, {
    String userId = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
  }) async {
    try {
      isLoading.value = true;
      isSuccess.value = false;
      errorMessage.value = "";

      // Prepare payload
      /// Content-type : Application/json
      final Map<String, dynamic> dataMap = {
        "id": "b30625e9-ac5e-4aeb-b864-5dd374330cca",
        "fullName": "rohankatwal55@gmail.com",
        "nickName": "Rohan",
        "dateOfBirth": "1990-01-01",
        "phoneNumber": "+977-9804979923",
        "gender": "MALE",
      };

      // Remove empty values
      dataMap.removeWhere((key, value) => value == null || value.isEmpty);

      dynamic payload;

      if (model.profileImage != null && model.profileImage!.isNotEmpty) {
        payload = FormData.fromMap({
          ...dataMap,
          'profileImage': await MultipartFile.fromFile(
            model.profileImage!,
            filename: model.profileImage!.split('/').last,
          ),
        });
        debugPrint("Sending as Multipart/FormData: $dataMap");
      } else {
        payload = dataMap;
        debugPrint("Sending as JSON: $dataMap");
      }

      // Make API request
      final response = await _dio.post(
        "/user/profile",
        data: payload,
        options: payload is FormData
            ? Options(contentType: 'multipart/form-data')
            : Options(contentType: 'application/json'),
      );

      debugPrint("Response: ${response.data}");
      isSuccess.value = true;
    } on DioException catch (e) {
      errorMessage.value = (e.response != null
          ? e.response?.data.toString() ?? e.message
          : e.message)!;
      debugPrint("Dio Error: ${errorMessage.value}");
      isSuccess.value = false;
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint("Unknown Error: $errorMessage");
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
