import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/custom_widgets/custom_snackbar.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  Stream<QuerySnapshot>? _todosStream;

  Stream<QuerySnapshot>? get todosStream => _todosStream;

  RxInt pending = 0.obs;

  RxInt completed = 0.obs;




  @override
  void onInit() {
    fetchTodos();
    super.onInit();
  }


  void fetchTodos() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _todosStream = FirebaseFirestore.instance
          .collection('todos')
          .where('ownerId', isEqualTo: user.uid)
          .snapshots();

      _todosStream?.listen((snapshot) {
        int p = 0;
        int c = 0;

        for (var doc in snapshot.docs) {
          final isCompleted = doc['isCompleted'] ?? false;
          if (isCompleted) {
            c++;
          } else {
            p++;
          }
        }

        pending.value = p;
        completed.value = c;
      });
    }
  }

  Future<void> deleteTodo({required String todoId}) async {
    try {
      await _firestore.collection('todos').doc(todoId).delete();
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
  }
}
