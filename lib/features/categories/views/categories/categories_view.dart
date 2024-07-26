// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
// import 'package:pos_dashboard_v1/features/categories/views/Items/item_screen.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../../models/category_model.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CategoryScreenState createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   List<CategoryModel> categories = [];
//   List<CategoryModel> filteredCategories = [];
//   TextEditingController searchController = TextEditingController();
//   bool isGridView = false; // Track the current view mode

//   @override
//   void initState() {
//     super.initState();
//     loadCategories();
//     searchController.addListener(_filterCategories);
//   }

//   Future<void> loadCategories() async {
//     final data = await CategoryDatabaseHelper.instance.getCategories();
//     setState(() {
//       categories = data;
//       filteredCategories = data;
//     });
//   }

//   void _filterCategories() {
//     final query = searchController.text.toLowerCase();
//     setState(() {
//       filteredCategories = categories.where((category) {
//         return category.title.toLowerCase().contains(query);
//       }).toList();
//     });
//   }

//   Future<void> showAddCategoryDialog() async {
//     TextEditingController titleController = TextEditingController();
//     Color pickerColor = Colors.blue;

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(AppLocalizations.of(context).translate('add_category')),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(
//                   labelText:
//                       AppLocalizations.of(context).translate('category_title'),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(AppLocalizations.of(context).translate('pick_color')),
//               const SizedBox(height: 10),
//               BlockPicker(
//                 pickerColor: pickerColor,
//                 onColorChanged: (color) {
//                   setState(() {
//                     pickerColor = color;
//                   });
//                 },
//               ),
//             ],
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
//                 if (titleController.text.isNotEmpty) {
//                   await CategoryDatabaseHelper.instance.insertCategory(
//                     CategoryModel(
//                       title: titleController.text,
//                       color: pickerColor.value,
//                     ),
//                   );
//                   loadCategories();
//                 }
//                 // ignore: use_build_context_synchronously
//                 Navigator.of(context).pop();
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

//   void _onReorder(int oldIndex, int newIndex) {
//     setState(() {
//       if (newIndex > oldIndex) {
//         newIndex -= 1;
//       }
//       final category = filteredCategories.removeAt(oldIndex);
//       filteredCategories.insert(newIndex, category);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         scrolledUnderElevation: 0,
//         title: Text(AppLocalizations.of(context).translate('title')),
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
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 labelText:
//                     AppLocalizations.of(context).translate('search_categories'),
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: filteredCategories.isEmpty
//                   ? Center(
//                       child: Text(AppLocalizations.of(context)
//                           .translate('category_not_available')),
//                     )
//                   : isGridView
//                       ? buildGridView()
//                       : buildListView(),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showAddCategoryDialog,
//         backgroundColor: ColorsManager.kPrimaryColor,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }

//   Widget buildListView() {
//     return ReorderableListView.builder(
//       onReorder: _onReorder,
//       itemCount: filteredCategories.length,
//       itemBuilder: (context, index) {
//         final category = filteredCategories[index];
//         return Container(
//           padding: const EdgeInsets.all(6),
//           margin: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: Color(category.color),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           key: ValueKey(category.id),
//           child: ListTile(
//             title: Text(
//               category.title,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             trailing: IconButton(
//               icon: const Icon(
//                 Icons.delete,
//                 color: Colors.black,
//               ),
//               onPressed: () async {
//                 await CategoryDatabaseHelper.instance
//                     .deleteCategory(category.id!);
//                 loadCategories();
//               },
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ItemScreen(categoryId: category.id!),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget buildGridView() {
//     return GridView.builder(
//       padding: const EdgeInsets.all(8.0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 5, // Number of cards per row
//         crossAxisSpacing: 16, // Spacing between cards
//         mainAxisSpacing: 16, // Spacing between rows
//       ),
//       itemCount: filteredCategories.length,
//       itemBuilder: (context, index) {
//         final category = filteredCategories[index];
//         return Material(
//           color: Color(category.color),
//           borderRadius: BorderRadius.circular(12),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             key: ValueKey(category.id),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ItemScreen(categoryId: category.id!),
//                 ),
//               );
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//                   Text(
//                     category.title,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           Icons.delete,
//                           color: Colors.black,
//                         ),
//                         onPressed: () async {
//                           await CategoryDatabaseHelper.instance
//                               .deleteCategory(category.id!);
//                           loadCategories();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/item_screen.dart';
import '../../../../l10n/app_localizations.dart';
import '../../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];
  List<CategoryModel> filteredCategories = [];
  TextEditingController searchController = TextEditingController();
  bool isGridView = false;

  @override
  void initState() {
    super.initState();
    loadCategories();
    searchController.addListener(_filterCategories);
  }

  Future<void> loadCategories() async {
    final data = await CategoryDatabaseHelper.instance.getCategories();
    setState(() {
      categories = data;
      filteredCategories = data;
    });
  }

  void _filterCategories() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCategories = categories.where((category) {
        return category.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> showAddCategoryDialog() async {
    TextEditingController titleController = TextEditingController();
    Color pickerColor = Colors.blue;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('add_category')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('category_title'),
                ),
              ),
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context).translate('pick_color')),
              const SizedBox(height: 10),
              BlockPicker(
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  setState(() {
                    pickerColor = color;
                  });
                },
              ),
            ],
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
                if (titleController.text.isNotEmpty) {
                  await CategoryDatabaseHelper.instance.insertCategory(
                    CategoryModel(
                      title: titleController.text,
                      color: pickerColor.value,
                    ),
                  );
                  loadCategories();
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

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final category = filteredCategories.removeAt(oldIndex);
      filteredCategories.insert(newIndex, category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(AppLocalizations.of(context).translate('title')),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('search_categories'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredCategories.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context)
                          .translate('category_not_available')),
                    )
                  : isGridView
                      ? buildGridView()
                      : buildListView(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddCategoryDialog,
        backgroundColor: ColorsManager.kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildListView() {
    return ReorderableListView.builder(
      onReorder: _onReorder,
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(category.color),
            borderRadius: BorderRadius.circular(10),
          ),
          key: ValueKey(category.id),
          child: ListTile(
            title: Text(
              category.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () async {
                await CategoryDatabaseHelper.instance
                    .deleteCategory(category.id!);
                loadCategories();
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemScreen(categoryId: category.id!),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return Material(
          color: Color(category.color),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            key: ValueKey(category.id),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemScreen(categoryId: category.id!),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    category.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          await CategoryDatabaseHelper.instance
                              .deleteCategory(category.id!);
                          loadCategories();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
