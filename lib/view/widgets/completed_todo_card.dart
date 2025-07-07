import 'package:flutter/material.dart';

class CompletedTodoCard extends StatelessWidget {
  final Color backgroundColor;
  final bool checkboxValue;
  final ValueChanged<bool?> onChanged;
  final String title;
  final String subtitle;
  final TextDecoration? titleDecoration;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const CompletedTodoCard({
    super.key,
    required this.backgroundColor,
    required this.checkboxValue,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    required this.onEditTap,
    required this.onDeleteTap,
    this.titleDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Checkbox(
          value: checkboxValue,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          activeColor: Colors.white,
          checkColor: Colors.green,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: titleDecoration,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
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
