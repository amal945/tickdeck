import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_services.dart';
import '../utils/custom_widgets/custom_snackbar.dart';
import '../view/home/home_screen.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void register() async {
    if (!_validateInputs()) return;
    isLoading.value = true;
    try {
      await AuthService.signUp(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      fullNameController.clear();
      Get.off(() => HomeScreen());
      Get.snackbar(
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        "Success",
        "User Registered Successfully!",
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
    String fullName = fullNameController.text.trim();
    final RegExp nameRegex = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+)+$");
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (fullName.isEmpty || fullName.length < 4) {
      showCustomSnackBar(
        title: "Error",
        message: "Full Name cannot be empty !",
        color: Colors.red,
      );
      return false;
    }

    if (!nameRegex.hasMatch(fullName)) {
      showCustomSnackBar(
        title: "Error",
        message: "Enter a valid full name with at least two words!",
        color: Colors.red,
      );
      return false;
    }

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

    String domain = email.split("@").last;
    if (!domain.contains(".")) {
      showCustomSnackBar(
        title: "Error",
        message: "Email domain is invalid!",
        color: Colors.red,
      );
      return false;
    }

    if (password.isEmpty) {
      showCustomSnackBar(
        title: "Error",
        message: "Password cannot be empty!",
        color: Colors.red,
      );
      return false;
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      showCustomSnackBar(
        title: "Error",
        message: "Password field can't be empty!",
        color: Colors.red,
      );
      return false;
    }

    if (confirmPasswordController.text.trim() != password) {
      showCustomSnackBar(
        title: "Error",
        message: "Passwords Does not Match!",
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
    confirmPasswordController.dispose();
    super.onClose();
  }
}
