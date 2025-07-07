import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.dueDate,
  });

  factory TodoModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
    );
  }
}
