import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tickdeck/utils/custom_widgets/delete_confirm_dialogue_box.dart';

import '../models/todo_model.dart';
import '../utils/custom_widgets/custom_snackbar.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  RxList<TodoModel> todos = <TodoModel>[].obs;
  RxInt pending = 0.obs;
  RxInt completed = 0.obs;

  Stream<QuerySnapshot> get todosStream => _firestore
      .collection('todos')
      .where('ownerId', isEqualTo: user?.uid)
      .snapshots();

  @override
  void onInit() {
    super.onInit();
    _initTodoListener();
  }

  void _initTodoListener() {
    todosStream.listen((snapshot) {
      final allTodos = snapshot.docs
          .map((doc) => TodoModel.fromDoc(doc))
          .toList();

      todos.value = allTodos;
      completed.value = allTodos.where((t) => t.isCompleted).length;
      pending.value = allTodos.where((t) => !t.isCompleted).length;
    });
  }

  Future<void> deleteTodo(String id) async {
    showDeleteConfirmationDialog(
      Get.context!,
      onDelete: () async {
        try {
          await _firestore.collection('todos').doc(id).delete();
          showCustomSnackBar(
            title: "Success",
            message: "Todo deleted successfully",
            color: Colors.green,
          );
        } catch (e) {
          showCustomSnackBar(
            title: "Error",
            message: "Failed to delete todo: $e",
            color: Colors.red,
          );
        }
      },
      message: "Are you sure you want to delete this todo",
    );
  }

  Future<void> toggleCompletion(String id, bool value) async {
    await _firestore.collection('todos').doc(id).update({'isCompleted': value});
  }
}
