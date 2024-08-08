import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/orders/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import 'package:pos_dashboard_v1/features/orders/model/sales_item_model.dart';
import 'package:pos_dashboard_v1/features/orders/widgets/edit_item_dialog.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';

class AddOrderDialog extends StatefulWidget {
  const AddOrderDialog({super.key, required this.onSave});
  final Function() onSave;
  @override
  State<AddOrderDialog> createState() => _AddOrderDialogState();
}

class _AddOrderDialogState extends State<AddOrderDialog> {
  final customerNameController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final List<SalesItem> items = [];
  late String currentDateTime;

  @override
  void initState() {
    super.initState();
    invoiceNumberController.text = '${DateTime.now().millisecondsSinceEpoch}';
    updateDateTime();
  }

  void updateDateTime() {
    setState(() {
      currentDateTime =
          DateFormat('yyyy-MM-dd ||  HH:mm:ss').format(DateTime.now());
    });
  }

  double calculateTotalAmount() {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  double calculateGrandTotal() {
    return calculateTotalAmount() + 20;
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

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  Future<void> showAddItemDialog(BuildContext context) async {
    final categoryDatabaseHelper = CategoryDatabaseHelper.instance;
    final itemDatabaseHelper = ItemDatabaseHelper.instance;

    List<CategoryModel> categories =
        await categoryDatabaseHelper.getCategories();
    CategoryModel? selectedCategory;
    ItemModel? selectedItem;

    final result = await showDialog<ItemModel>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title:
                  Text(AppLocalizations.of(context).translate('Select_Item')),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<CategoryModel>(
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)
                              .translate('category')),
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
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(AppLocalizations.of(context)
                                    .translate('Select_Item')),
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width * .3,
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
                      Text(
                          '${AppLocalizations.of(context).translate('Selected_Item')}: ${selectedItem!.name}'),
                    if (selectedCategory == null && selectedItem != null)
                      Text(
                          AppLocalizations.of(context)
                              .translate('please_choose_a_category_first'),
                          style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (selectedItem != null) {
                      Navigator.of(context).pop(selectedItem);
                    } else {
                      CustomSnackBar.show(
                          context, 'Please choose an item first');
                    }
                  },
                  child: Text(AppLocalizations.of(context).translate('add')),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context).translate('cancel')),
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

  Future<void> removeFromItemsDatabase() async {
    final itemDatabaseHelper = ItemDatabaseHelper.instance;

    for (var item in items) {
      final currentItem = await itemDatabaseHelper.getItem(item.itemID);

      if (currentItem == null) {
        CustomSnackBar.show(context, 'Item with ID ${item.itemID} not found');
        return;
      }

      final newQuantity = (currentItem.quantity ?? 0) - (item.quantity);

      if (newQuantity < 0) {
        CustomSnackBar.show(
            context, 'Not enough stock for ${currentItem.name}');
        return;
      }

      if (newQuantity <= 0) {
        await itemDatabaseHelper.deleteItem(item.itemID);
        CustomSnackBar.show(
            context, 'Item ${currentItem.name} deleted successfully');
      } else {
        final updatedItem = currentItem.copyWith(quantity: newQuantity);
        await itemDatabaseHelper.updateItem(updatedItem);
        CustomSnackBar.show(
            context, 'Item ${currentItem.name} quantity updated successfully');
      }
    }
  }

  Future<void> saveData() async {
    try {
      await removeFromItemsDatabase();

      final newInvoice = Order(
        customerName: customerNameController.text,
        invoiceDate: currentDateTime,
        invoiceNumber: invoiceNumberController.text,
        items: List.from(items),
      );

      await SalesDatabaseHelper.instance.insertSalesInvoice(newInvoice);
      widget.onSave();
      Navigator.of(context).pop();

      CustomSnackBar.show(context, 'Invoice saved successfully');
    } catch (e) {
      CustomSnackBar.show(context, 'Error saving invoice: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * .7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: customerNameController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('CustomerName'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(
                  flex: 3,
                ),
                Text(
                  '${AppLocalizations.of(context).translate('date')} || ${AppLocalizations.of(context).translate('time')}: $currentDateTime',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                CustomSmallButton(
                  icon: CupertinoIcons.add,
                  onTap: () {
                    showAddItemDialog(context);
                  },
                  text: AppLocalizations.of(context).translate('AddItem'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${AppLocalizations.of(context).translate('InvoiceNumber')}: ${invoiceNumberController.text}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
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
                DataColumn(
                    label:
                        Text(AppLocalizations.of(context).translate('Action'))),
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
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => editItem(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteItem(index),
                          ),
                        ],
                      ),
                    ),
                  ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSmallButton(
                  icon: Icons.cancel,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: AppLocalizations.of(context).translate('Cancel'),
                ),
                const SizedBox(width: 8),
                CustomSmallButton(
                  icon: Icons.save,
                  onTap: () {
                    saveData();
                  },
                  text: AppLocalizations.of(context).translate('save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
