import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/add_item_dialog.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/edit_item_dialog.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/export_as_pdf.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';
import 'package:pos_dashboard_v1/features/sales_bill/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_item_model.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_invoices_view.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class SalesBillScreen extends StatefulWidget {
  const SalesBillScreen({super.key});

  @override
  State<SalesBillScreen> createState() => _SalesBillScreenState();
}

class _SalesBillScreenState extends State<SalesBillScreen> {
  final customerNameController = TextEditingController();
  late String currentDateTime;
  final invoiceNumberController = TextEditingController();
  ItemModel? _selectedItem;

  final List<SalesItem> items = [];
  static List<SalesInvoice> savedInvoices = [];

  @override
  void initState() {
    super.initState();
    updateDateTime();
    invoiceNumberController.text = '${DateTime.now().millisecondsSinceEpoch}';
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    await SalesDatabaseHelper.instance.ensureDbIsInitialized();
    await loadSavedInvoices();
  }

  Future<void> loadSavedInvoices() async {
    final loadedInvoices =
        await SalesDatabaseHelper.instance.getSalesInvoices();
    setState(() {
      savedInvoices = loadedInvoices;
    });
  }

  double calculateTotalAmount() {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  void updateDateTime() {
    setState(() {
      currentDateTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    });
  }

  double calculateGrandTotal() {
    return calculateTotalAmount() + 20; // Assuming a fixed tax for now
  }

  void editItem(int index) {
    showDialog(
      context: context,
      builder: (context) => EditItemDialog(
        item: items[index],
        onSave: (updatedItem) {
          setState(() {
            items[index] = updatedItem;
          });
        },
      ),
    );
  }

  Future<void> savedata() async {
    final newInvoice = SalesInvoice(
      customerName: customerNameController.text,
      invoiceDate: currentDateTime,
      invoiceNumber: invoiceNumberController.text,
      items: List.from(items),
    );
    try {
      await SalesDatabaseHelper.instance.insertSalesInvoice(newInvoice);
      setState(() {
        savedInvoices.add(newInvoice);
      });
      CustomSnackBar.show(context, 'Invoice saved successfully');
    } catch (e) {
      CustomSnackBar.show(context, 'Error saving invoice: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
            actions: const [],
            title: AppLocalizations.of(context).translate('orders'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: customerNameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('CustomerName'),
            ),
          ),
          const SizedBox(height: 12),
          Text('Date and Time: $currentDateTime'),
          const SizedBox(height: 12),
          Text('Invoice Number: ${invoiceNumberController.text}'),
          const SizedBox(height: 24),
          if (_selectedItem != null) ...[
            Text(
              'Selected Item: ${_selectedItem!.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Quantity: ${_selectedItem!.quantity}'),
            Text('Unit Price: \$${_selectedItem!.unitPrice}'),
            const SizedBox(height: 24),
          ],
          DataTable(
            columns: [
              DataColumn(
                  label: Text(AppLocalizations.of(context).translate('No.'))),
              DataColumn(
                  label:
                      Text(AppLocalizations.of(context).translate('Product'))),
              DataColumn(
                  label:
                      Text(AppLocalizations.of(context).translate('Quantity'))),
              DataColumn(
                  label: Text(
                      AppLocalizations.of(context).translate('UnitPrice'))),
              DataColumn(
                  label: Text(AppLocalizations.of(context).translate('Total'))),
              DataColumn(
                  label:
                      Text(AppLocalizations.of(context).translate('Discount'))),
            ],
            rows: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return DataRow(
                cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(item.name)),
                  DataCell(Text('${item.quantity}')),
                  DataCell(Text('\$${item.unitPrice}')),
                  DataCell(Text('\$${item.total}')),
                  DataCell(Text('\$${item.discount}')),
                ],
                onSelectChanged: (_) => editItem(index),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            '${AppLocalizations.of(context).translate('TotalAmount')} \$${calculateTotalAmount()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            '${AppLocalizations.of(context).translate('Tax')} \$20',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Text(
            '${AppLocalizations.of(context).translate('Total')}: \$${calculateGrandTotal()}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          CustomButton(
            onTap: () => showAddItemDialog(context),
            text: AppLocalizations.of(context).translate('AddItem'),
          ),
          const SizedBox(height: 12),
          CustomButton(
            onTap: () => exportAsPDF(
              context,
              customerNameController.text,
              currentDateTime,
              invoiceNumberController.text,
              items,
              calculateTotalAmount(),
              calculateGrandTotal(),
            ),
            text: AppLocalizations.of(context).translate('ExportasPDF'),
          ),
          const SizedBox(height: 12),
          CustomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalesInvoicesScreen(
                    invoices: savedInvoices,
                  ),
                ),
              );
            },
            text: AppLocalizations.of(context).translate('ViewInvoices'),
          ),
          const SizedBox(height: 12),
          CustomButton(
            onTap: savedata,
            text: AppLocalizations.of(context).translate('حفظ الفواتير'),
          ),
        ],
      ),
    );
  }
}
