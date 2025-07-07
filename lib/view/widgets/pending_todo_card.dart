// lib/view/widgets/pending_todo_card.dart

import 'package:flutter/material.dart';

class PendingTodoCard extends StatelessWidget {
  final Color backgroundColor;
  final bool checkboxValue;
  final ValueChanged<bool?> onChanged;
  final String title;
  final String subtitle;
  final DateTime? dueDate;
  final bool isOverdue;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const PendingTodoCard({
    super.key,
    required this.backgroundColor,
    required this.checkboxValue,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    required this.dueDate,
    required this.isOverdue,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Checkbox(
          value: checkboxValue,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          activeColor: Colors.white,
          checkColor: Colors.green,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isOverdue)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Due",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70),
            ),
            if (dueDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Due: ${dueDate!.day}/${dueDate!.month}/${dueDate!.year}",
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onEditTap,
              child: Image.asset(
                'assets/images/edit_icon.png',
                width: 25,
                height: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onDeleteTap,
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
    );
  }
}