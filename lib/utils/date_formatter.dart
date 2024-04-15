import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('MMM d, yyyy').format(dateTime);
}

String formatDateStringInYear(String dateString) {
  if (dateString == '') {
    return '';
  }
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('yyyy').format(dateTime);
}
