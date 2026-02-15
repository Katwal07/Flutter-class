import 'dart:developer';

import 'package:digital_pathshala_batch/dio_client/dio_client.dart';
import 'package:digital_pathshala_batch/local_storage/get_storage.dart';
import 'package:digital_pathshala_batch/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isContinueWithGoogleLoading = false.obs;

  Future<void> loginWithGoogle() async {
    try {
      isContinueWithGoogleLoading.value = true;

      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      if (googleUser != null) {
        final authDetails = googleUser.authentication;
        final String? idToken = authDetails.idToken;

        final List<String> scope = ['email', 'profile'];
        final auth = await googleUser.authorizationClient.authorizeScopes(
          scope,
        );

        final String accessToken = auth.accessToken;

        final credentials = GoogleAuthProvider.credential(
          accessToken: accessToken,
          idToken: idToken,
        );

        await _auth.signInWithCredential(credentials);
      } else {}
    } catch (e) {
      log("The error is: ${e.toString()}");
      Get.snackbar(
        "Login Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isContinueWithGoogleLoading.value = false;
    }
  }
}
