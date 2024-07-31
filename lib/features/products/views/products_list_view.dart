import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/image_picker_helper.dart';
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
  TextEditingController searchController = TextEditingController();

  List<ItemModel> items = [];
  List<ItemModel> filteredItems = [];
  List<CategoryModel> categories = [];
  String? selectedCategory;
  String? path;

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
      image: path,
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
    return Column(
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('Products'),
          actions: [
            CustomSmallButton(
              icon: Icons.add,
              text: 'Add A Product',
              onTap: () => showCustomDialog(context),
            ),
            // const SizedBox(width: 8),
            // CustomSmallButton(
            //   icon: Icons.table_chart,
            //   text: 'View Table',
            //   onTap: navigateToItemsTable,
            // ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.white,
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search for a product...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
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
                    child: Text(''),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        elevation: 2,
                        color: ColorsManager.backgroundColor,
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: item.image != null
                              ? Image.file(
                                  File(item.image!),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image, size: 50),
                          title: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
        ),
      ],
    );
  }

  Widget buildInputSection(StateSetter updateState) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final _path = await pickImage();
            if (_path != null) {
              updateState(() {
                path = _path;
              });
            }
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: path != null
                ? Image.file(
                    File(path!),
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.add_a_photo,
                    color: Colors.grey[800],
                  ),
          ),
        ),
        const SizedBox(height: 8),
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
              updateState(() {
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
        const SizedBox(height: 26),
        CustomButton(
          text: AppLocalizations.of(context).translate('add'),
          onTap: addItem,
        ),
      ],
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title:
                  Text(AppLocalizations.of(context).translate('Add a product')),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                height: MediaQuery.of(context).size.height * .75,
                child: SingleChildScrollView(
                  child: buildInputSection(setState),
                ),
              ),
            );
          },
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
