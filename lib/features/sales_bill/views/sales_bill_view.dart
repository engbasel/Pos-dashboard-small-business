import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdflib;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_invoices_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_item_model.dart';

class SalesBillScreen extends StatefulWidget {
  const SalesBillScreen({super.key});

  @override
  State<SalesBillScreen> createState() => _SalesBillScreenState();
}

class _SalesBillScreenState extends State<SalesBillScreen> {
  final customerNameController = TextEditingController();
  final invoiceDateController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final List<SalesItem> items = [];
  static List<SalesInvoice> savedInvoices = []; // Store saved invoices

  @override
  void initState() {
    super.initState();
    customerNameController.text = 'John Doe';
    invoiceDateController.text = 'July 17, 2024';
    invoiceNumberController.text = '12345';
    items.add(SalesItem('Product 1', 2, 50, 10, 1));
  }

  Future<void> exportAsPDF() async {
    final pdf = pdflib.Document();
    pdf.addPage(
      pdflib.Page(
        build: (context) => pdflib.Column(
          crossAxisAlignment: pdflib.CrossAxisAlignment.start,
          children: [
            pdflib.Text('Customer Name: ${customerNameController.text}'),
            pdflib.Text('Date: ${invoiceDateController.text}'),
            pdflib.Text('Invoice Number: ${invoiceNumberController.text}'),
            pdflib.SizedBox(height: 12),
            pdflib.Text('Items:'),
            pdflib.SizedBox(height: 12),
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return pdflib.Row(
                mainAxisAlignment: pdflib.MainAxisAlignment.spaceBetween,
                children: [
                  pdflib.Text('${index + 1}'), // Counter for item number
                  pdflib.Text(item.name),
                  pdflib.Text('Quantity: ${item.quantity}'),
                  pdflib.Text('Unit Price: \$${item.unitPrice}'),
                  pdflib.Text('Total: \$${item.total}'),
                  pdflib.Text('Discount: \$${item.discount}'),
                ],
              );
            }),
            pdflib.SizedBox(height: 12),
            pdflib.Text('Total Amount: \$${calculateTotalAmount()}'),
            pdflib.SizedBox(height: 12),
            pdflib.Text('Tax: \$20'),
            pdflib.SizedBox(height: 12),
            pdflib.Text('Grand Total: \$${calculateGrandTotal()}'),
          ],
        ),
      ),
    );

    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF',
      fileName: '${customerNameController.text}.pdf',
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = File(result);
      await file.writeAsBytes(await pdf.save());
      print('PDF saved to ${file.path}');

      // Save invoice data
      setState(() {
        savedInvoices.add(
          SalesInvoice(
            customerName: customerNameController.text,
            invoiceDate: invoiceDateController.text,
            invoiceNumber: invoiceNumberController.text,
            items: List.from(items), // Ensure items are copied
          ),
        );
      });
    } else {
      print('No file selected');
    }
  }

  double calculateTotalAmount() {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  double calculateGrandTotal() {
    return calculateTotalAmount() + 20; // Assuming a fixed tax for now
  }

  void addItem() {
    setState(() {
      items.add(SalesItem('', 1, 0, 0, 0));
    });
  }

  void editItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final item = items[index];
        final nameController = TextEditingController(text: item.name);
        final quantityController =
            TextEditingController(text: item.quantity.toString());
        final unitPriceController =
            TextEditingController(text: item.unitPrice.toString());
        final discountController =
            TextEditingController(text: item.discount.toString());
        final itemIdController =
            TextEditingController(text: item.itemID.toString());

        return AlertDialog(
          title: const Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: unitPriceController,
                decoration: const InputDecoration(labelText: 'Unit Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: discountController,
                decoration: const InputDecoration(labelText: 'Discount'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: itemIdController,
                decoration: const InputDecoration(labelText: 'Item ID'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedItem = SalesItem(
                  nameController.text.isNotEmpty
                      ? nameController.text
                      : 'Unknown',
                  int.tryParse(quantityController.text) ?? 1,
                  double.tryParse(unitPriceController.text) ?? 0.0,
                  double.tryParse(discountController.text) ?? 0.0,
                  int.tryParse(itemIdController.text) ?? 0,
                );
                setState(() {
                  items[index] = updatedItem;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('SalesBill')),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: customerNameController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('CustomerName'),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: invoiceDateController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate('Data'),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: invoiceNumberController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('InvoiceNumber'),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  AppLocalizations.of(context).translate('No.'),
                )),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('Product'))),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('Quantity'))),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('UnitPrice'))),
                DataColumn(
                  label: Text(
                    AppLocalizations.of(context).translate('Total'),
                  ),
                ),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('Discount'))),
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
                  onSelectChanged: (selected) {
                    if (selected != null && selected) {
                      editItem(index);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              ' ${AppLocalizations.of(context).translate('TotalAmount')} \$${calculateTotalAmount()}',
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
              onTap: addItem,
              text: AppLocalizations.of(context).translate('AddItem'),
            ),
            const SizedBox(height: 12),
            CustomButton(
              onTap: exportAsPDF,
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
            )
          ],
        ),
      ),
    );
  }
}
