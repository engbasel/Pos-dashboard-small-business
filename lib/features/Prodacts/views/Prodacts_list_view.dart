import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/features/Prodacts/views/products_Item_details_view.dart';
import 'package:pos_dashboard_v1/features/dashboard/services/order_service.dart';
import '../../../core/db/new_products_store_database_helper.dart';
import '../../../features/categories/database/category_database_helper.dart';
import '../../../features/categories/models/category_model.dart';
import '../../../l10n/app_localizations.dart'; // Import your localization file.

class OrdersListView extends StatefulWidget {
  final ValueChanged<int> onProductsCountChanged;

  const OrdersListView({super.key, required this.onProductsCountChanged});

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final CategoryDatabaseHelper categoryDatabaseHelper =
      CategoryDatabaseHelper.instance;

  List<Order> orders = [];
  List<CategoryModel> categories = [];
  String? selectedCategory;
  String? selectedPaymentMethod;
  final List<String> paymentMethods = ['Visa', 'Cash', 'PayPal'];
  // ignore: unused_field
  final OrderService _orderService = OrderService();

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
    databaseHelper.addCategoryColumn(); // Add this
  }

  Future<void> addCategoryColumn() async {
    final db = await databaseHelper.database;
    await db.execute('ALTER TABLE orders ADD COLUMN category TEXT');
  }

  Future<void> loadOrders() async {
    final loadedOrders = await databaseHelper.getOrders();
    setState(() {
      orders = loadedOrders;
      widget.onProductsCountChanged(orders.length);
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
  }

  Future<void> removeOrder(int index) async {
    final orderToDelete = orders[index];
    await databaseHelper.deleteOrder(orderToDelete.id);
    loadOrders();
  }

  Future<void> updateOrder(int index) async {
    final updatedOrder = Order(
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

    await databaseHelper.updateOrder(updatedOrder);
    clearTextFields();
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
        builder: (context) => OrderDetailsScreen(orders: orders),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('orderList')),
        actions: [
          IconButton(
            icon: const Icon(Icons.table_view),
            onPressed: navigateToOrdersTable,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputSection(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: addOrder,
                child: Text(AppLocalizations.of(context).translate('addOrder')),
              ),
              const SizedBox(height: 16),
              _buildOrdersList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...controllers.entries.map((entry) => TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate(entry.key),
                  ),
                )),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              onChanged: (newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
              items: paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              hint: Text(AppLocalizations.of(context)
                  .translate('select_payment_method')),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: showCategoryDialog,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('select_category'),
                ),
                child: Text(
                  selectedCategory ??
                      AppLocalizations.of(context).translate('category'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          child: ListTile(
            title: Text(order.id),
            subtitle:
                Text(AppLocalizations.of(context).translate('order_details')),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => removeOrder(index),
            ),
          ),
        );
      },
    );
  }
}
