import 'package:digital_pathshala_batch/dio_client/dio_client.dart';
import 'package:digital_pathshala_batch/model/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  //1.
  final ApiService _apiService = ApiService();

  //2.
  var isLoading = false.obs;

  //3.
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String avatar,
  }) async {
    try {
      //4.
      isLoading.value = true;

      //5.
      final user = UserModel(
        name: name,
        email: email,
        password: password,
        avatar: avatar,
      );

      //6.
      await _apiService.createUser(user);

      //7.
      isLoading.value = false;

      //8.
      print("Successfully create the user");
      Get.snackbar("Success", "User Created Successfully");
    } catch (e) {
      // 9.
      isLoading.value = false;
      Get.snackbar("Failure", "User creation failed");
    }
  }
}
