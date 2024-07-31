import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/products/views/products_item_details_view.dart';
import '../../../core/db/new_products_store_database_helper.dart';
import '../../categories/database/category_database_helper.dart';
import 'dart:io';
import '../../categories/models/category_model.dart';
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

  List<Order> orders = [];
  List<CategoryModel> categories = [];
  String? selectedCategory;
  String? selectedPaymentMethod;
  final List<String> paymentMethods = ['Visa', 'Cash', 'PayPal'];

  final Map<String, TextEditingController> controllers = {
    'id': TextEditingController(),
    'dateTime': TextEditingController(),
    'type': TextEditingController(),
    'employee': TextEditingController(),
    'status': TextEditingController(),
    'amount': TextEditingController(),
    'numberOfItems': TextEditingController(),
    'entryDate': TextEditingController(),
    'exitDate': TextEditingController(),
    'wholesalePrice': TextEditingController(),
    'retailPrice': TextEditingController(),
    'productStatus': TextEditingController(),
    'productDetails': TextEditingController(),
    'productModel': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    loadOrders();
    loadCategories();
    databaseHelper.addCategoryColumn();
  }

  Future<void> loadOrders() async {
    final loadedOrders = await databaseHelper.getOrders();
    setState(() {
      orders = loadedOrders;
    });
  }

  Future<void> loadCategories() async {
    final loadedCategories = await categoryDatabaseHelper.getCategories();
    setState(() {
      categories = loadedCategories;
    });
  }

  Future<void> addOrder() async {
    final newOrder = Order(
      id: controllers['id']!.text,
      dateTime: controllers['dateTime']!.text,
      type: controllers['type']!.text,
      employee: controllers['employee']!.text,
      status: controllers['status']!.text,
      paymentStatus: selectedPaymentMethod ?? '',
      amount: double.tryParse(controllers['amount']!.text) ?? 0,
      numberOfItems: int.tryParse(controllers['numberOfItems']!.text) ?? 0,
      entryDate: controllers['entryDate']!.text,
      exitDate: controllers['exitDate']!.text,
      wholesalePrice: double.tryParse(controllers['wholesalePrice']!.text) ?? 0,
      retailPrice: double.tryParse(controllers['retailPrice']!.text) ?? 0,
      productStatus: controllers['productStatus']!.text,
      productDetails: controllers['productDetails']!.text,
      productModel: controllers['productModel']!.text,
      category: selectedCategory ?? '',
    );

    await databaseHelper.insertOrder(newOrder);
    clearTextFields();
    loadOrders();
    Navigator.of(context).pop();
  }

  Future<void> removeOrder(int index) async {
    final orderToDelete = orders[index];
    await databaseHelper.deleteOrder(orderToDelete.id);
    loadOrders();
  }

  void clearTextFields() {
    controllers.forEach((_, controller) => controller.clear());
    setState(() {
      selectedCategory = null;
      selectedPaymentMethod = null;
    });
  }

  void showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(AppLocalizations.of(context).translate('select_category')),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: categories.map((category) {
                return ListTile(
                  title: Text(category.title),
                  onTap: () {
                    setState(() {
                      selectedCategory = category.title;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void navigateToOrdersTable() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsItemDetailsView(orders: orders),
      ),
    );
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
                  onTap: navigateToOrdersTable,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: order.productDetails.isNotEmpty
                          ? Image.file(
                              File(order.productDetails),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image, size: 50),
                      title: Text(order.id),
                      subtitle: Text(order.dateTime),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeOrder(index),
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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).translate('add_a_product'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: DropdownButtonFormField<String>(
                value: selectedPaymentMethod,
                items: paymentMethods.map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('paymentMethod'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: addOrder,
              child: Text(AppLocalizations.of(context)
                  .translate(' add in catigory related ')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCustomDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('add_a_product')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                buildInputSection(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
