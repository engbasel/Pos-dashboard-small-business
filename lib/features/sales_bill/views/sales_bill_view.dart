import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdflib;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_invoices_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_item_model.dart';

import '../../categories/database/category_database_helper.dart';
import '../../categories/models/category_model.dart';
import '../../categories/models/item_model.dart';

class SalesBillScreen extends StatefulWidget {
  const SalesBillScreen({super.key});

  @override
  State<SalesBillScreen> createState() => _SalesBillScreenState();
}

class _SalesBillScreenState extends State<SalesBillScreen> {
  final customerNameController = TextEditingController();
  final invoiceDateController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  ItemModel? _selectedItem;

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

        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('EditItem')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('ProductName')),
                  readOnly: true, // Make the name field read-only
                ),
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('Quantity')),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: unitPriceController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('UnitPrice')),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: discountController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('Discount')),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedItem = SalesItem(
                  item.name,
                  int.tryParse(quantityController.text) ?? item.quantity,
                  double.tryParse(unitPriceController.text) ?? item.unitPrice,
                  double.tryParse(discountController.text) ?? item.discount,
                  item.itemID,
                );
                setState(() {
                  items[index] = updatedItem;
                });
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context).translate('Save')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context).translate('Cancel')),
            ),
          ],
        );
      },
    );
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
      // ignore: avoid_print
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
      // ignore: avoid_print
      print('No file selected');
    }
  }

  Future<void> showAddItemDialog(BuildContext context) async {
    final categoryDatabaseHelper = CategoryDatabaseHelper.instance;
    final itemDatabaseHelper = ItemDatabaseHelper.instance;

    List<CategoryModel> categories =
        await categoryDatabaseHelper.getCategories();
    CategoryModel? selectedCategory;
    ItemModel? selectedItem;

    final result = await showDialog<ItemModel>(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Item'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<CategoryModel>(
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: categories.map((category) {
                        return DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: Text(category.title),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        setDialogState(() {
                          selectedCategory = value;
                          selectedItem = null;
                        });

                        if (selectedCategory != null) {
                          List<ItemModel> items = await itemDatabaseHelper
                              .getItems(selectedCategory!.id as int);
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Select Item'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(items[index].name),
                                        onTap: () {
                                          setDialogState(() {
                                            selectedItem = items[index];
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      value: selectedCategory,
                    ),
                    if (selectedItem != null)
                      Text('Selected Item: ${selectedItem!.name}'),
                    if (selectedCategory == null && selectedItem != null)
                      const Text('Please choose a category first',
                          style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (selectedItem != null) {
                      Navigator.of(context).pop(selectedItem);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please choose an item first')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedItem = result;
        items.add(SalesItem(
          result.name,
          1,
          result.unitPrice as double,
          0,
          result.id as int,
        ));
      });
    }
  }

  double calculateTotalAmount() {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  double calculateGrandTotal() {
    return calculateTotalAmount() + 20; // Assuming a fixed tax for now
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
            const SizedBox(height: 24),
            if (_selectedItem != null) ...[
              Text(
                'Selected Item: ${_selectedItem!.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    label: Text(
                        AppLocalizations.of(context).translate('Product'))),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('Quantity'))),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('UnitPrice'))),
                DataColumn(
                    label:
                        Text(AppLocalizations.of(context).translate('Total'))),
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
                  onSelectChanged: (_) => editItem(index),
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
              onTap: () => showAddItemDialog(context),
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
