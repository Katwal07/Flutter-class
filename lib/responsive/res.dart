import 'dart:developer';

import 'package:flutter/material.dart';

class Responsive {
  static double deviceHeight = 0.0;
  static double deviceWidth = 0.0;
  static void init(BuildContext context) {
    deviceHeight = MediaQuery.sizeOf(context).height / 100;
    deviceWidth = MediaQuery.sizeOf(context).width / 100;

    log("The screen height is: $deviceHeight");
    log("The screen width is $deviceWidth");
  }
}
