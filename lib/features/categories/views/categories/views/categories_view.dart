import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/widgets/category_dialogs.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/widgets/category_grid_view.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/widgets/category_list_view.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../models/category_model.dart';

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
              onTap: () => showAddCategoryDialog(context, loadCategories),
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
                  setState(() {
                    isGridView = !isGridView;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredCategories.isEmpty
              ? const Center(child: Text(''))
              : isGridView
                  ? CategoryGridView(
                      filteredCategories: filteredCategories,
                      loadCategories: loadCategories,
                      showEditCategoryDialog: (category) =>
                          showEditCategoryDialog(
                              context, category, loadCategories),
                    )
                  : CategoryListView(
                      filteredCategories: filteredCategories,
                      loadCategories: loadCategories,
                      onReorder: _onReorder,
                      showEditCategoryDialog: (category) =>
                          showEditCategoryDialog(
                              context, category, loadCategories),
                    ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
