import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';

Future<void> showAddItemDialog(BuildContext context) async {
  final categoryDatabaseHelper = CategoryDatabaseHelper.instance;
  final itemDatabaseHelper = ItemDatabaseHelper.instance;

  List<CategoryModel> categories = await categoryDatabaseHelper.getCategories();
  CategoryModel? selectedCategory;
  ItemModel? selectedItem;

  final result = await showDialog<ItemModel>(
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
                        setDialogState(() {
                          selectedItem = items.first;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedCategory != null)
                    FutureBuilder<List<ItemModel>>(
                      future: itemDatabaseHelper
                          .getItems(selectedCategory!.id as int),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return const Text('Error loading items');
                        }
                        final items = snapshot.data ?? [];
                        return DropdownButtonFormField<ItemModel>(
                          decoration: const InputDecoration(labelText: 'Item'),
                          items: items.map((item) {
                            return DropdownMenuItem<ItemModel>(
                              value: item,
                              child: Text(item.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedItem = value;
                            });
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (selectedItem != null) {
                    Navigator.pop(context, selectedItem);
                  } else {
                    CustomSnackBar.show(context, 'Please select an item.');
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}

// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
// import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
// import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
// import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
// import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';

// Future<ItemModel?> showAddItemDialog(BuildContext context) async {
//   final categoryDatabaseHelper = CategoryDatabaseHelper.instance;
//   final itemDatabaseHelper = ItemDatabaseHelper.instance;

//   List<CategoryModel> categories = await categoryDatabaseHelper.getCategories();
//   CategoryModel? selectedCategory;
//   ItemModel? selectedItem;

//   final result = await showDialog<ItemModel>(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setDialogState) {
//           return AlertDialog(
//             title: const Text('Select Item'),
//             content: SizedBox(
//               width: double.maxFinite,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   DropdownButtonFormField<CategoryModel>(
//                     decoration: const InputDecoration(labelText: 'Category'),
//                     items: categories.map((category) {
//                       return DropdownMenuItem<CategoryModel>(
//                         value: category,
//                         child: Text(category.title),
//                       );
//                     }).toList(),
//                     onChanged: (value) async {
//                       setDialogState(() {
//                         selectedCategory = value;
//                         selectedItem = null;
//                       });

//                       if (selectedCategory != null) {
//                         List<ItemModel> items = await itemDatabaseHelper
//                             .getItems(selectedCategory!.id as int);
//                         setDialogState(() {
//                           selectedItem = items.isNotEmpty ? items.first : null;
//                         });
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   if (selectedCategory != null)
//                     FutureBuilder<List<ItemModel>>(
//                       future: itemDatabaseHelper
//                           .getItems(selectedCategory!.id as int),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         }
//                         if (snapshot.hasError) {
//                           return const Text('Error loading items');
//                         }
//                         final items = snapshot.data ?? [];
//                         return DropdownButtonFormField<ItemModel>(
//                           decoration: const InputDecoration(labelText: 'Item'),
//                           items: items.map((item) {
//                             return DropdownMenuItem<ItemModel>(
//                               value: item,
//                               child: Text(item.name),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setDialogState(() {
//                               selectedItem = value;
//                             });
//                           },
//                         );
//                       },
//                     ),
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   if (selectedItem != null) {
//                     Navigator.pop(context, selectedItem);
//                   } else {
//                     CustomSnackBar.show(context, 'Please select an item.');
//                   }
//                 },
//                 child: const Text('Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );

//   return result;
// }
