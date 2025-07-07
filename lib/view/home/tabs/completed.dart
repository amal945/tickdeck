// lib/view/screens/completed.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickdeck/view/widgets/completed_todo_card.dart';
import '../../../controller/home_controller.dart';
import '../../add_edit_todo/add_edit_todo.dart';
import '../../widgets/empty_widget.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final completedTodos = controller.todos
          .where((t) => t.isCompleted)
          .toList();

      if (completedTodos.isEmpty) {
        return const EmptyWidget();
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: completedTodos.length,
        itemBuilder: (_, index) {
          final todo = completedTodos[index];

          return CompletedTodoCard(
            backgroundColor: Colors.green.withOpacity(0.7),
            checkboxValue: true,
            onChanged: (value) => controller.toggleCompletion(todo.id, value!),
            title: todo.title,
            subtitle: todo.description,
            titleDecoration: TextDecoration.lineThrough,
            onEditTap: () => Get.to(() => AddEditTodoScreen(todoId: todo.id)),
            onDeleteTap: () {
              controller.deleteTodo(todo.id);
            },
          );
        },
      );
    });
  }
}
