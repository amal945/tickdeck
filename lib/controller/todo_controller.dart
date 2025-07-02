import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_widgets/custom_snackbar.dart';

class TodoController extends GetxController {
  final String? todoId;

  TodoController(this.todoId);

  RxBool isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDate = Rxn<DateTime>();

  String get dueDateText {
    if (dueDate.value == null) return "Select due date";
    return "${dueDate.value!.day}/${dueDate.value!.month}/${dueDate.value!.year}";
  }

  @override
  void onInit() {
    super.onInit();
    if (todoId != null) {
      fetchTodoData();
    }
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> fetchTodoData() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('todos')
          .doc(todoId)
          .get();
      if (doc.exists) {
        titleController.text = doc['title'];
        descriptionController.text = doc['description'];
        if (doc['dueDate'] != null) {
          dueDate.value = (doc['dueDate'] as Timestamp).toDate();
        }
      }
    } catch (e) {
      showCustomSnackBar(title: "Error", message: "$e", color: Colors.red);
    }
  }

  Future<void> saveTodo() async {
    final user = _auth.currentUser;
    if (user == null) {
      showCustomSnackBar(
        title: "Failed",
        message: "Please Login Again",
        color: Colors.red,
      );
      return;
    }

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      showCustomSnackBar(
        title: "Error",
        message: "Title and Description cannot be empty!",
        color: Colors.red,
      );
      return;
    }

    if (dueDate.value == null) {
      showCustomSnackBar(
        title: "Error",
        message: "Please select a due date!",
        color: Colors.red,
      );
      return;
    }

    toggleLoading();

    try {
      final data = {
        'title': title,
        'description': description,
        'dueDate': Timestamp.fromDate(dueDate.value!),
        'ownerId': user.uid,
        'isCompleted': false,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (todoId == null) {
        // Add
        data['createdAt'] = FieldValue.serverTimestamp();
        await _firestore.collection('todos').add(data);
      } else {
        // Edit
        await _firestore.collection('todos').doc(todoId).update(data);
      }

      titleController.clear();
      descriptionController.clear();
      dueDate.value = null;

      Navigator.pop(Get.context!);
    } catch (e) {
      showCustomSnackBar(title: "Error", message: "$e", color: Colors.red);
    }

    toggleLoading();
  }
}
