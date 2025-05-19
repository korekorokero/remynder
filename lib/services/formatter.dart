import 'package:intl/intl.dart';

String formatDate(DateTime scheduledDate) {
  final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm');
  return formatter.format(scheduledDate);
}