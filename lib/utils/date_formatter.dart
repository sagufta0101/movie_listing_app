import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('MMM d, yyyy').format(dateTime);
}
