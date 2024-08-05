// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
// import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
// import 'package:pos_dashboard_v1/core/utils/image_picker_helper.dart';
// import 'dart:io';
// import '../../../l10n/app_localizations.dart';
// import '../../categories/database/item_database_helper.dart';
// import '../../categories/models/item_model.dart';

// Future<void> showAddProductDialog(BuildContext context,
//     List<CategoryModel> categories, Future<void> Function() loadItems) async {
//   final itemDatabaseHelper = ItemDatabaseHelper.instance;
//   final formKey = GlobalKey<FormState>();
//   final Map<String, TextEditingController> controllers = {
//     'name': TextEditingController(),
//     'description': TextEditingController(),
//     'sku': TextEditingController(),
//     'barcode': TextEditingController(),
//     'purchasePrice': TextEditingController(),
//     'salePrice': TextEditingController(),
//     'wholesalePrice': TextEditingController(),
//     'taxRate': TextEditingController(),
//     'quantity': TextEditingController(),
//     'alertQuantity': TextEditingController(),
//     'brand': TextEditingController(),
//     'size': TextEditingController(),
//     'weight': TextEditingController(),
//     'color': TextEditingController(),
//     'material': TextEditingController(),
//     'warranty': TextEditingController(),
//   };
//   String? selectedCategory;
//   String? path;

//   void clearTextFields() {
//     controllers.forEach((_, controller) => controller.clear());
//   }

//   Future<void> addItem() async {
//     final categoryId = categories
//         .firstWhere((category) => category.title == selectedCategory)
//         .id!;
//     final newItem = ItemModel(
//       categoryId: categoryId,
//       name: controllers['name']!.text,
//       description: controllers['description']!.text,
//       sku: controllers['sku']!.text,
//       barcode: controllers['barcode']!.text,
//       price: double.tryParse(controllers['purchasePrice']!.text),
//       unitPrice: double.tryParse(controllers['salePrice']!.text),
//       wholesalePrice: double.tryParse(controllers['wholesalePrice']!.text),
//       taxRate: double.tryParse(controllers['taxRate']!.text),
//       quantity: int.tryParse(controllers['quantity']!.text),
//       alertQuantity: int.tryParse(controllers['alertQuantity']!.text),
//       brand: controllers['brand']!.text,
//       size: controllers['size']!.text,
//       weight: double.tryParse(controllers['weight']!.text),
//       color: controllers['color']!.text,
//       material: controllers['material']!.text,
//       warranty: controllers['warranty']!.text,
//       itemStatus: 'active',
//       dateAdded: DateTime.now(),
//       dateModified: DateTime.now(),
//       image: path,
//     );

//     await itemDatabaseHelper.insertItem(newItem);
//     clearTextFields();
//     loadItems();
//     Navigator.of(context).pop();
//   }

//   Widget buildInputSection(StateSetter updateState) {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () async {
//               path = await pickImage();
//               if (path != null) {
//                 updateState(() {
//                   path = path;
//                 });
//               }
//             },
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: path != null
//                   ? Image.file(
//                       File(path!),
//                       fit: BoxFit.cover,
//                     )
//                   : Icon(
//                       Icons.add_a_photo,
//                       color: Colors.grey[800],
//                     ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           ...controllers.entries.map((entry) {
//             final label = entry.key;
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: TextField(
//                 controller: entry.value,
//                 decoration: InputDecoration(
//                   labelText: AppLocalizations.of(context).translate(label),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             );
//           }),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             child: DropdownButtonFormField<String>(
//               value: selectedCategory,
//               items: categories.map((category) {
//                 return DropdownMenuItem<String>(
//                   value: category.title,
//                   child: Text(category.title),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 updateState(() {
//                   selectedCategory = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == null) {
//                   return 'Please select a category';
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                 labelText: AppLocalizations.of(context).translate('category'),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 26),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomButton(
//                   text: AppLocalizations.of(context).translate('cancel'),
//                   onTap: () => Navigator.of(context).pop(),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: CustomButton(
//                   text: AppLocalizations.of(context).translate('add'),
//                   onTap: () {
//                     if (formKey.currentState?.validate() ?? false) {
//                       addItem();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title:
//                 Text(AppLocalizations.of(context).translate('Add a product')),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width * .5,
//               height: MediaQuery.of(context).size.height * .75,
//               child: SingleChildScrollView(
//                 child: buildInputSection(setState),
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
import 'package:pos_dashboard_v1/core/utils/image_picker_helper.dart';
import 'dart:io';
import '../../../l10n/app_localizations.dart';
import '../../categories/database/item_database_helper.dart';
import '../../categories/models/item_model.dart';

Future<void> showAddProductDialog(BuildContext context,
    List<CategoryModel> categories, Future<void> Function() loadItems) async {
  final itemDatabaseHelper = ItemDatabaseHelper.instance;
  final formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'description': TextEditingController(),
    'sku': TextEditingController(),
    'barcode': TextEditingController(),
    'purchasePrice': TextEditingController(),
    'salePrice': TextEditingController(),
    'wholesalePrice': TextEditingController(),
    'taxRate': TextEditingController(),
    'quantity': TextEditingController(),
    'alertQuantity': TextEditingController(),
    'brand': TextEditingController(),
    'size': TextEditingController(),
    'weight': TextEditingController(),
    'color': TextEditingController(),
    'material': TextEditingController(),
    'warranty': TextEditingController(),
  };
  String? selectedCategory;
  String? path;

  void clearTextFields() {
    controllers.forEach((_, controller) => controller.clear());
  }

  Future<void> addItem() async {
    final categoryId = categories
        .firstWhere((category) => category.title == selectedCategory)
        .id!;
    final newItem = ItemModel(
      categoryId: categoryId,
      name: controllers['name']!.text,
      description: controllers['description']!.text,
      sku: controllers['sku']!.text,
      barcode: controllers['barcode']!.text,
      price: double.tryParse(controllers['purchasePrice']!.text),
      unitPrice: double.tryParse(controllers['salePrice']!.text),
      wholesalePrice: double.tryParse(controllers['wholesalePrice']!.text),
      taxRate: double.tryParse(controllers['taxRate']!.text),
      quantity: int.tryParse(controllers['quantity']!.text),
      alertQuantity: int.tryParse(controllers['alertQuantity']!.text),
      brand: controllers['brand']!.text,
      size: controllers['size']!.text,
      weight: double.tryParse(controllers['weight']!.text),
      color: controllers['color']!.text,
      material: controllers['material']!.text,
      warranty: controllers['warranty']!.text,
      itemStatus: 'active',
      dateAdded: DateTime.now(),
      dateModified: DateTime.now(),
      image: path,
    );

    await itemDatabaseHelper.insertItem(newItem);
    clearTextFields();
    await loadItems();
    Navigator.of(context).pop();
  }

  Widget buildInputSection(StateSetter updateState) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              try {
                final selectedPath = await pickImage();
                if (selectedPath != null && File(selectedPath).existsSync()) {
                  updateState(() {
                    path = selectedPath;
                  });
                } else {
                  // Handle case where path is null or file doesn't exist
                  print(
                      'Selected image path is invalid or file does not exist.');
                }
              } catch (e) {
                // Handle error in image picking
                print('Error picking image: $e');
              }
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: path != null
                  ? Image.file(
                      File(path!),
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.add_a_photo,
                      color: Colors.grey[800],
                    ),
            ),
          ),
          const SizedBox(height: 8),
          ...controllers.entries.map((entry) {
            final label = entry.key;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextField(
                controller: entry.value,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate(label),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category.title,
                  child: Text(category.title),
                );
              }).toList(),
              onChanged: (value) {
                updateState(() {
                  selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate('category'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: AppLocalizations.of(context).translate('cancel'),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: AppLocalizations.of(context).translate('add'),
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      addItem();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title:
                Text(AppLocalizations.of(context).translate('Add a product')),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .75,
              child: SingleChildScrollView(
                child: buildInputSection(setState),
              ),
            ),
          );
        },
      );
    },
  );
}
