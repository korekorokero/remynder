import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remynder/models/reminder_model.dart';

class ReminderService {
  final _db = FirebaseFirestore.instance.collection('reminders');

  Future<void> addReminder(ReminderModel reminder) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch;
      final data = {...reminder.toJson(), 'id': id};
      await _db.doc(id.toString()).set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReminderModel>> readReminders() async {
    try {
      final querySnapshot = await _db.get();

      final remindersList = querySnapshot.docs.map((doc) {
        return ReminderModel.fromJson(doc.data());
      }).toList();

      remindersList.sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));

      return remindersList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteReminder(int id) async {
    try {
      await _db.doc(id.toString()).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    try {
      await _db.doc(reminder.id.toString()).update(reminder.toJson());
    } catch (e) {
      rethrow;
    }
  }
}