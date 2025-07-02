import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController  {

  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> resetPassword() async {
    isLoading.value = (!isLoading.value);
    String email = emailController.text.trim();

    if (email.isEmpty) {
      isLoading.value = (!isLoading.value);
      Get.snackbar("Error", "Please enter your email",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      emailController.clear();
      Get.snackbar("Success", "Password reset link sent to $email",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      isLoading.value = (!isLoading.value);
      Future.delayed(Duration(seconds: 2)).then((_){
        Get.closeAllSnackbars();
        Get.back();
      });
    } catch (e) {
      isLoading.value = (!isLoading.value);
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

}