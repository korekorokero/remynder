class ReminderModel {
  final int id;
  final String title;
  final DateTime scheduledDate;

  ReminderModel({
    this.id = 0,
    required this.title,
    required this.scheduledDate,
  });

  static ReminderModel fromJson(Map<String, dynamic> json) => ReminderModel(
    id: json['id'] as int,
    title: json['title'] as String,
    scheduledDate: DateTime.parse(json['scheduledDate'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'scheduledDate': scheduledDate.toIso8601String(),
  };
}