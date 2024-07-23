import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/features/Catigorys/database/Categorydatabase_helper.dart';
import 'package:pos_dashboard_v1/features/Catigorys/widgets/CoustomCatigoryCard.dart';
import '../../../l10n/app_localizations.dart';
import '../models/CategoryModel.dart';

class Catigorysscreen extends StatefulWidget {
  const Catigorysscreen({super.key});

  @override
  _CatigorysscreenState createState() => _CatigorysscreenState();
}

class _CatigorysscreenState extends State<Catigorysscreen> {
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

  Future<void> addCategoryDialog() async {
    TextEditingController categoryNameController = TextEditingController();
    Color pickerColor = Colors.blue;

    void changeColor(Color color) {
      setState(() {
        pickerColor = color;
      });
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                ),
              ),
              const SizedBox(height: 20),
              const Text('Pick a color:'),
              const SizedBox(height: 10),
              BlockPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
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
                if (categoryNameController.text.isNotEmpty) {
                  final category = Category(
                    title: categoryNameController.text,
                    color: pickerColor.value,
                  );
                  await CategoryDatabaseHelper.instance
                      .insertCategory(category);
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
        title: Text(AppLocalizations.of(context).translate('catigoryscreen')),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CoustomCatigoryCard(
                  containerTitle: category.title,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CategoryScreen(category: category);
                        },
                      ),
                    );
                  },
                  bacColor: Color(category.color),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: addCategoryDialog,
            child: const Text('Add Category'),
          ),
        ],
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final Category category;

  const CategoryScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text(category.title),
      ),
    );
  }
}
