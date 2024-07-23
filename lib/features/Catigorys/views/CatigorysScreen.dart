import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/features/Catigorys/widgets/CoustomCatigoryCard.dart';
import '../../../l10n/app_localizations.dart';
import 'CategoryModel.dart';

class Catigorysscreen extends StatefulWidget {
  const Catigorysscreen({super.key});

  @override
  _CatigorysscreenState createState() => _CatigorysscreenState();
}

class _CatigorysscreenState extends State<Catigorysscreen> {
  List<Category> categories = [
    Category(title: 'Catigorey 1', color: Colors.green),
    Category(title: 'Catigorey 2', color: Colors.red),
    Category(title: 'Catigorey 3', color: Colors.amber),
    Category(title: 'Catigorey 4', color: Colors.blue),
  ];

  Future<void> _addCategoryDialog() async {
    TextEditingController categoryNameController = TextEditingController();
    Color pickerColor = Colors.blue;
    Color currentColor = Colors.blue;

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
              onPressed: () {
                if (categoryNameController.text.isNotEmpty) {
                  setState(() {
                    categories.add(Category(
                      title: categoryNameController.text,
                      color: pickerColor,
                    ));
                  });
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
                  bacColor: category.color,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _addCategoryDialog,
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
