import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
import 'item_details_screen.dart'; // Import the new ItemDetailsScreen

import '../../../l10n/app_localizations.dart';

class ItemScreen extends StatefulWidget {
  final int categoryId;

  const ItemScreen({super.key, required this.categoryId});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<ItemModel> items = [];
  List<ItemModel> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadItems();
    searchController.addListener(filterItems);
  }

  Future<void> loadItems() async {
    final data = await ItemDatabaseHelper.instance.getItems(widget.categoryId);
    setState(() {
      items = data;
      filteredItems = data;
    });
  }

  void filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) {
        return item.name.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> showAddItemDialog(BuildContext context, int categoryId) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController skuController = TextEditingController();
    TextEditingController barcodeController = TextEditingController();
    TextEditingController purchasePriceController = TextEditingController();
    TextEditingController salePriceController = TextEditingController();
    TextEditingController wholesalePriceController = TextEditingController();
    TextEditingController taxRateController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController alertQuantityController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    TextEditingController sizeController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    TextEditingController materialController = TextEditingController();
    TextEditingController warrantyController = TextEditingController();
    TextEditingController supplierIdController = TextEditingController();
    String? itemStatus;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('add_item')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('item_name')),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('description')),
                ),
                TextField(
                  controller: skuController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).translate('sku')),
                ),
                TextField(
                  controller: barcodeController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('barcode')),
                ),
                TextField(
                  controller: purchasePriceController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('purchase_price')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: salePriceController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('sale_price')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: wholesalePriceController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('wholesale_price')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: taxRateController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('tax_rate')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('quantity')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: alertQuantityController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('alert_quantity')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: imageController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('image')),
                ),
                TextField(
                  controller: brandController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('brand')),
                ),
                TextField(
                  controller: sizeController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('size')),
                ),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('weight')),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: colorController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('color')),
                ),
                TextField(
                  controller: materialController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('material')),
                ),
                TextField(
                  controller: warrantyController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('warranty')),
                ),
                TextField(
                  controller: supplierIdController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('supplier_id')),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: itemStatus,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('item_status')),
                  items: ['active', 'inactive', 'discontinued']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(
                                AppLocalizations.of(context).translate(status)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      itemStatus = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context).translate('cancel')),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty && itemStatus != null) {
                  await ItemDatabaseHelper.instance.insertItem(
                    ItemModel(
                      categoryId: categoryId,
                      name: nameController.text,
                      description: descriptionController.text,
                      sku: skuController.text,
                      barcode: barcodeController.text,
                      purchasePrice:
                          double.tryParse(purchasePriceController.text),
                      salePrice: double.tryParse(salePriceController.text),
                      wholesalePrice:
                          double.tryParse(wholesalePriceController.text),
                      taxRate: double.tryParse(taxRateController.text),
                      quantity: int.tryParse(quantityController.text),
                      alertQuantity: int.tryParse(alertQuantityController.text),
                      image: imageController.text,
                      brand: brandController.text,
                      size: sizeController.text,
                      weight: double.tryParse(weightController.text),
                      color: colorController.text,
                      material: materialController.text,
                      warranty: warrantyController.text,
                      supplierId: int.tryParse(supplierIdController.text),
                      itemStatus: itemStatus!,
                      dateAdded: DateTime.now(),
                      dateModified: DateTime.now(),
                    ),
                  );
                  loadItems();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(AppLocalizations.of(context)
                            .translate('please_fill_required_fields'))),
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context).translate('add')),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('items')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('search_items'),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)
                        .translate('item_not_available')),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await ItemDatabaseHelper.instance
                                .deleteItem(item.id!);
                            loadItems();
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemDetailsScreen(item: item),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddItemDialog(context, widget.categoryId);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
