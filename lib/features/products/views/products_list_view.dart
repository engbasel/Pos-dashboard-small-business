import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/products/views/products_item_details_view.dart';
import '../../../core/db/new_products_store_database_helper.dart';
import '../../categories/database/category_database_helper.dart';
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

  Widget buildInputField(String key, String label) {
    if (['dateTime', 'entryDate', 'exitDate'].contains(key)) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () => selectDate(context, key),
          child: AbsorbPointer(
            child: TextFormField(
              controller: controllers[key],
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate(label),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controllers[key],
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context, String key) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controllers[key]!.text = picked.toIso8601String().split('T')[0];
      });
    }
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
    return Column(
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('Products'),
          actions: [
            CustomSmallButton(
              icon: Icons.add,
              text: 'Add A Product',
              onTap: () => showCustomDialog(context),
            )
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ProductsItemDetailsView(orders: orders),
        ),
      ],
    );
  }

  Widget buildInputSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   AppLocalizations.of(context).translate('addNewOrder'),
            //   style: Theme.of(context).textTheme.titleLarge,
            // ),
            const SizedBox(height: 16),
            buildInputField('id', 'orderId'),
            buildInputField('dateTime', 'dateTime'),
            buildInputField('type', 'orderType'),
            buildInputField('employee', 'employee'),
            buildInputField('status', 'status'),
            buildInputField('amount', 'amount'),
            buildInputField('numberOfItems', 'numberOfItems'),
            buildInputField('entryDate', 'entryDate'),
            buildInputField('exitDate', 'exitDate'),
            buildInputField('wholesalePrice', 'wholesalePrice'),
            buildInputField('retailPrice', 'retailPrice'),
            buildInputField('productStatus', 'productStatus'),
            buildInputField('productDetails', 'productDetails'),
            buildInputField('productModel', 'productModel'),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              onChanged: (newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
              items: paymentMethods.map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)
                    .translate('select_payment_method'),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: showCategoryDialog,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('select_category'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
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

  Widget buildOrdersList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              order.id,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                    '${AppLocalizations.of(context).translate('date')}: ${order.dateTime}'),
                Text(
                    '${AppLocalizations.of(context).translate('amount')}: \$${order.amount.toStringAsFixed(2)}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeOrder(index),
            ),
          ),
        );
      },
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildInputSection(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: addOrder,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate('addOrder'),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
