import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/widgets/item_screen.dart';
import '../../../models/category_model.dart';

class CategoryListView extends StatelessWidget {
  final List<CategoryModel> filteredCategories;
  final Future<void> Function() loadCategories;
  final void Function(int oldIndex, int newIndex) onReorder;
  final void Function(CategoryModel category) showEditCategoryDialog;

  const CategoryListView({
    required this.filteredCategories,
    required this.loadCategories,
    required this.onReorder,
    required this.showEditCategoryDialog,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onReorder: onReorder,
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showEditCategoryDialog(category);
                    },
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
}
