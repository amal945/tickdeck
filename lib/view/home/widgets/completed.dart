import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets/delete_confirm_dialogue_box.dart';
import '../../../utils/custom_widgets/list_tile_shimmer_widget.dart';
import '../../add_edit_todo/add_edit_todo.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    controller.fetchTodos();
    return StreamBuilder(
      stream: controller.todosStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildShimmer();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/clipboard.png"),
                AppSpacing.height(0.01),
                const Text(
                  "You don't have any tasks yet!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Start adding tasks and manage time effectively.",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          );
        }

        // Filter only completed tasks
        final completedTodos = snapshot.data!.docs
            .where((doc) => doc['isCompleted'] == true)
            .toList();

        if (completedTodos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/clipboard.png"),
                AppSpacing.height(0.01),
                const Text(
                  "You don't have any tasks yet!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Start adding tasks and manage time effectively.",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: completedTodos.length,
          itemBuilder: (context, index) {
            var todo = completedTodos[index];

            return Card(
              color: Colors.green.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // Add any action here if needed
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.6)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: true,
                      onChanged: (value) async {
                        await FirebaseFirestore.instance
                            .collection('todos')
                            .doc(todo.id)
                            .update({'isCompleted': value});
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      activeColor: Colors.white,
                      checkColor: Colors.green,
                    ),
                    title: Text(
                      todo['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    subtitle: Text(
                      todo['description'],
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AddEditTodoScreen(todoId: todo.id));
                          },
                          child: Image.asset(
                            'assets/images/edit_icon.png',
                            width: 25,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            showDeleteConfirmationDialog(
                              context,
                              onDelete: () {
                                controller.deleteTodo(todoId: todo.id);
                              },
                              message:
                                  "Are you sure you want to delete this todo",
                            );
                          },
                          child: Image.asset(
                            'assets/images/delete_icon.png',
                            width: 25,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
