import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/features/catigories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/views/Items/ItemScreen.dart';
import '../../../../l10n/app_localizations.dart';
import '../../models/CategoryModel.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = [];
  List<CategoryModel> filteredCategories = [];
  TextEditingController searchController = TextEditingController();
  bool isGridView = false; // Track the current view mode

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
                // ignore: use_build_context_synchronously
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('search_categories'),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemScreen(categoryId: category.id!),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 3 / 2,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemScreen(categoryId: category.id!),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
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
          ),
        );
      },
    );
  }
}
