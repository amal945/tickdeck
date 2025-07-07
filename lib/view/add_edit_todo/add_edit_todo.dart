import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/todo_controller.dart';
import '../../utils/colors.dart';
import '../widgets/todo_date_picker.dart';
import '../widgets/todo_text_field.dart';
import '../widgets/todo_save_button.dart';

class AddEditTodoScreen extends StatelessWidget {
  final String? todoId;

  const AddEditTodoScreen({super.key, this.todoId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoController(todoId));
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          controller.todoId == null ? "Add TODO" : "Edit TODO",
          style: const TextStyle(color: AppColors.onSurface),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TodoTextField(
              controller: controller.titleController,
              labelText: "Task Title",
            ),
            const SizedBox(height: 12),
            TodoTextField(
              controller: controller.descriptionController,
              labelText: "Task Description",
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TodoDatePicker(controller: controller),
            const SizedBox(height: 20),
            TodoSaveButton(controller: controller),
          ],
        ),
      ),
    );
  }
}