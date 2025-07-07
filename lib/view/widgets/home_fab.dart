// lib/view/widgets/home_fab.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../add_edit_todo/add_edit_todo.dart';
import '../../utils/colors.dart' show AppColors;

class HomeFAB extends StatelessWidget {
  const HomeFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.to(() => const AddEditTodoScreen()),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Create", style: TextStyle(color: AppColors.onSurface)),
          AppSpacing.width(0.02),
          const Icon(Icons.add, color: AppColors.onSurface),
        ],
      ),
    );
  }
}
