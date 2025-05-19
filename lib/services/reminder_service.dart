import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remynder/models/reminder_model.dart';

class ReminderService {
  final _db = FirebaseFirestore.instance.collection('reminders');

  Future<int> addReminder(ReminderModel reminder) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF;
      final data = {...reminder.toJson(), 'id': id};
      await _db.doc(id.toString()).set(data);
      return id;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReminderModel>> readReminders() async {
    try {
      final snapshot = await _db.get();
      return snapshot.docs.map((doc) {
        final json = doc.data();
        json['id'] = int.tryParse(doc.id)?.toSigned(32) ?? json['id'];
        return ReminderModel.fromJson(json);
      }).toList()
        ..sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));
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