import 'package:flutter/material.dart';

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
      "loginRecordedSuccessfully": "Login Recorded Successfully",
      "email": "Email",
      "registerSince": "Register Since",
      "favouriteBranch": "Favourite Branch",
      "favouriteItem": "Favourite Item",
      "totalPoints": "Total Points :",
      "pointsUsed": "Points Used :",
      "outstandingPoints": "Outstanding Points",
      "orders": "Orders :",
      "totalSpend": "Total Spend :",
      "averageOrderValue": "Average Order Value",
      "totalVisits": "Total Visits :",
      "lastVisit": "Last Visit :",
      "spendingTimePerDay": "Spending Time / Day",
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
      "loginRecordedSuccessfully": "تم تسجيل الدخول بنجاح",
      "email": "البريد الإلكتروني",
      "registerSince": "مسجل منذ",
      "favouriteBranch": "الفرع المفضل",
      "favouriteItem": "العنصر المفضل",
      "totalPoints": "مجموع النقاط:",
      "pointsUsed": "النقاط المستخدمة:",
      "outstandingPoints": "النقاط المستحقة",
      "orders": "الطلبات:",
      "totalSpend": "إجمالي الإنفاق:",
      "averageOrderValue": "متوسط قيمة الطلب",
      "totalVisits": "إجمالي الزيارات:",
      "lastVisit": "الزيارة الأخيرة:",
      "spendingTimePerDay": "وقت الإنفاق / اليوم"
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}
