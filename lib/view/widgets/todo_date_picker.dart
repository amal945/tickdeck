import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/todo_controller.dart';

class TodoDatePicker extends StatelessWidget {
  final TodoController controller;

  const TodoDatePicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark(),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          controller.dueDate.value = pickedDate;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.white70, size: 20),
            const SizedBox(width: 12),
            Text(
              controller.dueDateText,
              style: TextStyle(
                color: controller.dueDate.value == null
                    ? Colors.white54
                    : Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}