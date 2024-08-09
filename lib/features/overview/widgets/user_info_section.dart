import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/orders/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/overview/views/ReturnInvoicesScreen.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/custom_label.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import '../../../core/utils/manager/manager.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class UserInfoSection extends StatefulWidget {
  const UserInfoSection({super.key});

  @override
  State<UserInfoSection> createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  late Timer _timer;
  late String _currentDateTime;
  final ValueNotifier<int> _categoryCountNotifier = ValueNotifier<int>(0);
  late Future<List<ItemModel>> itemsBelowAlertQuantity;
  int? itemsNum;
  late Future<int> savedBillsCountFuture;
  DateTime? _selectedDate;
  late Future<List<ReturnInvoiceModel>> _returnInvoicesFuture;
  final DatabaseReturnsInvoice _databaseHelper = DatabaseReturnsInvoice();

  @override
  void initState() {
    super.initState();
    updateDateTime();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => updateDateTime());
    loadCategoryCount();
    itemsBelowAlertQuantity = fetchItemsBelowAlertQuantity();
    savedBillsCountFuture = fetchSavedBillsCount();

    fetchItemsBelowAlertQuantity().then((items) {
      setState(() {
        itemsBelowAlertQuantity = Future.value(items);
        itemsNum = items.length;
      });
    });

    _returnInvoicesFuture = _databaseHelper.getReturnInvoices();
  }

  @override
  void dispose() {
    _timer.cancel();
    _categoryCountNotifier.dispose();
    super.dispose();
  }

  Future<List<ItemModel>> fetchItemsBelowAlertQuantity() async {
    final dbHelper = ItemDatabaseHelper.instance;
    return await dbHelper.getItemsBelowAlertQuantity();
  }

  Future<int> fetchSavedBillsCount() async {
    return await SalesDatabaseHelper.instance.getSavedBillsCount();
  }

  void updateDateTime() {
    setState(() {
      _currentDateTime = getCurrentDateTime();
    });
  }

  String getCurrentDateTime() {
    final now = DateTime.now();
    final dayFormatter = DateFormat('EEEE');
    final dateTimeFormatter = DateFormat('MMM dd, yyyy hh:mm:ss a');
    return '${dayFormatter.format(now)} ${dateTimeFormatter.format(now)}';
  }

  Future<void> loadCategoryCount() async {
    int count = await CategoryDatabaseHelper.instance.getCategoryCount();
    _categoryCountNotifier.value = count;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _returnInvoicesFuture = _databaseHelper.getInvoicesByDay(
          DateFormat('yyyy-MM-dd').format(_selectedDate!),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomLabel(
                  color: const Color(0xfff3e5f5),
                  labelValue: appLocalizations.translate('dateTodayAndTimeNow'),
                  content: _currentDateTime,
                  imagename: ImagesManger.edit,
                ),
                ValueListenableBuilder<int>(
                  valueListenable: _categoryCountNotifier,
                  builder: (context, categoryCount, child) {
                    return CustomLabel(
                      color: const Color(0xfffff2cc),
                      labelValue:
                          appLocalizations.translate('numberOfCategories'),
                      content: '$categoryCount Categories',
                      imagename: ImagesManger.mail,
                    );
                  },
                ),
                FutureBuilder<int>(
                  future: savedBillsCountFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomLabel(
                        color: const Color(0xffe0f7fa),
                        labelValue: appLocalizations
                            .translate('totalBillExportedToday'),
                        content: 'Loading...',
                        imagename: ImagesManger.shoppingbag,
                      );
                    } else if (snapshot.hasError) {
                      return CustomLabel(
                        color: const Color(0xffe0f7fa),
                        labelValue: appLocalizations
                            .translate('totalBillExportedToday'),
                        content: 'Error',
                        imagename: ImagesManger.shoppingbag,
                      );
                    } else {
                      return CustomLabel(
                        color: const Color(0xffe0f7fa),
                        labelValue: appLocalizations
                            .translate('totalBillExportedToday'),
                        content: '${snapshot.data ?? 0}',
                        imagename: ImagesManger.shoppingbag,
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomLabel(
                  color: const Color(0xffffebee),
                  labelValue:
                      appLocalizations.translate('current user login at'),
                  content: '10:34:5 AM',
                  imagename: ImagesManger.agency,
                ),
                CustomLabel(
                  color: const Color(0xfffff3e0),
                  labelValue: appLocalizations.translate('notifications'),
                  content:
                      '${appLocalizations.translate('newalerts')} ${itemsNum.toString()}',
                  imagename: ImagesManger.notofication,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ReturnInvoicesScreen(),
                      ),
                    );
                  },
                  child: CustomLabel(
                    color: const Color(0xffe8f5e9),
                    labelValue:
                        appLocalizations.translate('totalReturnProductsToday'),
                    content: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : 'John Doe - Cashier',
                    imagename: ImagesManger.sex,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // FutureBuilder<List<ReturnInvoiceModel>>(
            //   future: _returnInvoicesFuture,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return const Center(child: Text('No return invoices found.'));
            //     } else {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         physics: const NeverScrollableScrollPhysics(),
            //         itemCount: snapshot.data!.length,
            //         itemBuilder: (context, index) {
            //           final invoice = snapshot.data![index];
            //           return ListTile(
            //             title: Text('Invoice ID: ${invoice.id}'),
            //             subtitle: Text(
            //               'Order ID: ${invoice.orderId}\n'
            //               'Return Date: ${invoice.returnDate}\n'
            //               'Employee: ${invoice.employee}\n'
            //               'Reason: ${invoice.reason}\n'
            //               'Amount: ${invoice.amount}\n'
            //               'Total Back Money: ${invoice.totalbackmony}',
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
