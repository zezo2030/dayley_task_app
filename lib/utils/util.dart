import 'package:intl/intl.dart';

// parse date string to DateTime
DateTime toDate({required String date}) {
  final utcDateTime = DateTime.parse(date);
  return utcDateTime.toLocal();
}

String formatDate({
  required String dateTime,
  format = 'dd/MM/yyyy',
}) {
  final localDateTime = toDate(date: dateTime);
  return DateFormat(format).format(localDateTime);
}
