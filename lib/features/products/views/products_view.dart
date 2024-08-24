import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/Manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/core/widgets/delete_conformation_dialog.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/widgets/item_details_screen.dart';
import 'package:pos_dashboard_v1/features/products/widgets/add_product_dialog.dart';
import 'package:pos_dashboard_v1/features/products/widgets/product_list_item.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

Widget buildGridView(
    BuildContext context, List<ItemModel> filteredItems, Function updateItem) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // 3 cards per row
      childAspectRatio: 3 / 2, // Adjust aspect ratio as needed
      crossAxisSpacing: 8.0, // Space between cards
      mainAxisSpacing: 8.0, // Space between cards
    ),
    itemCount: filteredItems.length,
    itemBuilder: (context, index) {
      final item = filteredItems[index];
      return Card(
        margin: const EdgeInsets.all(8.0),
        color: ColorsManager.backgroundColor,
        child: InkWell(
          onTap: () async {
            // Navigate to ItemDetailsScreen with the selected item
            showDialog(
              context: context,
              builder: (context) => ItemDetailsDialog(item: item),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: item.image != null && item.image!.isNotEmpty
                    ? Image.file(
                        File(item.image!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : const Icon(Icons.image, size: 100),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${item.unitPrice?.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ItemDatabaseHelper itemDatabaseHelper = ItemDatabaseHelper.instance;
  final CategoryDatabaseHelper categoryDatabaseHelper =
      CategoryDatabaseHelper.instance;
  TextEditingController searchController = TextEditingController();
  bool isGridView = false; // Track the current view mode

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
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(isGridView ? Icons.list : Icons.grid_view_outlined),
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
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            child: isGridView
                ? buildGridView(context, filteredItems, loadItems)
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
        const SizedBox(height: 16),
      ],
    );
  }
}
