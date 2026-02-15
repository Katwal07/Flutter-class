import 'package:digital_pathshala_batch/screen/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: SplashImage(image: 'assets/city_image.png')),
          Center(child: SplashImage(image: 'assets/city.png')),
        ],
      ),
    );
  }
}

class SplashImage extends StatelessWidget {
  final String image;
  const SplashImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset(image, width: 200, height: 200),

        CircularProgressIndicator(strokeWidth: 10),
      ],
    );
  }
}
