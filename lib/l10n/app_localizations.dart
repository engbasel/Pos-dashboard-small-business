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
    // ============================ English Section ==========================

    'en': {
      // =========================== login screen ==========================================
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

      // =========================== Home viwe screen ==========================================
      "email": "Email",
      "registerSince": "Register Since",
      "Password": "Password",
      "favouriteBranch": "Favourite Branch",
      "favouriteItem": "section spicialset",
      "totalPoints": "Total prodacts In Store :",
      "pointsUsed": "Points Used :",
      "outstandingPoints": "Outstanding Points",
      "orders": "Orders :",
      "totalSpend": "Total Spend :",
      "averageOrderValue": "Average Order Value",
      "totalVisits": "Total Visits :",
      "lastVisit": "Last Visit :",
      "spendingTimePerDay": "Spending Time / Day",
      "viewUserLogs": "View User Logs",
      "anotherSettingOption": "Another Setting Option",
      "staff": "Staff",
      "users": "Users",
      "changeMode": "Change Mode",
      "changeLanguage": "Change Language",

//  ======================== Sales_bill section ===========================
      "Invoice": "Invoice",
      "GrandTotal:": "Grand Total:",
      "Customer": "Customer",
      "Data": "Data",
      "UnitPrice": "Unit Price",
      "Product": "Product",
      "Discount": "Discount",
      "Total": "Total",
      "Tax": "Tax",
      "ExportasPDF": "Export as PDF",
      "AddItem": "AddItem",
      "TotalAmount": "Total Amount",
      "No.": "No",
      "Quantity": "Quantity",
      "InvoiceNumber": "Invoice Number",
      "SalesInvoices": "Sales Invoices",
      "CustomerName": "Customer Name",
      "SalesBill": "Sales Bill",
      "ViewInvoices": "View Invoices",
      "Items": "Items",

//  ======================== Sales_bill section ===========================

      "orderList": "Prodacts List",
      "all": "All",
      "monthly": "Monthly",
      "weekly": "Weekly",
      "today": "Today",
      "orderId": "Order ID",
      "dateTime": "Date/Time",
      "orderType": "Order Type",
      "employee": "Employee",
      "status": "Status",
      "paymentStatus": "Payment Status",
      "amount": "Amount",
      "Complete": "Complete",
      "Pending": "Pending",
      "Paid": "Paid",
      "overview": "Overview",
      "customers": "Customers",
      "settings": "Settings",
      "messages": "Messages",
      "username": "Username",
      "birthday": "Birthday",
      "catigoryes": "catigoryes",
      "privilege": "Privilege",
      "gender": "Gender",
      "userLogs": "User Logs",
      "branch": "Branch",
      "InvalidPassword": "Invalid Password",
      "orderID": "order ID",
      "actions": "actions",
      "clearFields": "delete Fileds",
      "Delete": "delete",
      "Cancel": "Cancel",
      "Ok": "Ok",
      "Thepasswordyouenteredisincorrect":
          "The password you entered is incorrect.",
      "addOrder": "Add Prodact",
    },

// ============================ English Section ==========================
//
//
// ============================ arabic Section ==========================
    'ar': {
      "orderID": "معرف الطلب",
      "Password": "الرقم السري",
      "dateTime": "التاريخ/الوقت",
      "orderType": "نوع الطلب",
      "employee": "الموظف",
      "Ok": "موافق",
      "status": "الحالة",
      "paymentStatus": "حالة الدفع",
      "amount": "المبلغ",
      "actions": "الإجراءات",
      "clearFields": "مسح الحقول",
      "addOrder": "إضافة منتج",
      "userLogs": "سجلات المستخدم",
      "loginTitle": "تسجيل الدخول",
      "nameLabel": "الاسم",
      "nameHint": "أدخل اسمك",
      "orders": "المنتجات :",
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

      //  ======================== Sales_bill section ===========================

      "Invoice": "الحالة",
      "Quantity": "الكمية",
      "GrandTotal": "الاجمالي المدفوع",
      "UnitPrice": "سعر الوحدة",
      "Total": "الاجمالي",
      "Customer": "العميل",
      "Discount": "الخصم",
      "ExportasPDF": "استخراج كملف",
      "SalesBill": "قاتورة المبيعات",
      "Product": "المنتح",
      "No.": "مسلسل",
      "Data": "التاريخ",
      "Items": "العناصر",
      "InvoiceNumber": "رقم الفاتورة",
      "SalesInvoices": "فاتورة مبيعات",
      "CustomerName": "اسم العميل",
      "TotalAmount": "اجمالي العناصر",
      "Tax": "الضرائب",
      "AddItem": "اضافة عنصر",
      "ViewInvoices": "عرض الفواتير ",

//  ======================== Sales_bill section ===========================

      "loginRecordedSuccessfully": "تم تسجيل الدخول بنجاح",
      "email": "البريد الإلكتروني",
      "registerSince": "مسجل منذ",
      "favouriteBranch": "الفرع المفضل",
      "favouriteItem": "قسم التخصص ",
      "totalPoints": " اجمالي العناصر بالمحل:",
      "catigoryes": "الانواع",
      "pointsUsed": "النقاط المستخدمة:",
      "outstandingPoints": "النقاط المستحقة",
      "brodacts": "المنتجات:",
      "totalSpend": "إجمالي الإنفاق:",
      "averageOrderValue": "متوسط قيمة الطلب",
      "totalVisits": "إجمالي الزيارات:",
      "lastVisit": "الزيارة الأخيرة:",
      "spendingTimePerDay": "وقت الإنفاق / اليوم",
      "viewUserLogs": "عرض سجلات المستخدم",
      "anotherSettingOption": "خيار إعدادات آخر",
      "staff": "الموظفين",
      "users": "المستخدمين",
      "changeMode": "تغيير الوضع",
      "changeLanguage": "تغيير اللغة",
      "orderList": "قائمة المنتجات",
      "all": "الكل",
      "monthly": "شهريا",
      "weekly": "أسبوعيا",
      "today": "اليوم",
      "orderId": "المنتج رقم",
      "Complete": "مكتمل",
      "Pending": "معلق",
      "Paid": "مدفوع",
      "overview": "نظرة عامة",
      "customers": "العملاء",
      "settings": "الإعدادات",
      "messages": "الرسائل",
      "username": "اسم المستخدم",
      "birthday": "تاريخ الميلاد",
      "privilege": "الامتياز",
      "Cancel": "الغاء",
      "Delete": "الحذف",
      "gender": "الجنس",
      "InvalidPassword": "الرقم السري خطاء",
      "Thepasswordyouenteredisincorrect": "الرقم السري الذي ادخلتة خطاء",
      "branch": "الفرع"
    },
    // ============================ arabic Section ==========================
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}
