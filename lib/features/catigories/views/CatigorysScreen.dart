import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/features/catigories/database/Categorydatabase_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/views/ItemScreen.dart';
import '../models/CategoryModel.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final data = await CategoryDatabaseHelper.instance.getCategories();
    setState(() {
      categories = data;
    });
  }

  Future<void> _showAddCategoryDialog() async {
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
                  _loadCategories();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category.title),
            tileColor: Color(category.color),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemScreen(categoryId: category.id!),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await CategoryDatabaseHelper.instance
                    .deleteCategory(category.id!);
                _loadCategories();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
