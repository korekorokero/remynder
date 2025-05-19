import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remynder/models/reminder_model.dart';

Future<ReminderModel?> showAddReminderBottomSheet(BuildContext context) {
  final titleController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 32.0,
              bottom: 32.0 + MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  SizedBox(height: 20.0),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text(
                      selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : 'Tap to choose a date',
                    ),
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: selectedDate ?? now,
                        firstDate: DateTime(now.year - 1),
                        lastDate: DateTime(now.year + 5),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text(
                      selectedTime != null ? selectedTime!.format(ctx) : 'Tap to choose a time',
                    ),
                    onTap: () async {
                      final now = TimeOfDay.now();
                      final picked = await showTimePicker(
                        context: ctx,
                        initialTime: selectedTime ?? now,
                      );
                      if (picked != null) {
                        setState(() => selectedTime = picked);
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      final date = selectedDate ?? DateTime.now();
                      final time = selectedTime ?? TimeOfDay.now();
                      final combinedDateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
          
                      Navigator.pop(
                        ctx, 
                        ReminderModel(
                          title: titleController.text,
                          scheduledDate: combinedDateTime,
                        ),
                      );
                    },
                    child: Text('Add Reminder'),
                  ),
                ],
              ),
            ),
          );
        }
      );
    },
  );
}