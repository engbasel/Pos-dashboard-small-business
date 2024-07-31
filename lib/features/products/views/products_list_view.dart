import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/products/views/products_item_details_view.dart';
import '../../../core/db/new_products_store_database_helper.dart';
import '../../categories/database/category_database_helper.dart';
import '../../categories/database/item_database_helper.dart';
import 'dart:io';
import '../../categories/models/category_model.dart';
import '../../categories/models/item_model.dart';
import '../../../l10n/app_localizations.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({super.key});

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final CategoryDatabaseHelper categoryDatabaseHelper =
      CategoryDatabaseHelper.instance;
  final ItemDatabaseHelper itemDatabaseHelper = ItemDatabaseHelper.instance;

  List<ItemModel> items = [];
  List<CategoryModel> categories = [];
  String? selectedCategory;

  final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'description': TextEditingController(),
    'sku': TextEditingController(),
    'barcode': TextEditingController(),
    'purchasePrice': TextEditingController(),
    'salePrice': TextEditingController(),
    'wholesalePrice': TextEditingController(),
    'taxRate': TextEditingController(),
    'quantity': TextEditingController(),
    'alertQuantity': TextEditingController(),
    'brand': TextEditingController(),
    'size': TextEditingController(),
    'weight': TextEditingController(),
    'color': TextEditingController(),
    'material': TextEditingController(),
    'warranty': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    loadItems();
    loadCategories();
  }

  Future<void> loadItems() async {
    final loadedItems = await itemDatabaseHelper.getAllItems();
    setState(() {
      items = loadedItems;
    });
  }

  Future<void> loadCategories() async {
    final loadedCategories = await categoryDatabaseHelper.getCategories();
    setState(() {
      categories = loadedCategories;
    });
  }

  Future<void> addItem() async {
    final categoryId = categories
        .firstWhere((category) => category.title == selectedCategory)
        .id!;
    final newItem = ItemModel(
      categoryId: categoryId,
      name: controllers['name']!.text,
      description: controllers['description']!.text,
      sku: controllers['sku']!.text,
      barcode: controllers['barcode']!.text,
      price: double.tryParse(controllers['purchasePrice']!.text),
      unitPrice: double.tryParse(controllers['salePrice']!.text),
      wholesalePrice: double.tryParse(controllers['wholesalePrice']!.text),
      taxRate: double.tryParse(controllers['taxRate']!.text),
      quantity: int.tryParse(controllers['quantity']!.text),
      alertQuantity: int.tryParse(controllers['alertQuantity']!.text),
      brand: controllers['brand']!.text,
      size: controllers['size']!.text,
      weight: double.tryParse(controllers['weight']!.text),
      color: controllers['color']!.text,
      material: controllers['material']!.text,
      warranty: controllers['warranty']!.text,
      itemStatus: 'active',
      dateAdded: DateTime.now(),
      dateModified: DateTime.now(),
    );

    await itemDatabaseHelper.insertItem(newItem);
    clearTextFields();
    loadItems();
    Navigator.of(context).pop();
  }

  Future<void> removeItem(int id) async {
    await itemDatabaseHelper.deleteItem(id);
    loadItems();
  }

  void clearTextFields() {
    controllers.forEach((_, controller) => controller.clear());
    setState(() {
      selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar(
              title: AppLocalizations.of(context).translate('Products'),
              actions: [
                CustomSmallButton(
                  icon: Icons.add,
                  text: 'Add A Product',
                  onTap: () => showCustomDialog(context),
                ),
                CustomSmallButton(
                  icon: Icons.table_chart,
                  text: 'View Table',
                  onTap: navigateToItemsTable,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: item.image != null
                          ? Image.file(
                              File(item.image!),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image, size: 50),
                      title: Text(item.name),
                      subtitle: Text(item.description ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeItem(item.id!),
                      ),
                      onTap: () {
                        // Navigate to details page if needed
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputSection() {
    return Column(
      children: [
        ...controllers.entries.map((entry) {
          final label = entry.key;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: TextField(
              controller: entry.value,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate(label),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: DropdownButtonFormField<String>(
            value: selectedCategory,
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category.title,
                child: Text(category.title),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('category'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: addItem,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(AppLocalizations.of(context).translate('add')),
        ),
      ],
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('add_a_product')),
          content: SingleChildScrollView(
            child: buildInputSection(),
          ),
        );
      },
    );
  }

  void navigateToItemsTable() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductsItemDetailsView(
          orders: [],
        ),
      ),
    );
  }
}
