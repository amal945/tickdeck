// lib/view/screens/pending.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickdeck/view/widgets/empty_widget.dart';
import 'package:tickdeck/view/widgets/pending_todo_card.dart';

import '../../../controller/home_controller.dart';
import '../../add_edit_todo/add_edit_todo.dart';

class Pending extends StatelessWidget {
  const Pending({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final todos = controller.todos.where((t) => !t.isCompleted).toList();

      if (todos.isEmpty) {
        return const EmptyWidget();
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: todos.length,
        itemBuilder: (_, index) {
          final todo = todos[index];
          final isOverdue =
              todo.dueDate != null && todo.dueDate!.isBefore(DateTime.now());

          return PendingTodoCard(
            backgroundColor: isOverdue
                ? Colors.red.withOpacity(0.7)
                : Colors.blue.withOpacity(0.7),
            checkboxValue: false,
            onChanged: (value) =>
                controller.toggleCompletion(todo.id, value!),
            title: todo.title,
            subtitle: todo.description,
            dueDate: todo.dueDate,
            isOverdue: isOverdue,
            onEditTap: () => Get.to(() => AddEditTodoScreen(todoId: todo.id)),
            onDeleteTap: () => controller.deleteTodo(todo.id),
          );
        },
      );
    });
  }
}
