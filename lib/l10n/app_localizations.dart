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

      "ordersTable": "Orders Table",
      "id": "ID",
      "dateTime": "Date and Time",
      "type": "Type",
      "employee": "Employee",
      "status": "Status",
      "paymentStatus": "Payment Status",
      "amount": "Amount",
      "numberOfItems": "Number of Items",
      "entryDate": "Entry Date",
      "exitDate": "Exit Date",
      "wholesalePrice": "Wholesale Price",
      "retailPrice": "Retail Price",
      "productStatus": "Product Status",
      "productDetails": "Product Details",
      "productModel": "Product Model",
      "category": "Category",

      // =========================== Home view screen ==========================================
      "email": "Email",
      "registerSince": "Register Since",
      "Password": "Password",
      "favouriteBranch": "Favourite Branch",
      "favouriteItem": "section specialset",
      "totalPoints": "Total products In Store:",
      "pointsUsed": "Points Used:",
      "outstandingPoints": "Outstanding Points",
      "orders": "Orders:",
      "totalSpend": "Total Spend:",
      "averageOrderValue": "Average Order Value",
      "totalVisits": "Total Visits:",
      "lastVisit": "Last Visit:",
      "spendingTimePerDay": "Spending Time / Day",
      "viewUserLogs": "View User Logs",
      "anotherSettingOption": "Another Setting Option",
      "staff": "Staff",
      "users": "Users",
      "changeMode": "Change Mode",
      "changeLanguage": "Change Language",

      // ======================== Sales_bill section ===========================
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
      "AddItem": "Add Item",
      "TotalAmount": "Total Amount",
      "No.": "No",
      "Quantity": "Quantity",
      "InvoiceNumber": "Invoice Number",
      "SalesInvoices": "Sales Invoices",
      "CustomerName": "Customer Name",
      "SalesBill": "Sales Bill",
      "item_details": "item details",
      "ViewInvoices": "View Invoices",
      "Items": "Items",

      'orderList': 'Order List',
      'addOrder': 'Add Order',
      'select_category': 'Select Category',
      'select_payment_method': 'Select Payment Method',
      'order_details': 'Order Details',

      // ======================== Catigorys section ===========================
      "catigoryscreen": "category screen",
      "Categories": "Categories",
      "title": "Categories",
      "search_categories": "Search Categories",
      "category_not_available": "Category not available",
      "add_category": "Add Category",
      "category_title": "Category Title",
      "pick_color": "Pick a color",
      "cancel": "Cancel",
      "add": "Add",
      "add_item": "Add Item",
      "item_name": "Item Name",
      "description": "Description",
      "sku": "SKU",
      "barcode": "Barcode",
      "purchase_price": "Purchase Price",
      "sale_price": "Sale Price",
      "wholesale_price": "Wholesale Price",
      "tax_rate": "Tax Rate",
      "quantity": "Quantity",
      "alert_quantity": "Alert Quantity",
      "image": "Image",
      "brand": "Brand",
      "size": "Size",
      "weight": "Weight",
      "color": "Color",
      "material": "Material",
      "warranty": "Warranty",
      "supplier_id": "Supplier ID",
      "item_status": "Item Status",
      "active": "Active",
      "inactive": "Inactive",
      "discontinued": "Discontinued",
      "items": "Items",
      "search_items": "Search Items",
      "item_not_available": "Item not available",
      "please_fill_required_fields":
          "Please fill in all required fields and select a valid item status.",

      // ======================== Orders section ===========================
      "all": "All",
      "monthly": "Monthly",
      "weekly": "Weekly",
      "today": "Today",
      "orderId": "Order ID",
      "orderType": "Order Type",
      "Complete": "Complete",
      "Pending": "Pending",
      "Paid": "Paid",
      "overview": "Overview",
      "customers": "Customers",
      "settings": "Settings",
      "messages": "Messages",
      "username": "Username",
      "birthday": "Birthday",
      "catigoryes": "categories",
      "privilege": "Privilege",
      "gender": "Gender",
      "userLogs": "User Logs",
      "branch": "Branch",
      "InvalidPassword": "Invalid Password",
      "orderID": "order ID",
      "actions": "actions",
      "clearFields": "delete Fields",
      "Delete": "delete",
      "Cancel": "Cancel",
      "select_image": "select Image",
      "Ok": "Ok",
      "Thepasswordyouenteredisincorrect":
          "The password you entered is incorrect.",
    }

// ============================ arabic Section ==========================
    ,
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
      "select_payment_method": "اختر طريقة الدفع",
      "actions": "الإجراءات",
      "order_details": "تفاصيل المنتج",
      "clearFields": "مسح الحقول",

      "ordersTable": "جدول الطلبات",
      "id": "البضاعة بالمخزن",
      "type": "النوع",
      "numberOfItems": "عدد العناصر",
      "entryDate": "تاريخ الإدخال",
      "exitDate": "تاريخ الخروج",
      "wholesalePrice": "سعر الجملة",
      "retailPrice": "سعر التجزئة",
      "productStatus": "حالة المنتج",
      "productDetails": "تفاصيل المنتج",
      "productModel": "طراز المنتج",
      "category": "الفئة",

      "addOrder": "إضافة منتج",
      "userLogs": "سجلات المستخدم",
      "loginTitle": "تسجيل الدخول",
      "nameLabel": "الاسم",
      "nameHint": "أدخل اسمك",
      "orders": "المنتجات:",
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
      "select_image": "اختر الصورة",
      "letsWorkButton": "لنعمل",

      // ======================== Sales_bill section ===========================
      "Invoice": "الفاتورة",
      "Quantity": "الكمية",
      "item_details": "تفاصيل المنتج",
      "GrandTotal": "الاجمالي المدفوع",
      "UnitPrice": "سعر الوحدة",
      "Total": "الاجمالي",
      "Customer": "العميل",
      "Discount": "الخصم",
      "ExportasPDF": "استخراج كملف",
      "SalesBill": "فاتورة المبيعات",
      "Product": "المنتج",
      "No.": "مسلسل",
      "Data": "التاريخ",
      "Items": "العناصر",
      "InvoiceNumber": "رقم الفاتورة",
      "SalesInvoices": "فاتورة مبيعات",
      "CustomerName": "اسم العميل",
      "TotalAmount": "اجمالي العناصر قبل الضرائب",
      "Tax": "الضرائب",
      "AddItem": "اضافة عنصر",
      "ViewInvoices": "عرض الفواتير",

      // ======================== Catigorys section ===========================
      "Catigorys": "الأصناف",
      "catigoryscreen": "عرض الأصناف",
      "title": "الفئات",
      "search_categories": "ابحث في الفئات",
      "category_not_available": "الفئة غير متاحة",
      "add_category": "إضافة فئة",
      "category_title": "عنوان الفئة",
      "pick_color": "اختر لونًا",
      "cancel": "إلغاء",
      "add": "إضافة",
      "select_category": "اختر الفئة",
      "add_item": "إضافة عنصر",
      "item_name": "اسم العنصر",
      "description": "الوصف",
      "sku": "رمز المخزون",
      "barcode": "الباركود",
      "purchase_price": "سعر الشراء",
      "sale_price": "سعر البيع",
      "wholesale_price": "سعر الجملة",
      "tax_rate": "معدل الضريبة",
      "quantity": "الكمية",
      "alert_quantity": "كمية التنبيه",
      "image": "الصورة",
      "brand": "العلامة التجارية",
      "size": "الحجم",
      "weight": "الوزن",
      "color": "اللون",
      "material": "المادة",
      "warranty": "الضمان",
      "supplier_id": "معرف المورد",
      "item_status": "حالة العنصر",
      "active": "نشط",
      "inactive": "غير نشط",
      "discontinued": "ملغى",
      "items": "العناصر",
      "search_items": "ابحث عن العناصر",
      "item_not_available": "العنصر غير متاح",
      "please_fill_required_fields":
          "يرجى ملء جميع الحقول المطلوبة واختيار حالة العنصر الصحيحة.",

      // ======================== Orders section ===========================
      "overview": "نظرة عامة",
      "customers": "العملاء",
      "settings": "الإعدادات",
      "messages": "الرسائل",
      "username": "اسم المستخدم",
      "birthday": "تاريخ الميلاد",

      'orderList': 'قائمة الطلبات',

      "catigoryes": "الأصناف",
      "privilege": "الامتياز",
      "gender": "الجنس",
      "branch": "الفرع",
      "InvalidPassword": "كلمة المرور التي أدخلتها غير صحيحة.",
      "Delete": "حذف",
      "Cancel": "إلغاء",
      "Thepasswordyouenteredisincorrect": "كلمة المرور التي أدخلتها غير صحيحة.",
    }

// ============================ arabic Section ==========================
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}
