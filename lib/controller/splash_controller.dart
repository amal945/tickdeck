import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/auth/login.dart';
import '../view/home/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await initialNavigation();
    super.onInit();
  }

  Future<void> initialNavigation() async {
    final user = FirebaseAuth.instance.currentUser;

    Future.delayed(Duration(seconds: 2)).then((_) {
      if(user != null){
        Get.offUntil(
          MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false, // Removes all previous routes from the stack
        );

      }else{
        Get.off(()=>LoginScreen());
      }
    });
  }
}