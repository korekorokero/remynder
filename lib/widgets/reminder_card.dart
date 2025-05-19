import 'package:flutter/material.dart';
import 'package:remynder/services/formatter.dart';

class ReminderCard extends StatelessWidget {
  final String content;
  final DateTime dueDate;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ReminderCard({
    super.key,
    required this.content,
    required this.dueDate,
    required this.onDelete,
    required this.onEdit,
  });

 @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              'Scheduled: ${formatDate(dueDate)}',
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Color(0xFF077A7D),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Color(0xFF06202B),
              onPressed: () async {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: const Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (shouldDelete == true) {
                  onDelete();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}