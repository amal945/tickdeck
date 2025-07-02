import 'dart:ui';

import 'package:get/get.dart';

class AppDimensions {
  static Size get screenSize =>Get.mediaQuery.size;
  static double get screenHeight => Get.mediaQuery.size.height;
  static double get screenWidth => Get.mediaQuery.size.width;
}