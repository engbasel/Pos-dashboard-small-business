import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/features/catigories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/views/ItemScreen.dart';
import '../models/CategoryModel.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> categories = [];
  List<Category> filteredCategories = [];
  TextEditingController searchController = TextEditingController();

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
          title: const Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Category Title'),
              ),
              const SizedBox(height: 20),
              const Text('Pick a color:'),
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  await CategoryDatabaseHelper.instance.insertCategory(
                    Category(
                      title: titleController.text,
                      color: pickerColor.value,
                    ),
                  );
                  loadCategories();
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
        title: const Text('Categories'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Categories',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: filteredCategories.isEmpty
                ? const Center(child: Text('Category not available'))
                : ListView.builder(
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemScreen(categoryId: category.id!),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(category.color),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.title,
                                style: const TextStyle(fontSize: 18),
                              ),
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
                        ),
                      );

                      //  Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ListTile(
                      //     title: Text(category.title),
                      //     tileColor: Color(category.color),
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) =>
                      //               ItemScreen(categoryId: category.id!),
                      //         ),
                      //       );
                      //     },
                      //     trailing: IconButton(
                      //       icon: const Icon(
                      //         Icons.delete,
                      //         color: Colors.black,
                      //       ),
                      //       onPressed: () async {
                      //         await CategoryDatabaseHelper.instance
                      //             .deleteCategory(category.id!);
                      //         loadCategories();
                      //       },
                      //     ),
                      //   ),
                      // );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
