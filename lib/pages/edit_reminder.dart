import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remynder/models/reminder_model.dart';

Future<ReminderModel?> showEditReminderBottomSheet(BuildContext context, String initTitle, DateTime initDate) {
  final titleController = TextEditingController(text: initTitle);
  DateTime selectedDate = DateTime(initDate.year, initDate.month, initDate.day);
  TimeOfDay selectedTime = TimeOfDay(hour: initDate.hour, minute: initDate.minute);

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
                      DateFormat('yyyy-MM-dd').format(selectedDate)
                    ),
                    onTap: () async {
                      final now = selectedDate;
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: now,
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
                      selectedTime.format(ctx)
                    ),
                    onTap: () async {
                      final now = selectedTime;
                      final picked = await showTimePicker(
                        context: ctx,
                        initialTime: now,
                      );
                      if (picked != null) {
                        setState(() => selectedTime = picked);
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      final date = selectedDate;
                      final time = selectedTime;
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
                    child: Text('Edit Reminder'),
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