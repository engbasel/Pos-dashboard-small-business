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

// ============================ English Section ==========================

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
      "SalesInvoicesReportFile": "Sales_Invoices_Report_File",
      "dateTime": "Date and Time",
      "type": "Type",
      "Products": "Products",
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
      "AlertDiloageCloseApp": "Are you sure you want to close this window?",
      "customerDetails": "Customer Details",

      // =========================== Home view screen ==========================================
      "email": "Email",
      "saveInvocis": "save Invocis",
      "registerSince": "Register Since",
      "Password": "Password",
      "time": "Time",
      "favouriteBranch": "Favourite Branch",
      "favouriteItem": "section specialset",
      "totalPoints": "Total products In Store:",
      "pointsUsed": "Points Used:",
      "outstandingPoints": "Outstanding Points",
      "orders": "Orders",
      "logout": "Logout:",
      "totalSpend": "Total Spend:",
      "averageOrderValue": "Average Order Value",
      "totalVisits": "Total Visits:",
      "lastVisit": "Last Visit:",
      "spendingTimePerDay": "Spending Time / Day",
      "viewUserLogs": "View User Logs",
      "anotherSettingOption": "Another Setting Option",
      "staff": "Staff",
      "users": "Users", "returnInvoiceDetails": "Return Invoice Details",
      "edit": "Edit",
      "userNameNotFound": "User Not Found in staff database",
      "update": "update",
      "Deficiencies": "Deficiencies",
      "dataUpdated": "data updated",
      "printReport": "print Reports",
      "printOrder": "Print Order",
      "invoiceId": "Invoice ID",
      "orderId": "Order ID",
      "totalBackMoney": "Total Back Money",
      "editReturnInvoice": "Edit Return Invoice",
      "incomingOrders": "Incoming Orders",
      "error": "Error",
      "Allproductshavesufficientquantity":
          "All products have sufficient quantity.",
      "noIncomingOrders": "No incoming orders found",
      "invoiceID": "Invoice ID",
      "orderID": "Order ID",
      "ItemID": "Item ID",
      "returnDate": "Return Date",
      "reason": "Reason", "orderDetails": "Order Details",
      "supplierName": "Supplier Name",
      "orderDate": "Order Date",
      "expectedDeliveryDate": "Expected Delivery Date",
      "orderStatus": "Order Status",
      "totalAmount": "Total Amount",
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
      "save": "حفظ",
      "updateSuccess": "تم تحديث فاتورة العودة بنجاح",
      "updateError": "خطأ في تحديث فاتورة العودة",
      "Tax": "Tax",
      "reports": "Reports",
      "ExportasPDF": "Export as PDF",
      "AddItem": "Add Item",
      "TotalAmount": "Total Amount",
      "No.": "No",
      "Quantity": "Quantity",
      "InvoiceNumber": "Invoice Number",
      "SalesInvoices": "Sales Invoices",
      "CustomerName": "Customer Name",
      "SalesBill": "Sales Bill",
      "dateTodayAndTimeNow": "Date today and time now",
      "numberOfCategories": "Number of categories",
      "totalPaymentsToday": "Total payments today",
      "totalBillExportedToday": "Total bill exported today",
      "totalReturnProductsToday": "Total return products today",
      "notifications": "Notifications",
      "item_details": "item details",
      "ViewInvoices": "View Invoices",
      "Items": "Items",
      "ErrorupdatingReturnInvoice": "Error updating Return Invoice:",

      "customers": "Customers",
      "edit_category": "Edit Category",
      "addCustomer": "Add Customer",
      "search": "Search",
      "EditReturnInvoice": "Edit Return Invoice",
      "clientNotFound": "Client not found",
      "confirmDelete": "Confirm Delete",
      "deleteConfirmation": "Are you sure you want to delete this customer?",
      "cancel": "Cancel",
      "clientDetails": "client Details",
      "delete": "Delete",
      "clientsReports": "clients Reports",
      "fullName": "Full Name",
      "indebtedness": "Indebtedness",
      "currentAccount": "Current Account",
      "notes": "Notes",
      'orderList': 'Order List',
      'addOrder': 'Add Order',
      'select_category': 'Select Category',
      'select_payment_method': 'Select Payment Method',
      'order_details': 'Order Details',

      // ======================== Catigorys section ===========================
      "catigoryscreen": "category screen",
      "Categories": "Categories",
      "title": "Categories",
      "search_categories": "Search for a category...",
      "Search_for_a_product": "Search for a product...",
      "category_not_available": "Category not available",
      "add_category": "Add Category",
      "category_title": "Category Title",
      "pick_color": "Pick a color",
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
      "returnInvoices": "Return Invoices",
      "addReturn": "Add A Return",
      "discontinued": "Discontinued",
      "enterOrderId": "Please enter an order ID",
      "enterSupplierName": "Please enter a supplier name",
      "enterOrderDate": "Please enter an order date",
      "enterExpectedDeliveryDate": "Please enter an expected delivery date",
      "enterOrderStatus": "Please enter an order status",
      "enterTotalAmount": "Please enter the total amount",
      "items": "Items",
      "search_items": "Search Items",
      "item_not_available": "Item not available",
      "please_fill_required_fields":
          "Please fill in all required fields and select a valid item status.",

      // ======================== Orders section ===========================
      "all": "All",
      "Yes": "Yes",
      "monthly": "Monthly",
      "weekly": "Weekly",
      "today": "Today",
      "orderType": "Order Type",
      "Complete": "Complete",
      "Pending": "Pending",
      "Paid": "Paid",
      "dashboard": "Dashboard",
      "settings": "Settings",
      "messages": "Messages",
      "username": "Username", "editCustomer": "Edit Customer",
      "pleaseEnterFullName": "Please enter full name",
      "birthday": "Birthday",
      "catigoryes": "Categories", "addNewCustomer": "Add New Customer",
      "privilege": "Privilege",
      "gender": "Gender",
      "AddAProduc": "Add A Product",
      "userLogs": "User Logs",
      "branch": "Branch",
      "date": "Date",
      "InvalidPassword": "Invalid Password",
      "actions": "actions",
      "clearFields": "delete Fields",
      "Delete": "delete",
      "manufacture_date": "manufacture date",
      "Cancel": "Cancel",
      "ReturnInvoices": "Return Invoices",
      "NeededProducts": "Needed Products",
      "select_image": "select Image",
      "confirmDeleteMessage": "Are you sure you want to delete this item?",
      "Ok": "Ok",
      "Thepasswordyouenteredisincorrect":
          "The password you entered is incorrect.",
    }

// ============================ English Section ==========================
// ============================ arabic Section ==========================
    ,
    'ar': {
      "confirmDeleteMessage": "هل أنت متأكد أنك تريد حذف هذا العنصر؟",
      "orderID": "معرف الطلب",
      "Password": "الرقم السري",
      "dateTime": "التاريخ/الوقت",
      "date": "التاريخ",
      "time": "الوقت",
      "orderType": "نوع الطلب",
      "employee": "الموظف",
      "AlertDiloageCloseApp": "هل تريد اغلاق التطبيق",
      "customerDetails": "تفاصيل العميل",
      "NeededProducts": "المنتجات الناقصة",
      "Ok": "موافق",
      "staff": "العاملين",
      "users": "العملاء",
      "Products": "المنتجات",
      "status": "الحالة",
      "paymentStatus": "حالة الدفع",
      "amount": "المبلغ",
      "manufacture_date": "تاريخ التصنيع",
      "ReturnInvoices": "فاتورة المسترجع", "addOrder": "إضافة طلب",
      "orderId": "معرف الطلب",
      "enterOrderId": "يرجى إدخال معرف الطلب",
      "supplierName": "اسم المورد",
      "enterSupplierName": "يرجى إدخال اسم المورد",
      "orderDate": "تاريخ الطلب",
      "enterOrderDate": "يرجى إدخال تاريخ الطلب",
      "expectedDeliveryDate": "تاريخ التسليم المتوقع",
      "enterExpectedDeliveryDate": "يرجى إدخال تاريخ التسليم المتوقع",
      "orderStatus": "حالة الطلب",
      "enterOrderStatus": "يرجى إدخال حالة الطلب",
      "totalAmount": "المبلغ الإجمالي",
      "enterTotalAmount": "يرجى إدخال المبلغ الإجمالي",
      "select_payment_method": "اختر طريقة الدفع",
      "actions": "الإجراءات",
      "order_details": "تفاصيل المنتج", "editCustomer": "تحرير العميل",
      "fullName": "الاسم الكامل",
      "pleaseEnterFullName": "يرجى إدخال الاسم الكامل",
      "indebtedness": "المستحقات",
      "currentAccount": "الحساب الجاري",
      "notes": "ملاحظات",
      "cancel": "إلغاء",
      "save": "حفظ",
      "clearFields": "مسح الحقول",

      "ordersTable": "جدول الطلبات",
      "id": "البضاعة بالمخزن",
      "type": "النوع",
      "changeMode": "تغير الوضع",
      "logout": "تسجيل خروج",
      "numberOfItems": "عدد العناصر",
      "entryDate": "تاريخ الإدخال",
      "exitDate": "تاريخ الخروج",
      "wholesalePrice": "سعر الجملة",
      "retailPrice": "سعر التجزئة",
      "productStatus": "حالة المنتج",
      "productDetails": "تفاصيل المنتج",
      "productModel": "طراز المنتج",
      "category": "الفئة",

      "userLogs": "سجلات المستخدم",
      "loginTitle": "تسجيل الدخول",
      "nameLabel": "الاسم",
      "nameHint": "أدخل اسمك",
      "orders": "فاتورة المبيعات",
      "nameError": "يرجى إدخال اسمك",
      "idLabel": "الرقم القومي",
      "idHint": "ادخل الرقم القومي",
      "idError": "يرجى إدخال الرقم القومي",
      "privilegeLabel": "صلاحية",
      "admin": "مدير",
      "customer": "عميل",
      "dataUpdated": "تم تحديث البيانات بنجاح",
      "genderLabel": "الجنس",
      "male": "ذكر",
      "SalesInvoicesReportFile": "ملف_فواتير_المبيعات ",
      "female": "أنثى",
      "emailLabel": "البريد الإلكتروني",
      "branchLabel": "الفرع",
      "select_image": "اختر الصورة",
      "letsWorkButton": "لنعمل",
      "anotherSettingOption": "انظر اعدادت اخر",
      "viewUserLogs": "سجل العاملين",
      "customers": "العملاء",
      "clientsReports": "تقارير العملاء",
      "addCustomer": "إضافة عميل",
      "search": "بحث",
      "clientNotFound": "العميل غير موجود",
      "edit": "تعديل",
      "confirmDelete": "تأكيد الحذف",
      "deleteConfirmation": "هل أنت متأكد أنك تريد حذف هذا العميل؟",
      "delete": "حذف",
      // ======================== Sales_bill section ===========================
      "Invoice": "الفاتورة",
      "Quantity": "الكمية",
      "item_details": "تفاصيل المنتج",
      "GrandTotal": "الاجمالي المدفوع",
      "UnitPrice": "سعر الوحدة", "addNewCustomer": "إضافة عميل جديد",
      "orderDetails": "تفاصيل الطلب",
      "add": "إضافة",
      "update": "تحديث",
      "Total": "الاجمالي",
      "Customer": "العميل",
      "Discount": "الخصم",
      "ExportasPDF": "استخراج كملف",
      "SalesBill": "فاتورة المبيعات",
      "editReturnInvoice": "تعديل فاتورة العودة",
      "invoiceId": "رقم الفاتورة",
      "totalBackMoney": "المبلغ المسترد",
      "returnDate": "تاريخ العودة",
      "reason": "السبب",
      "updateSuccess": "تم تحديث فاتورة العودة بنجاح",
      "updateError": "خطأ في تحديث فاتورة العودة",
      "Product": "المنتج",
      "clientDetails": "تفاصيل العميل",
      "No.": "مسلسل",
      "Data": "التاريخ",
      "Items": "العناصر",
      "printReport": "طباعه التقارير",
      "InvoiceNumber": "رقم الفاتورة",
      "SalesInvoices": "فاتورة مبيعات",
      "CustomerName": "اسم العميل",
      "TotalAmount": "اجمالي العناصر قبل الضرائب",
      "Tax": "الضرائب",
      "Deficiencies": "النواقص",
      "AddItem": "اضافة عنصر",
      "dateTodayAndTimeNow": "التاريخ اليوم والوقت الآن",
      "numberOfCategories": "عدد الفئات",
      "totalPaymentsToday": "إجمالي المدفوعات اليوم",
      "totalBillExportedToday": "إجمالي الفواتير الصادرة اليوم",
      "totalReturnProductsToday": "إجمالي المنتجات المرتجعة اليوم",
      "notifications": "الإشعارات",
      "ViewInvoices": "عرض الفواتير",

      // ======================== Catigorys section ===========================
      "Catigorys": "الأصناف",
      "edit_category": "تعديل الفئة",
      "invoiceID": "رقم الفاتورة",
      "catigoryscreen": "عرض الأصناف",
      "title": "الفئات",
      "search_categories": "ابحث عن الفئة...", "saveInvocis": "حفظ الفواتير",
      "Search_for_a_product": "ابحث عن العناصر...",
      "Search_for_a_customer": "ابحث عن العملاء...",
      "category_not_available": "الفئة غير متاحة",
      "add_category": "إضافة فئة",
      "category_title": "عنوان الفئة",
      "pick_color": "اختر لونًا",
      "changeLanguage": "تغير اللغة",
      "select_category": "اختر الفئة",
      "add_item": "إضافة عنصر", "incomingOrders": "الطلبات الواردة",
      "error": "خطأ",
      "Allproductshavesufficientquantity": "جميع المنتجات متوفرة بكميات كافية.",
      "noIncomingOrders": "لم يتم العثور على طلبات واردة",
      "item_name": "اسم العنصر",
      "description": "الوصف",
      "sku": "رمز المخزون",
      "barcode": "الباركود", "returnInvoices": "فواتير المرتجعات",
      "addReturn": "إضافة مرتجع",
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
      "AddAProduc": "اضافة عنصر جديد",

      "color": "اللون",
      "ItemID": "رقم المنتج",
      "material": "المادة",
      "warranty": "الضمان",
      "supplier_id": "معرف المورد",
      "returnInvoiceDetails": "تفاصيل فاتورة المرتجع",
      "printOrder": "طباعة الطلب",
      "item_status": "حالة العنصر",
      "active": "نشط",
      "inactive": "غير نشط",
      "discontinued": "ملغى",
      "userNameNotFound": "المستخدم غير مسجل في قاعدة العاملين",

      "items": "العناصر",
      "search_items": "ابحث عن العناصر",
      "item_not_available": "العنصر غير متاح",
      "please_fill_required_fields":
          "يرجى ملء جميع الحقول المطلوبة واختيار حالة العنصر الصحيحة.",

      // ======================== Orders section ===========================
      "dashboard": "لوحة التحكم",
      "settings": "الإعدادات",
      "messages": "الرسائل",
      "username": "اسم المستخدم",
      "birthday": "تاريخ الميلاد",

      'orderList': 'قائمة الطلبات',

      "catigoryes": "الأصناف",
      "Yes": "نعم",
      "privilege": "الامتياز",
      "gender": "الجنس",
      "reports": "التقارير",
      "branch": "الفرع",
      "InvalidPassword": "كلمة المرور التي أدخلتها غير صحيحة.",
      "Delete": "حذف",
      "Cancel": "إلغاء",
      "ReturnInvoiceupdatedsuccessfully": "تم تحديث فاتورة الإرجاع بنجاح",
      "Thepasswordyouenteredisincorrect": "كلمة المرور التي أدخلتها غير صحيحة.",
      "ErrorupdatingReturnInvoice": "خطأ في تحديث فاتورة الإرجاع:",
    }

// ============================ arabic Section ==========================
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}
