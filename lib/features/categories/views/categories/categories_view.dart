import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
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
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).translate('add_category')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Text(
                AppLocalizations.of(context).translate('cancel'),
                style: const TextStyle(
                  color: ColorsManager.kPrimaryColor,
                ),
              ),
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
              child: Text(
                AppLocalizations.of(context).translate('add'),
                style: const TextStyle(
                  color: ColorsManager.kPrimaryColor,
                ),
              ),
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
    return Column(
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('title'),
          actions: [
            CustomSmallButton(
              icon: Icons.add,
              text: AppLocalizations.of(context).translate('add_category'),
              onTap: showAddCategoryDialog,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.white,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context).translate('search_categories'),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  isGridView ? Icons.view_list : Icons.view_module,
                  color: const Color(0xff505251),
                ),
                onPressed: () {
                  setState(
                    () {
                      isGridView = !isGridView;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredCategories.isEmpty
              ? const Center(
                  child: Text(''),
                )
              : isGridView
                  ? buildGridView()
                  : buildListView(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildListView() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onReorder: _onReorder,
        itemCount: filteredCategories.length,
        itemBuilder: (context, index) {
          final category = filteredCategories[index];
          return Container(
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.symmetric(vertical: 8),
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
      ),
    );
  }

  Widget buildGridView() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
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
      ),
    );
  }
}
