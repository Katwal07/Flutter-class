import 'package:digital_pathshala_batch/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final UserController userController = Get.put(UserController());
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final avtrlCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    avtrlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 10,
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(hintText: 'Enter your name'),
              ),
              TextFormField(
                controller: emailCtrl,
                decoration: InputDecoration(hintText: 'Enter your email'),
              ),
              TextFormField(
                controller: passwordCtrl,
                decoration: InputDecoration(hintText: 'Enter your password'),
              ),
              TextFormField(
                controller: avtrlCtrl,
                decoration: InputDecoration(hintText: 'Enter your avatar'),
              ),

              Obx(() {
                return ElevatedButton(
                  onPressed: () {
                    print(userController.isLoading.value);
                    print(nameCtrl.text);
                    print(emailCtrl.text);
                    print(passwordCtrl.text);
                    print(avtrlCtrl.text);
                    userController.registerUser(
                      name: nameCtrl.text,
                      email: emailCtrl.text,
                      password: passwordCtrl.text,
                      avatar: avtrlCtrl.text,
                    );
                  },
                  child: userController.isLoading.value == true
                      ? CircularProgressIndicator()
                      : Text('Create User'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
