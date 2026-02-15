import 'package:digital_pathshala_batch/controller/login_controller.dart';
import 'package:digital_pathshala_batch/screen/widget/custom_app_bar.dart';
import 'package:digital_pathshala_batch/screen/widget/custom_login_button.dart';
import 'package:digital_pathshala_batch/screen/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<LoginScreen> {
  final LoginController userController = Get.put(LoginController());
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final isPasswordVisible = false.obs;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: 'Login Screen'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please enter your details for login",
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              const SizedBox(height: 20),

              CustomTextField(
                controller: emailCtrl,
                label: "Email Address",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              Obx(
                () => CustomTextField(
                  obscureText: !isPasswordVisible.value,
                  isPassword: true,
                  controller: passwordCtrl,
                  label: "Password",
                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.emailAddress,
                  onSuffixIconTap: () =>
                      isPasswordVisible.value = !isPasswordVisible.value,
                ),
              ),

              const SizedBox(height: 30),

              Obx(
                () => CustomPrimaryButton(
                  label: "Login",
                  isLoading: userController.isLoading.value,
                  onTap: () {
                    userController.loginUser(
                      email: emailCtrl.text,
                      password: passwordCtrl.text,
                    );
                  },
                ),
              ),

              // TextFormField(
              //   controller: emailCtrl,
              //   decoration: InputDecoration(hintText: 'Enter your email'),
              // ),
              // TextFormField(
              //   controller: passwordCtrl,
              //   decoration: InputDecoration(hintText: 'Enter your password'),
              // ),
              // Obx(() {
              //   return ElevatedButton(
              //     onPressed: () {
              //       print(userController.isLoading.value);
              //       print(emailCtrl.text);
              //       print(passwordCtrl.text);
              // userController.loginUser(
              //   email: emailCtrl.text,
              //   password: passwordCtrl.text,
              // );
              //     },
              //     child: userController.isLoading.value == true
              //         ? CircularProgressIndicator()
              //         : Text('Login User'),
              //   );
              // }),
              const SizedBox(height: 20),
              const Center(
                child: Text("OR", style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 20),
              //// Google icon download garne.
              ///
              OutlinedButton.icon(
                onPressed: () => userController.loginWithGoogle(),
                label: Text("Continue with google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
