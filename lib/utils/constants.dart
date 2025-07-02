import 'package:flutter/material.dart';
import 'app_dimensions.dart';
class AppSpacing {
  static SizedBox height(double value) => SizedBox(height: AppDimensions.screenHeight * value);
  static SizedBox width(double value) => SizedBox(width: AppDimensions.screenWidth * value);
}


final shadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 2,
    blurRadius: 4,
    offset: const Offset(0, 0),
  ),
];