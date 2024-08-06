import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/core/widgets/delete_conformation_dialog.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/products/widgets/add_product_dialog.dart';
import 'package:pos_dashboard_v1/features/products/widgets/product_list_item.dart';
import '../../../l10n/app_localizations.dart';
import '../../categories/database/category_database_helper.dart';
import '../../categories/models/category_model.dart';
import '../../categories/models/item_model.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({super.key});

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  final ItemDatabaseHelper itemDatabaseHelper = ItemDatabaseHelper.instance;
  final CategoryDatabaseHelper categoryDatabaseHelper =
      CategoryDatabaseHelper.instance;
  TextEditingController searchController = TextEditingController();

  List<ItemModel> items = [];
  List<ItemModel> filteredItems = [];
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    loadItems();
    loadCategories();
    searchController.addListener(filterItems);
  }

  Future<void> loadItems() async {
    final loadedItems = await itemDatabaseHelper.getAllItems();
    setState(() {
      items = loadedItems;
      filteredItems = loadedItems;
    });
  }

  Future<void> loadCategories() async {
    final loadedCategories = await categoryDatabaseHelper.getCategories();
    setState(() {
      categories = loadedCategories;
    });
  }

  void filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) {
        return item.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> deleteItem(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DeleteConformationDialog();
      },
    );

    if (confirmed == true) {
      await itemDatabaseHelper.deleteItem(id);
      loadItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('Products'),
          actions: [
            CustomSmallButton(
              icon: Icons.add,
              text: AppLocalizations.of(context).translate('AddAProduc'),
              onTap: () => showAddProductDialog(context, categories, loadItems),
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
                hintText: AppLocalizations.of(context)
                    .translate('Search_for_a_product'),
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
        Expanded(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text('cdzfadfadfsdgsfg'),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ProductListItem(
                        item: item,
                        onRemove: () => deleteItem(item.id!),
                        loadItems: loadItems,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
