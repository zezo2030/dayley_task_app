import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// parse date string to DateTime
DateTime toDate({required String date}) {
  final utcDateTime = DateTime.parse(date);
  return utcDateTime.toLocal();
}

String formatDate({
  required String dateTime,
  format = 'dd/MM/yyyy',
  required BuildContext context,
}) {
  final localDateTime = toDate(date: dateTime);
  final locale = context.locale.languageCode;

  // استخدام لغة التطبيق الحالية للتنسيق
  final formatter = DateFormat(format, locale);

  return formatter.format(localDateTime);
}
