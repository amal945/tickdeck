import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controller/splash_controller.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: AppDimensions.screenHeight * 0.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/todo_logo.png"),
                ),
              ),
            ),
            LoadingAnimationWidget.progressiveDots(
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
