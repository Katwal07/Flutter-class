import 'dart:developer';

import 'package:digital_pathshala_batch/screen/onboard/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardScreen extends StatelessWidget {
  final OnboardController controller = Get.put(OnboardController());
  OnBoardScreen({super.key});

  final List<String> titles = [
    "Hello Everyone",
    "Welcome to my Channel",
    "Let's get Started",
  ];

  final List<String> subtitle = [
    "How are you doing today.",
    "And create beautiful memories",
    "Ok Let's move on.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Obx(
          () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(titles[controller.pageIndex.value]),
                SizedBox(height: 20),
                Text(subtitle[controller.pageIndex.value]),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    titles.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: controller.pageIndex.value == index ? 30 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: controller.pageIndex.value == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: controller.nextPage,
                  // onPressed: () {
                  //   log("I am tapped");
                  //   controller.nextPage();
                  // },
                  child: Text(
                    controller.pageIndex.value < titles.length - 1
                        ? "Next"
                        : "Start",
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
