import 'package:flutter/material.dart';

bool isArabic(BuildContext context) {
  return Localizations.localeOf(context).languageCode == 'ar';
}
