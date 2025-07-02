import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar({required String title, required String message, required Color color}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM, // Shows at the bottom
    backgroundColor: color,
    colorText: Colors.white,
    margin: const EdgeInsets.all(10),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.info, color: Colors.white),
  );
}