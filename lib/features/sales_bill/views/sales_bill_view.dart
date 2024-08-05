import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/sales_bill/widgets/edit_item_dialog.dart';
import 'package:pos_dashboard_v1/features/sales_bill/widgets/export_as_pdf.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';
import 'package:pos_dashboard_v1/features/sales_bill/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_item_model.dart';
import 'package:pos_dashboard_v1/features/sales_bill/widgets/sales_invoices_view.dart';
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
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //       content: Text('Please choose an item first')),
                      // );

                      CustomSnackBar.show(
                          context, 'Please choose an item first');
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
        items.add(SalesItem(
          result.name,
          1,
          result.unitPrice?.toDouble() ?? 0.0,
          0,
          result.id as int,
        ));
      });
    }
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
          DateFormat('yyyy-MM-dd ||  HH:mm:ss').format(DateTime.now());
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

  Future<void> removeFromItemsDatabase() async {
    final itemDatabaseHelper = ItemDatabaseHelper.instance;

    for (var item in items) {
      // Fetch the current item details from the database
      final currentItem = await itemDatabaseHelper.getItem(item.itemID);

      if (currentItem == null) {
        // Handle the case where the item does not exist in the database
        CustomSnackBar.show(context, 'Item with ID ${item.itemID} not found');
        return;
      }

      // Calculate the new quantity
      final newQuantity = (currentItem.quantity ?? 0) - (item.quantity);

      if (newQuantity < 0) {
        // Handle the case where the quantity is not sufficient
        CustomSnackBar.show(
            context, 'Not enough stock for ${currentItem.name}');
        return;
      }

      if (newQuantity <= 0) {
        // Delete the item from the database if the quantity is zero or less
        await itemDatabaseHelper.deleteItem(item.itemID);
        CustomSnackBar.show(
            context, 'Item ${currentItem.name} deleted successfully');
      } else {
        // Update the item quantity in the database if it's more than zero
        final updatedItem = currentItem.copyWith(quantity: newQuantity);
        await itemDatabaseHelper.updateItem(updatedItem);
        CustomSnackBar.show(
            context, 'Item ${currentItem.name} quantity updated successfully');
      }
    }
  }

  Future<void> saveData() async {
    try {
      await removeFromItemsDatabase(); // Ensure this completes before saving the invoice

      final newInvoice = SalesInvoice(
        customerName: customerNameController.text,
        invoiceDate: currentDateTime,
        invoiceNumber: invoiceNumberController.text,
        items: List.from(items),
      );

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
            actions: [
              CustomSmallButton(
                icon: Icons.add,
                onTap: () => showAddItemDialog(context),
                text: AppLocalizations.of(context).translate('AddItem'),
              ),
              const SizedBox(height: 12),
              CustomSmallButton(
                icon: Icons.picture_as_pdf,
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
              CustomSmallButton(
                icon: Icons.report,
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
              CustomSmallButton(
                icon: Icons.save,
                onTap: () {
                  saveData();
                },
                text: AppLocalizations.of(context).translate('saveInvocis'),
              ),
            ],
            title: AppLocalizations.of(context).translate('orders'),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: customerNameController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('CustomerName'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${AppLocalizations.of(context).translate('date')} || ${AppLocalizations.of(context).translate('time')}: $currentDateTime',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            '${AppLocalizations.of(context).translate('InvoiceNumber')}: ${invoiceNumberController.text}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // if (_selectedItem != null) ...[
          //   Text(
          //     'Selected Item: ${_selectedItem!.name}',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          //   Text('Quantity: ${_selectedItem!.quantity}'),
          //   Text('Unit Price: \$${_selectedItem!.unitPrice}'),
          //   const SizedBox(height: 24),
          // ],
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
