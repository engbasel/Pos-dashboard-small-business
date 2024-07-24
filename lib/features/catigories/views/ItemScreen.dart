import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';

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

  // Future<void> showAddItemDialog(BuildContext context, int categoryId) async {
  //   TextEditingController nameController = TextEditingController();
  //   TextEditingController descriptionController = TextEditingController();
  //   TextEditingController skuController = TextEditingController();
  //   TextEditingController barcodeController = TextEditingController();
  //   TextEditingController purchasePriceController = TextEditingController();
  //   TextEditingController salePriceController = TextEditingController();
  //   TextEditingController wholesalePriceController = TextEditingController();
  //   TextEditingController taxRateController = TextEditingController();
  //   TextEditingController quantityController = TextEditingController();
  //   TextEditingController alertQuantityController = TextEditingController();
  //   TextEditingController imageController = TextEditingController();
  //   TextEditingController brandController = TextEditingController();
  //   TextEditingController sizeController = TextEditingController();
  //   TextEditingController weightController = TextEditingController();
  //   TextEditingController colorController = TextEditingController();
  //   TextEditingController materialController = TextEditingController();
  //   TextEditingController warrantyController = TextEditingController();
  //   TextEditingController supplierIdController = TextEditingController();
  //   TextEditingController itemStatusController = TextEditingController();

  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Add Item'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(labelText: 'Item Name'),
  //               ),
  //               TextField(
  //                 controller: descriptionController,
  //                 decoration: const InputDecoration(labelText: 'Description'),
  //               ),
  //               TextField(
  //                 controller: skuController,
  //                 decoration: const InputDecoration(labelText: 'SKU'),
  //               ),
  //               TextField(
  //                 controller: barcodeController,
  //                 decoration: const InputDecoration(labelText: 'Barcode'),
  //               ),
  //               TextField(
  //                 controller: purchasePriceController,
  //                 decoration:
  //                     const InputDecoration(labelText: 'Purchase Price'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: salePriceController,
  //                 decoration: const InputDecoration(labelText: 'Sale Price'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: wholesalePriceController,
  //                 decoration:
  //                     const InputDecoration(labelText: 'Wholesale Price'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: taxRateController,
  //                 decoration: const InputDecoration(labelText: 'Tax Rate'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: quantityController,
  //                 decoration: const InputDecoration(labelText: 'Quantity'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: alertQuantityController,
  //                 decoration:
  //                     const InputDecoration(labelText: 'Alert Quantity'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: imageController,
  //                 decoration: const InputDecoration(labelText: 'Image'),
  //               ),
  //               TextField(
  //                 controller: brandController,
  //                 decoration: const InputDecoration(labelText: 'Brand'),
  //               ),
  //               TextField(
  //                 controller: sizeController,
  //                 decoration: const InputDecoration(labelText: 'Size'),
  //               ),
  //               TextField(
  //                 controller: weightController,
  //                 decoration: const InputDecoration(labelText: 'Weight'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: colorController,
  //                 decoration: const InputDecoration(labelText: 'Color'),
  //               ),
  //               TextField(
  //                 controller: materialController,
  //                 decoration: const InputDecoration(labelText: 'Material'),
  //               ),
  //               TextField(
  //                 controller: warrantyController,
  //                 decoration: const InputDecoration(labelText: 'Warranty'),
  //               ),
  //               TextField(
  //                 controller: supplierIdController,
  //                 decoration: const InputDecoration(labelText: 'Supplier ID'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: itemStatusController,
  //                 decoration: const InputDecoration(labelText: 'Item Status'),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               if (nameController.text.isNotEmpty) {
  //                 await ItemDatabaseHelper.instance.insertItem(
  //                   ItemModel(
  //                     categoryId: categoryId,
  //                     name: nameController.text,
  //                     description: descriptionController.text,
  //                     sku: skuController.text,
  //                     barcode: barcodeController.text,
  //                     purchasePrice:
  //                         double.tryParse(purchasePriceController.text),
  //                     salePrice: double.tryParse(salePriceController.text),
  //                     wholesalePrice:
  //                         double.tryParse(wholesalePriceController.text),
  //                     taxRate: double.tryParse(taxRateController.text),
  //                     quantity: int.tryParse(quantityController.text),
  //                     alertQuantity: int.tryParse(alertQuantityController.text),
  //                     image: imageController.text,
  //                     brand: brandController.text,
  //                     size: sizeController.text,
  //                     weight: double.tryParse(weightController.text),
  //                     color: colorController.text,
  //                     material: materialController.text,
  //                     warranty: warrantyController.text,
  //                     supplierId: int.tryParse(supplierIdController.text),
  //                     itemStatus: itemStatusController.text,
  //                     dateAdded: DateTime.now(),
  //                     dateModified: DateTime.now(),
  //                   ),
  //                 );
  //                 // Call your method to reload items here
  //                 // loadItems();
  //               }
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<void> showAddItemDialog(BuildContext context, int categoryId) async {
  //   TextEditingController nameController = TextEditingController();
  //   TextEditingController descriptionController = TextEditingController();
  //   TextEditingController skuController = TextEditingController();
  //   TextEditingController barcodeController = TextEditingController();
  //   TextEditingController purchasePriceController = TextEditingController();
  //   TextEditingController salePriceController = TextEditingController();
  //   TextEditingController wholesalePriceController = TextEditingController();
  //   TextEditingController taxRateController = TextEditingController();
  //   TextEditingController quantityController = TextEditingController();
  //   TextEditingController alertQuantityController = TextEditingController();
  //   TextEditingController imageController = TextEditingController();
  //   TextEditingController brandController = TextEditingController();
  //   TextEditingController sizeController = TextEditingController();
  //   TextEditingController weightController = TextEditingController();
  //   TextEditingController colorController = TextEditingController();
  //   TextEditingController materialController = TextEditingController();
  //   TextEditingController warrantyController = TextEditingController();
  //   TextEditingController supplierIdController = TextEditingController();
  //   TextEditingController itemStatusController = TextEditingController();

  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Add Item'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(labelText: 'Item Name'),
  //               ),
  //               TextField(
  //                 controller: descriptionController,
  //                 decoration: const InputDecoration(labelText: 'Description'),
  //               ),
  //               TextField(
  //                 controller: skuController,
  //                 decoration: const InputDecoration(labelText: 'SKU'),
  //               ),
  //               TextField(
  //                 controller: barcodeController,
  //                 decoration: const InputDecoration(labelText: 'Barcode'),
  //               ),
  //               TextField(
  //                 controller: purchasePriceController,
  //                 decoration:
  //                     const InputDecoration(labelText: 'Purchase Price'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: salePriceController,
  //                 decoration: const InputDecoration(labelText: 'Sale Price'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: wholesalePriceController,
  //                 decoration:
  //                     const InputDecoration(labelText: 'Wholesale Price'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: taxRateController,
  //                 decoration: const InputDecoration(labelText: 'Tax Rate'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: quantityController,
  //                 decoration: const InputDecoration(labelText: 'Quantity'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: alertQuantityController,
  //                 decoration:
  //                     const InputDecoration(labelText: 'Alert Quantity'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: imageController,
  //                 decoration: const InputDecoration(labelText: 'Image'),
  //               ),
  //               TextField(
  //                 controller: brandController,
  //                 decoration: const InputDecoration(labelText: 'Brand'),
  //               ),
  //               TextField(
  //                 controller: sizeController,
  //                 decoration: const InputDecoration(labelText: 'Size'),
  //               ),
  //               TextField(
  //                 controller: weightController,
  //                 decoration: const InputDecoration(labelText: 'Weight'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: colorController,
  //                 decoration: const InputDecoration(labelText: 'Color'),
  //               ),
  //               TextField(
  //                 controller: materialController,
  //                 decoration: const InputDecoration(labelText: 'Material'),
  //               ),
  //               TextField(
  //                 controller: warrantyController,
  //                 decoration: const InputDecoration(labelText: 'Warranty'),
  //               ),
  //               TextField(
  //                 controller: supplierIdController,
  //                 decoration: const InputDecoration(labelText: 'Supplier ID'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //               TextField(
  //                 controller: itemStatusController,
  //                 decoration: const InputDecoration(labelText: 'Item Status'),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               // Ensure itemStatus is one of the allowed values
  //               if (nameController.text.isNotEmpty &&
  //                   ['active', 'inactive', 'discontinued']
  //                       .contains(itemStatusController.text)) {
  //                 await ItemDatabaseHelper.instance.insertItem(
  //                   ItemModel(
  //                     categoryId: categoryId,
  //                     name: nameController.text,
  //                     description: descriptionController.text,
  //                     sku: skuController.text,
  //                     barcode: barcodeController.text,
  //                     purchasePrice:
  //                         double.tryParse(purchasePriceController.text),
  //                     salePrice: double.tryParse(salePriceController.text),
  //                     wholesalePrice:
  //                         double.tryParse(wholesalePriceController.text),
  //                     taxRate: double.tryParse(taxRateController.text),
  //                     quantity: int.tryParse(quantityController.text),
  //                     alertQuantity: int.tryParse(alertQuantityController.text),
  //                     image: imageController.text,
  //                     brand: brandController.text,
  //                     size: sizeController.text,
  //                     weight: double.tryParse(weightController.text),
  //                     color: colorController.text,
  //                     material: materialController.text,
  //                     warranty: warrantyController.text,
  //                     supplierId: int.tryParse(supplierIdController.text),
  //                     itemStatus: itemStatusController.text,
  //                     dateAdded: DateTime.now(),
  //                     dateModified: DateTime.now(),
  //                   ),
  //                 );
  //                 loadItems();
  //               } else {
  //                 // Show an error message if the status is invalid
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                       content: Text(
  //                           'Invalid item status. Must be active, inactive, or discontinued.')),
  //                 );
  //               }
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
          title: const Text('Add Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: skuController,
                  decoration: const InputDecoration(labelText: 'SKU'),
                ),
                TextField(
                  controller: barcodeController,
                  decoration: const InputDecoration(labelText: 'Barcode'),
                ),
                TextField(
                  controller: purchasePriceController,
                  decoration:
                      const InputDecoration(labelText: 'Purchase Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: salePriceController,
                  decoration: const InputDecoration(labelText: 'Sale Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: wholesalePriceController,
                  decoration:
                      const InputDecoration(labelText: 'Wholesale Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: taxRateController,
                  decoration: const InputDecoration(labelText: 'Tax Rate'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: alertQuantityController,
                  decoration:
                      const InputDecoration(labelText: 'Alert Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image'),
                ),
                TextField(
                  controller: brandController,
                  decoration: const InputDecoration(labelText: 'Brand'),
                ),
                TextField(
                  controller: sizeController,
                  decoration: const InputDecoration(labelText: 'Size'),
                ),
                TextField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                ),
                TextField(
                  controller: materialController,
                  decoration: const InputDecoration(labelText: 'Material'),
                ),
                TextField(
                  controller: warrantyController,
                  decoration: const InputDecoration(labelText: 'Warranty'),
                ),
                TextField(
                  controller: supplierIdController,
                  decoration: const InputDecoration(labelText: 'Supplier ID'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: itemStatus,
                  decoration: const InputDecoration(labelText: 'Item Status'),
                  items: ['active', 'inactive', 'discontinued']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    itemStatus = value;
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
              child: const Text('Cancel'),
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
                    const SnackBar(
                        content: Text(
                            'Please fill in all required fields and select a valid item status.')),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
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
        title: const Text('Items'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Items',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(child: Text('Item not available'))
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
