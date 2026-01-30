import 'package:digital_pathshala_batch/dio_client/dio_client.dart';
import 'package:digital_pathshala_batch/local_storage/get_storage.dart';
import 'package:digital_pathshala_batch/model/login_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();

  //2.
  var isLoading = false.obs;

  //3.
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      //4.
      isLoading.value = true;

      //5.
      final user = LoginModel(email: email, password: password);

      //6.
      final response = await _apiService.loginUser(user);

      TokenStorage.saveToken(accessToken: response['access_token']);

      print("The Saved token is: ${response['access_token']}");

      //7.
      isLoading.value = false;

      //8.
      print("Successfully create the user");
      Get.snackbar("Success", "User Created Successfully");
    } catch (e) {
      // 9.
      isLoading.value = false;
      Get.snackbar("Failure", "User creation failed, ${e.toString()}");
    }
  }
}
