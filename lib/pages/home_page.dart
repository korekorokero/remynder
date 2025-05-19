import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remynder/models/reminder_model.dart';
import 'package:remynder/pages/add_reminder.dart';
import 'package:remynder/pages/edit_reminder.dart';
import 'package:remynder/services/notification_service.dart';
import 'package:remynder/services/reminder_service.dart';
import 'package:remynder/widgets/reminder_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  final _reminderService = ReminderService();
  List<ReminderModel> reminders = [];

  @override
  void initState() {
    super.initState();
    _fetchReminders();
  }

  Future<void> _fetchReminders() async {
    setState(() {
      _isLoading = true;
    });
    reminders = await _reminderService.readReminders();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEDD),
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
          children: [
            TextSpan(
              text: 'Re',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF7AE2CF),
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: 'My',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF06202B),
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextSpan(
              text: 'nder',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF7AE2CF),
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )),
        centerTitle: true,
        backgroundColor: Color(0xFF077A7D),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              return ReminderCard(
                content: reminders[index].title,
                dueDate: reminders[index].scheduledDate,
                onDelete: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  await _reminderService.deleteReminder(reminders[index].id);
                  await _fetchReminders();

                  setState(() {
                    _isLoading = false;
                  });
                },
                onEdit: () async {
                  final newReminder = await showEditReminderBottomSheet(context, reminders[index].title, reminders[index].scheduledDate);
                  if (newReminder != null) {
                    setState(() {
                      _isLoading = true;
                    });
                    final updatedReminder = ReminderModel(
                      id: reminders[index].id,
                      title: newReminder.title,
                      scheduledDate: newReminder.scheduledDate,
                    );

                    await _reminderService.updateReminder(updatedReminder);
                    await NotificationService.cancelNotification(id: updatedReminder.id);
                    await NotificationService.createNotification(
                      id: updatedReminder.id,
                      title: 'Reminder: ${updatedReminder.title}',
                      body: DateFormat('HH:mm - dd MMM yyyy').format(updatedReminder.scheduledDate),
                      scheduledDate: updatedReminder.scheduledDate,
                      scheduled: true,
                    );
                    await _fetchReminders();

                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              );
            }
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7AE2CF),
        onPressed: () async {
          final reminder = await showAddReminderBottomSheet(context);
          if (reminder != null) {
            setState(() {
              _isLoading = true;
            });

            final reminderId = await _reminderService.addReminder(reminder);
            await NotificationService.createNotification(
              id: reminderId,
              title: 'Reminder: ${reminder.title}',
              body: DateFormat('HH:mm - dd MMM yyyy').format(reminder.scheduledDate),
              scheduledDate: reminder.scheduledDate,
              scheduled: true,
            );
            await _fetchReminders();

            setState(() {
              _isLoading = false;
            });
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}