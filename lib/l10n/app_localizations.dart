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
      "name": "Name",
      "address": "Address",
      "nameHint": "Enter your name",
      "nameError": "Please enter your name",
      "idLabel": "ID",
      "All_Bills": "All Bills",
      "idHint": "Enter your ID",
      "idError": "Please enter your ID",
      "privilegeLabel": "Privilege",
      "admin": "Admin",
      "customer": "Customer",
      "genderLabel": "Gender",
      "newalerts": "new alerts",
      "male": "Male",
      "female": "Female",
      "emailLabel": "Email",
      "branchLabel": "Branch",
      "letsWorkButton": "Let's work",
      "loginRecordedSuccessfully": "Login Recorded Successfully",

      "ordersTable": "Orders Table",
      "id": "ID",
      "file": "File",
      "SalesInvoicesReportFile": "Sales_Invoices_Report_File",
      "dateTime": "Date and Time",
      "type": "Type",
      "Products": "Products",
      "employee": "Employee",
      "status": "Status",
      "alternative_phone": "Alternative Phone",
      "social_media": "Social Media",
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
      "image_url": "Image URL",
      "AlertDiloageCloseApp": "Are you sure you want to close this window?",
      "customerDetails": "Customer Details",

      // =========================== Home view screen ==========================================
      "email": "Email",
      "enter_password": "Enter Password",
      "saveInvocis": "save Invocis",
      "registerSince": "Register Since",
      "Register": "Register ",
      "Password": "Password",
      "time": "Time",
      "Bills_on": "Bills on",
      "favouriteBranch": "Favourite Branch",
      "favouriteItem": "section specialset",
      "totalPoints": "Total products In Store:",
      "pointsUsed": "Points Used:",
      "outstandingPoints": "Outstanding Points",
      "orders": "Orders",
      "logout": "Logout:",
      "totalSpend": "Total Spend:",
      "averageOrderValue": "Average Order Value",
      "totalVisits": "Total fVisits:",
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
      "Total_Back_Money": "Error",
      "'No_return_invoices_found": "'No return invoices found.",
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
      "InvoiceDate": "Invoice Date",
      "details": "Details",

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
      "Close": "Close",
      "dontHaveAccountText": "dont Have Account ?",
      "phone": "phone",
      "phone_number": "phone number",
      "preferred_payment_method": "Preferred Payment Method",
      "Secondary Address": "Secondary Address",
      "Postal Code": "Postal Code",
      "Delivery Preferences": "Delivery Preferences",
      "Customer Interests": "Customer Interests",
      "Support Rating": "Support Rating",
      "createAccount": "Create Account",
      "Quantity": "Quantity",
      "InvoiceNumber": "Invoice Number",
      'please_choose_a_category_first': 'Please choose a category first',

      "SalesInvoices": "Sales Invoices",
      "CustomerName": "Customer Name",
      "SalesBill": "Sales Bill",
      "dateTodayAndTimeNow": "Date today and time now",
      "numberOfCategories": "Number of categories",
      "totalPaymentsToday": "Total payments ",
      "totalBillExportedToday": "Total bill exported ",
      "totalReturnProductsToday": "Total return products ",
      "notifications": "Notifications",
      "item_details": "item details",
      "ViewInvoices": "View Invoices",
      "Items": "Items",
      "ErrorupdatingReturnInvoice": "Error updating Return Invoice:",

      "customers": "Customers",
      'select_where_to_save_pdf': 'Select where to save the PDF',
      'pdf_saved_to': 'PDF saved to',
      'failed_to_save_pdf': 'Failed to save PDF',
      'pdf_export_canceled': 'PDF export canceled',
      'error_saving_pdf': 'Error saving PDF',
      "edit_category": "Edit Category",
      "addCustomer": "Add Customer",
      "search": "Search",
      "EditReturnInvoice": "Edit Return Invoice",
      "clientNotFound": "Client not found",
      "confirmDelete": "Confirm Delete",
      "confirm": "Confirm",
      "Staff dashboard": "Staff Dashboard",
      "Add Employee": "Add Employee",
      "See All Available Employee": "See All Available Employee",
      "salaries of employees this month": "Salaries of Employees this month",
      "Employee Acssssscontes": "Employee Acssssscontes",
      "Employee List": "Employee List",
      "search for an employee": "Search for an employee...",
      "Position": "Position",
      "Department": "Department",
      "Qualifications": "Qualifications",
      "Employee Details": "Employee Details",
      "City": "City",
      "Experience": "Experience",
      "Salary": "Salary",
      "Extra details": "Extra details",
      "First Name": "First Name",
      "Middle Name": "Middle Name",
      "Last Name": "Last Name",
      "Logged in at": "Logged in at",
      "Edit Employee": "Edit Employee",
      "Save Changes": "Save Changes",
      "Created Accounts": "Created Accounts",
      "deleteConfirmation": "Are you sure you want to delete this customer?",
      "cancel": "Cancel",
      "clientDetails": "client Details",
      "delete": "Delete",
      "clientsReports": "clients Reports",
      "fullName": "Full Name",
      "indebtedness": "Indebtedness",
      "currentAccount": "Current Account",
      "accountCreated": "account Created",
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
      "Search_for_an_order": "Search for an order",
      "searchCustomer": "Search for a customer...",
      "category_not_available": "Category not available",
      "add_category": "Add Category",
      "category_title": "Category Title",
      "pick_color": "Pick a color",
      "add": "Add",
      "add_product": "Add Product",
      "add_item": "Add Item",
      "item_name": "Item Name",
      "description": "Description",
      "sku": "SKU",
      "passwordError": "password not correct",
      "emailError": "email not correct",
      "barcode": "Barcode",
      "purchasePrice": "Purchase Price",
      "salePrice": "Sale Price",
      "wholesale_price": "Wholesale Price",
      "taxRate": "Tax Rate",
      "quantity": "Quantity",
      "alertQuantity": "Alert Quantity",
      "image": "Image",
      "brand": "Brand",
      "size": "Size",
      "weight": "Weight",
      "color": "Color",
      "passoword_or_email_is_empty": "passoword or email is empty",
      "material": "Material",
      "warranty": "Warranty",
      "supplier_id": "Supplier ID",
      "item_status": "Item Status",
      "active": "Active",
      "inactive": "Inactive",
      "returnInvoices": "Return Invoices",
      "addReturn": "Add Return",
      "discontinued": "Discontinued",
      "enterOrderId": "Please enter an order ID",
      "enterSupplierName": "Please enter a supplier name",
      "enterOrderDate": "Please enter an order date",
      "enterExpectedDeliveryDate": "Please enter an expected delivery date",
      "enterOrderStatus": "Please enter an order status",
      "enterTotalAmount": "Please enter the total amount",
      "items": "Items",
      "date_modified": "date modified",
      "search_items": "Search Items",
      "item_not_available": "Item not available",
      "please_fill_required_fields":
          "Please fill in all required fields and select a valid item status.",

      // ======================== Orders section ===========================
      "all": "All",
      "Click_to_view_all_invoices": "Click to view all invoices",
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
      "birth_date": "Birth Date",
      "catigoryes": "Categories", "addNewCustomer": "Add New Customer",
      "privilege": "Privilege",
      "gender": "Gender",
      "AddAProduc": "Add Product",
      "userLogs": "User Logs",
      "branch": "Branch",
      "cannotBeEmpty": "can not Be Empty",
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
      "Select_Item": "Select Item",
      "confirmDeleteMessage": "Are you sure you want to delete this item?",
      "Ok": "Ok",
      "current user login at": "current user login at",
      "Thepasswordyouenteredisincorrect":
          "The password you entered is incorrect.",
    }

// ============================ English Section ==========================
// ============================ arabic Section ==========================
    ,
    'ar': {
      "confirmDeleteMessage": "هل أنت متأكد أنك تريد حذف هذا العنصر؟",
      "confirm": "تأكيد",
      "orderID": "معرف الطلب",
      "Password": "الرقم السري",
      "dateTime": "التاريخ/الوقت",
      "date": "التاريخ",
      "close": "الغاء",
      "time": "الوقت",
      "enter_password": "أدخل كلمة المرور",
      "Staff dashboard": "لوحة تحكم الموظفين",
      "birth_date": "تاريخ الميلاد",
      "Add Employee": "إضافة موظف",
      "See All Available Employee": "عرض جميع الموظفين المتاحين",
      "salaries of employees this month": "رواتب الموظفين هذا الشهر",
      "Employee Acssssscontes": "دخول الموظفين",
      "Employee List": "قائمة الموظفين",
      "search for an employee": "ابحث عن موظف...",
      "Position": "المنصب",
      "Department": "القسم",
      "Employee Details": "تفاصيل الموظف",
      "Qualifications": "المؤهلات",
      "City": "المدينة",
      "Salary": "الراتب",
      "Experience": "الخبرة",
      "Extra details": "تفاصيل اضافية",
      "First Name": "الاسم الأول",
      "Middle Name": "الاسم الأوسط",
      "Last Name": "اسم العائلة",
      "Edit Employee": "تعديل الموظف",
      "Save Changes": "حفظ التغييرات",
      "Created Accounts": "الحسابات المنشأة",
      "orderType": "نوع الطلب",
      "employee": "الموظف",
      "AlertDiloageCloseApp": "هل تريد اغلاق التطبيق",
      "customerDetails": "تفاصيل العميل",
      "NeededProducts": "المنتجات الناقصة",
      "Ok": "موافق",
      "Logged in at": "تم تسجيل الدخول في",
      "address": "العنوان",
      "alternative_phone": "الهاتف البديل",
      "social_media": "وسائل التواصل الاجتماعي",
      "preferred_payment_method": "طريقة الدفع المفضلة",
      "Secondary Address": "العنوان الثانوي",
      "Postal Code": "الرقم البريدي",
      "Delivery Preferences": "تفضيلات التوصيل",
      "Customer Interests": "اهتمامات العميل",
      "Support Rating": "تقييم الدعم",
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
      "createAccount": "انشاء حساب",
      "save": "حفظ",
      "clearFields": "مسح الحقول",
      "InvoiceDate": "تاريخ الفاتورة",
      "details": "تفاصيل",

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
      "image_url": "رابط الصورة",

      "userLogs": "سجلات المستخدم",
      "loginTitle": "تسجيل الدخول",
      "name": "الاسم",
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
      "accountCreated": "تم انشاء الحساب",
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
      "All_Bills": "جميع الفواتير",
      "Bills_on": "الفواتير على",
      "phone": "الهاتف",
      "phone_number": "رقم الهاتف",
      "cannotBeEmpty": "لا يمكن ان يكون فارغ",
      "Register": "تسجيل",
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
      "dontHaveAccountText": "ليس لديك حساب؟ ",
      "printReport": "طباعه التقارير",
      "InvoiceNumber": "رقم الفاتورة",
      "SalesInvoices": "فاتورة مبيعات",
      "CustomerName": "اسم العميل",
      'please_choose_a_category_first': 'يرجى اختيار فئة أولاً',

      "TotalAmount": "اجمالي العناصر قبل الضرائب",
      "Tax": "الضرائب",
      "Deficiencies": "النواقص",
      "AddItem": "اضافة عنصر",
      "dateTodayAndTimeNow": "التاريخ اليوم والوقت الآن",
      "numberOfCategories": "عدد الفئات",
      "totalPaymentsToday": "إجمالي المدفوعات",
      "totalBillExportedToday": "إجمالي الفواتير الصادرة",
      "totalReturnProductsToday": "إجمالي المنتجات المرتجعة",
      "notifications": "الإشعارات",
      "ViewInvoices": "عرض الفواتير",

      // ======================== Catigorys section ===========================
      "Catigorys": "الأصناف",
      "Total_Back_Money": "إجمالي الأموال المستردة",
      "Select_Item": "اختر عنصر",
      "Selected_Item": "العنصر المختار",
      "edit_category": "تعديل الفئة",
      "invoiceID": "رقم الفاتورة",
      "catigoryscreen": "عرض الأصناف",
      "title": "الفئات",
      "No_return_invoices_found": "لم يتم العثور على فواتير الإرجاع.",
      "newalerts": "تنبيهات جديدة",
      "search_categories": "ابحث عن فئة...", "saveInvocis": "حفظ الفواتير",
      "Search_for_a_product": "ابحث عن منتج...",
      "Search_for_an_order": "ابحث عن فاتورة...",
      "Search_for_a_customer": "ابحث عن العملاء...",
      "category_not_available": "الفئة غير متاحة",
      "add_category": "إضافة فئة",
      "add_product": "اضافة منتج",
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
      "purchasePrice": "سعر الشراء",
      "salePrice": "سعر البيع",
      "wholesale_price": "سعر الجملة",
      "taxRate": "معدل الضريبة",
      "quantity": "الكمية",
      "file": "ملف",
      "passoword_or_email_is_empty": "كلمة المرور أو البريد الإلكتروني فارغ",
      "alertQuantity": "كمية التنبيه",
      "image": "الصورة",
      "Click_to_view_all_invoices": "اضغط لعرض جميع الفواتير",
      "date_modified": "تاريخ التعديل",
      "passwordError": "كلمة السري خطاء",
      "emailError": "الحساب خطاء",
      "brand": "العلامة التجارية",
      "size": "الحجم", 'select_where_to_save_pdf': 'اختر مكان حفظ ملف PDF',
      'pdf_saved_to': 'تم حفظ ملف PDF في',
      'failed_to_save_pdf': 'فشل في حفظ ملف PDF',
      'pdf_export_canceled': 'تم إلغاء تصدير ملف PDF',
      'error_saving_pdf': 'خطأ في حفظ ملف PDF',
      "weight": "الوزن",
      "AddAProduc": "اضافة منتج جديد",

      "color": "اللون",
      "ItemID": "رقم المنتج",
      "material": "المادة",
      "warranty": "الضمان",
      "supplier_id": "معرف المورد",
      "returnInvoiceDetails": "تفاصيل فاتورة المرتجع",
      "printOrder": "طباعة الطلب",
      "item_status": "حالة العنصر",
      "active": "اكثر طلبا",
      "inactive": "اقل طلبا",
      "discontinued": "متوسط الطلب",
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
      "searchCustomer": "ابحث عن عميل...",
      "current user login at": "دخول المستخدم الحالي في",
    }

// ============================ arabic Section ==========================
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }
}
