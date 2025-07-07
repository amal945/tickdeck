import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controller/todo_controller.dart';

class TodoSaveButton extends StatelessWidget {
  final TodoController controller;

  const TodoSaveButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:
        controller.isLoading.value ? null : () => controller.saveTodo(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: controller.isLoading.value
            ? LoadingAnimationWidget.progressiveDots(
          color: Colors.white,
          size: 50,
        )
            : const Text(
          "Save",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
