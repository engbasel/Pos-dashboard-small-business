import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "loginTitle": "Login",
      "nameLabel": "Name",
      "nameHint": "Enter your name",
      "nameError": "Please enter your name",
      "idLabel": "ID",
      "idHint": "Enter your ID",
      "idError": "Please enter your ID",
      "privilegeLabel": "Privilege",
      "admin": "Admin",
      "customer": "Customer",
      "genderLabel": "Gender",
      "male": "Male",
      "female": "Female",
      "emailLabel": "Email",
      "branchLabel": "Branch",
      "letsWorkButton": "Let's work",
      "loginRecordedSuccessfully": "Login Recorded Successfully"
    },
    'ar': {
      "loginTitle": "تسجيل الدخول",
      "nameLabel": "الاسم",
      "nameHint": "أدخل اسمك",
      "nameError": "يرجى إدخال اسمك",
      "idLabel": "الرقم القومي",
      "idHint": "ادخل الرقم القومي",
      "idError": "يرجى إدخال الرقم القومي",
      "privilegeLabel": "صلاحية",
      "admin": "مدير",
      "customer": "عميل",
      "genderLabel": "الجنس",
      "male": "ذكر",
      "female": "أنثى",
      "emailLabel": "البريد الإلكتروني",
      "branchLabel": "الفرع",
      "letsWorkButton": "لنعمل",
      "loginRecordedSuccessfully": "تم تسجيل الدخول بنجاح"
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}
