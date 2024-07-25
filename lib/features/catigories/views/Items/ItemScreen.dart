// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/catigories/database/item_database_helper.dart';
// import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
// import 'ItemDetailsScreen.dart'; // Import the updated ItemDetailsScreen

// import '../../../../l10n/app_localizations.dart';

// class ItemScreen extends StatefulWidget {
//   final int categoryId;

//   const ItemScreen({super.key, required this.categoryId});

//   @override
//   _ItemScreenState createState() => _ItemScreenState();
// }

// class _ItemScreenState extends State<ItemScreen> {
//   List<ItemModel> items = [];
//   List<ItemModel> filteredItems = [];
//   TextEditingController searchController = TextEditingController();
//   bool isGridView = false; // Track the current view mode

//   @override
//   void initState() {
//     super.initState();
//     loadItems();
//     searchController.addListener(filterItems);
//   }

//   Future<void> loadItems() async {
//     final data = await ItemDatabaseHelper.instance.getItems(widget.categoryId);
//     setState(() {
//       items = data;
//       filteredItems = data;
//     });
//   }

//   void filterItems() {
//     final query = searchController.text.toLowerCase();
//     setState(() {
//       filteredItems = items.where((item) {
//         return item.name.toLowerCase().contains(query) ||
//             item.description.toLowerCase().contains(query);
//       }).toList();
//     });
//   }

//   Future<void> showAddItemDialog(BuildContext context, int categoryId) async {
//     final formKey = GlobalKey<FormState>(); // Key to validate form
//     TextEditingController nameController = TextEditingController();
//     TextEditingController descriptionController = TextEditingController();
//     TextEditingController skuController = TextEditingController();
//     TextEditingController barcodeController = TextEditingController();
//     TextEditingController purchasePriceController = TextEditingController();
//     TextEditingController salePriceController = TextEditingController();
//     TextEditingController wholesalePriceController = TextEditingController();
//     TextEditingController taxRateController = TextEditingController();
//     TextEditingController quantityController = TextEditingController();
//     TextEditingController alertQuantityController = TextEditingController();
//     TextEditingController imageController = TextEditingController();
//     TextEditingController brandController = TextEditingController();
//     TextEditingController sizeController = TextEditingController();
//     TextEditingController weightController = TextEditingController();
//     TextEditingController colorController = TextEditingController();
//     TextEditingController materialController = TextEditingController();
//     TextEditingController warrantyController = TextEditingController();
//     TextEditingController supplierIdController = TextEditingController();
//     String? itemStatus;

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(AppLocalizations.of(context).translate('add_item')),
//           content: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('item_name')),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppLocalizations.of(context)
//                             .translate('name_required');
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: descriptionController,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('description')),
//                   ),
//                   TextFormField(
//                     controller: skuController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('sku')),
//                   ),
//                   TextFormField(
//                     controller: barcodeController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('barcode')),
//                   ),
//                   TextFormField(
//                     controller: purchasePriceController,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('purchase_price')),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppLocalizations.of(context)
//                             .translate('purchase_price_required');
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: salePriceController,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('sale_price')),
//                     keyboardType: TextInputType.number,
//                   ),
//                   TextFormField(
//                     controller: wholesalePriceController,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('wholesale_price')),
//                     keyboardType: TextInputType.number,
//                   ),
//                   TextFormField(
//                     controller: taxRateController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('tax_rate')),
//                     keyboardType: TextInputType.number,
//                   ),
//                   TextFormField(
//                     controller: quantityController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('quantity')),
//                     keyboardType: TextInputType.number,
//                   ),
//                   TextFormField(
//                     controller: alertQuantityController,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('alert_quantity')),
//                     keyboardType: TextInputType.number,
//                   ),
//                   TextFormField(
//                     controller: imageController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('image')),
//                   ),
//                   TextFormField(
//                     controller: brandController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('brand')),
//                   ),
//                   TextFormField(
//                     controller: sizeController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('size')),
//                   ),
//                   TextFormField(
//                     controller: weightController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('weight')),
//                     keyboardType: TextInputType.number,
//                   ),
//                   TextFormField(
//                     controller: colorController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('color')),
//                   ),
//                   TextFormField(
//                     controller: materialController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('material')),
//                   ),
//                   TextFormField(
//                     controller: warrantyController,
//                     decoration: InputDecoration(
//                         labelText:
//                             AppLocalizations.of(context).translate('warranty')),
//                   ),
//                   TextFormField(
//                     controller: supplierIdController,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('supplier_id')),
//                     keyboardType: TextInputType.number,
//                   ),
//                   DropdownButtonFormField<String>(
//                     value: itemStatus,
//                     decoration: InputDecoration(
//                         labelText: AppLocalizations.of(context)
//                             .translate('item_status')),
//                     items: ['active', 'inactive', 'discontinued']
//                         .map((status) => DropdownMenuItem(
//                               value: status,
//                               child: Text(AppLocalizations.of(context)
//                                   .translate(status)),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         itemStatus = value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null) {
//                         return AppLocalizations.of(context)
//                             .translate('status_required');
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(AppLocalizations.of(context).translate('cancel')),
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (formKey.currentState?.validate() ?? false) {
//                   await ItemDatabaseHelper.instance.insertItem(
//                     ItemModel(
//                       id: categoryId,
//                       name: nameController.text,
//                       description: descriptionController.text,
//                       sku: skuController.text,
//                       barcode: barcodeController.text,
//                       purchasePrice:
//                           double.tryParse(purchasePriceController.text),
//                       salePrice: double.tryParse(salePriceController.text),
//                       wholesalePrice:
//                           double.tryParse(wholesalePriceController.text),
//                       taxRate: double.tryParse(taxRateController.text),
//                       quantity: int.tryParse(quantityController.text),
//                       alertQuantity: int.tryParse(alertQuantityController.text),
//                       image: imageController.text,
//                       brand: brandController.text,
//                       size: sizeController.text,
//                       weight: double.tryParse(weightController.text),
//                       color: colorController.text,
//                       material: materialController.text,
//                       warranty: warrantyController.text,
//                       supplierId: int.tryParse(supplierIdController.text),
//                       itemStatus: itemStatus!,
//                       dateAdded: DateTime.now(),
//                       dateModified: DateTime.now(),
//                     ),
//                   );
//                   loadItems();
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text(AppLocalizations.of(context).translate('add')),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   Future<void> updateItem(ItemModel updatedItem) async {
//     final index = items.indexWhere((item) => item.id == updatedItem.id);
//     if (index != -1) {
//       setState(() {
//         items[index] = updatedItem;
//         filteredItems[index] = updatedItem;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context).translate('items')),
//         actions: [
//           IconButton(
//             icon: Icon(isGridView ? Icons.view_list : Icons.view_module),
//             onPressed: () {
//               setState(() {
//                 isGridView = !isGridView;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 labelText:
//                     AppLocalizations.of(context).translate('search_items'),
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: filteredItems.isEmpty
//                 ? Center(
//                     child: Text(AppLocalizations.of(context)
//                         .translate('item_not_available')),
//                   )
//                 : isGridView
//                     ? buildGridView()
//                     : buildListView(),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showAddItemDialog(context, widget.categoryId);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget buildListView() {
//     return ListView.builder(
//       itemCount: filteredItems.length,
//       itemBuilder: (context, index) {
//         final item = filteredItems[index];
//         return ListTile(
//           title: Text(item.name),
//           subtitle: Text(item.description),
//           trailing: IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () async {
//               await ItemDatabaseHelper.instance.deleteItem(item.id!);
//               loadItems();
//             },
//           ),
//           onTap: () async {
//             final result = await Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ItemDetailsScreen(item: item),
//               ),
//             );
//             if (result != null && result is ItemModel) {
//               updateItem(result);
//             }
//           },
//         );
//       },
//     );
//   }

//   Widget buildGridView() {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 5,
//         childAspectRatio: 3 / 2,
//       ),
//       itemCount: filteredItems.length,
//       itemBuilder: (context, index) {
//         final item = filteredItems[index];
//         return GestureDetector(
//           onTap: () async {
//             final result = await Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ItemDetailsScreen(item: item),
//               ),
//             );
//             if (result != null && result is ItemModel) {
//               updateItem(result);
//             }
//           },
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12,
//                   offset: Offset(0, 2),
//                   blurRadius: 6,
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(fontSize: 18),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   item.description,
//                   style: const TextStyle(fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
import 'ItemDetailsScreen.dart'; // Import the updated ItemDetailsScreen
import '../../../../l10n/app_localizations.dart';

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
  bool isGridView = false; // Track the current view mode

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
    final formKey = GlobalKey<FormState>(); // Key to validate form
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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextFormField(
                  //   controller: nameController,
                  //   decoration: InputDecoration(
                  //       labelText: AppLocalizations.of(context)
                  //           .translate('item_name')),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return AppLocalizations.of(context)
                  //           .translate('name_required');
                  //     }
                  //     return null;
                  //   },
                  // ),

                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('item_name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('name_required');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('description')),
                  ),
                  TextFormField(
                    controller: skuController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('sku')),
                  ),
                  TextFormField(
                    controller: barcodeController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('barcode')),
                  ),
                  TextFormField(
                    controller: purchasePriceController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('purchase_price')),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('purchase_price_required');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: salePriceController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('sale_price')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: wholesalePriceController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('wholesale_price')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: taxRateController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('tax_rate')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('quantity')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: alertQuantityController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('alert_quantity')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: imageController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('image')),
                  ),
                  TextFormField(
                    controller: brandController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('brand')),
                  ),
                  TextFormField(
                    controller: sizeController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('size')),
                  ),
                  TextFormField(
                    controller: weightController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('weight')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: colorController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('color')),
                  ),
                  TextFormField(
                    controller: materialController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('material')),
                  ),
                  TextFormField(
                    controller: warrantyController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('warranty')),
                  ),
                  TextFormField(
                    controller: supplierIdController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('supplier_id')),
                    keyboardType: TextInputType.number,
                  ),

                  // Add other TextFormFields here as before...
                  DropdownButtonFormField<String>(
                    value: itemStatus,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('item_status')),
                    items: ['active', 'inactive', 'discontinued']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(AppLocalizations.of(context)
                                  .translate(status)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        itemStatus = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return AppLocalizations.of(context)
                            .translate('status_required');
                      }
                      return null;
                    },
                  ),
                ],
              ),
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
                if (formKey.currentState?.validate() ?? false) {
                  await ItemDatabaseHelper.instance.insertItem(
                    ItemModel(
                      id: null, // Let SQLite auto-generate the ID
                      categoryId: widget.categoryId,
                      name: nameController.text,
                      description: descriptionController.text,
                      sku: skuController.text,
                      barcode: barcodeController.text,
                      purchasePrice:
                          double.tryParse(purchasePriceController.text) ?? 0.0,
                      salePrice:
                          double.tryParse(salePriceController.text) ?? 0.0,
                      wholesalePrice:
                          double.tryParse(wholesalePriceController.text) ?? 0.0,
                      taxRate: double.tryParse(taxRateController.text) ?? 0.0,
                      quantity: int.tryParse(quantityController.text) ?? 0,
                      alertQuantity:
                          int.tryParse(alertQuantityController.text) ?? 0,
                      image: imageController.text,
                      brand: brandController.text,
                      size: sizeController.text,
                      weight: double.tryParse(weightController.text) ?? 0.0,
                      color: colorController.text,
                      material: materialController.text,
                      warranty: warrantyController.text,
                      supplierId: int.tryParse(supplierIdController.text) ?? 0,
                      itemStatus: itemStatus ?? 'active',
                      // dateAdded: DateTime.now().toIso8601String(),
                      // dateModified: DateTime.now().toIso8601String(),
                    ),
                  );
                  loadItems();
                  Navigator.of(context).pop();
                }
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

  Future<void> updateItem(ItemModel updatedItem) async {
    final index = items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      setState(() {
        items[index] = updatedItem;
        filteredItems[index] = updatedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('items')),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.view_module),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
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
                : isGridView
                    ? buildGridView()
                    : buildListView(),
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

  Widget buildListView() {
    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await ItemDatabaseHelper.instance.deleteItem(item.id!);
              loadItems();
            },
          ),
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ItemDetailsScreen(item: item),
              ),
            );
            if (result != null && result is ItemModel) {
              updateItem(result);
            }
          },
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 3 / 2,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return GestureDetector(
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ItemDetailsScreen(item: item),
              ),
            );
            if (result != null && result is ItemModel) {
              updateItem(result);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.image, // Placeholder icon for image
                      size: 50,
                    ),
                  ),
                ),
                Text(item.name, overflow: TextOverflow.ellipsis),
                Text(item.description, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        );
      },
    );
  }
}
