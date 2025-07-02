import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_services.dart';
import '../utils/custom_widgets/custom_snackbar.dart';
import '../view/home/home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    if (!_validateInputs()) return;
    isLoading.value = true;
    try {
      await AuthService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;

      Get.off(() => HomeScreen());
      emailController.clear();
      passwordController.clear();

      Get.snackbar(
        "Success",
        "Logged In Successfully",
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = "Invalid email format. Please enter a valid email.";
          break;
        case 'user-disabled':
          errorMessage = "This account has been disabled. Contact support.";
          break;
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential': // Handling invalid credential error
          errorMessage = "Invalid email or password. Please try again.";
          break;
        case 'too-many-requests':
          errorMessage =
              "Too many failed attempts. Please try again later or reset your password.";
          break;
        case 'network-request-failed':
          errorMessage =
              "Network error! Please check your internet connection and try again.";
          break;
        case 'email-already-in-use':
          errorMessage =
              "This email is already registered. Try logging in instead.";
          break;
        case 'weak-password':
          errorMessage =
              "Password is too weak. Please use a stronger password.";
          break;
        case 'operation-not-allowed':
          errorMessage =
              "Email/password sign-in is disabled. Please contact support.";
          break;
        default:
          errorMessage = "An unexpected error occurred: ${e.message}";
      }

      showCustomSnackBar(
        title: "Error",
        message: errorMessage,
        color: Colors.red,
      );
    } catch (e) {
      isLoading.value = false;
      showCustomSnackBar(
        title: "Caught Exception",
        message: "$e",
        color: Colors.red,
      );
    }
  }

  bool _validateInputs() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Regular expression for stricter email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (email.isEmpty) {
      showCustomSnackBar(
        title: "Error",
        message: "Email cannot be empty!",
        color: Colors.red,
      );
      return false;
    }

    if (!GetUtils.isEmail(email) || !emailRegex.hasMatch(email)) {
      showCustomSnackBar(
        title: "Error",
        message: "Enter a valid email format!",
        color: Colors.red,
      );
      return false;
    }

    // Check if email has a valid domain
    String domain = email.split("@").last;
    if (!domain.contains(".")) {
      showCustomSnackBar(
        title: "Error",
        message: "Email domain is invalid!",
        color: Colors.red,
      );
      return false;
    }

    // Password validations
    if (password.isEmpty) {
      showCustomSnackBar(
        title: "Error",
        message: "Password cannot be empty!",
        color: Colors.red,
      );
      return false;
    }

    if (password.length < 6) {
      showCustomSnackBar(
        title: "Error",
        message: "Password must be at least 6 characters!",
        color: Colors.red,
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
