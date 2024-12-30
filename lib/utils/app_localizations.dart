import 'package:flutter/material.dart';

class AppLocalizations {
  static const supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static bool isRTL(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }

  static TextDirection getTextDirection(BuildContext context) {
    return isRTL(context) ? TextDirection.rtl : TextDirection.ltr;
  }
}
