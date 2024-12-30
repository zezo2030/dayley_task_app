import 'package:intl/intl.dart';

String formatDateByLocale(String dateTime, String locale) {
  final DateTime date = DateTime.parse(dateTime);
  final DateFormat formatter = locale == 'ar'
      ? DateFormat.yMEd('ar') // التنسيق العربي
      : DateFormat.yMEd('en'); // التنسيق الإنجليزي
  return formatter.format(date);
}
