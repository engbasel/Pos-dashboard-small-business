import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/features/overview/services/order_service.dart';
import '../../../core/db/new_products_store_database_helper.dart';
import '../../../features/categories/database/category_database_helper.dart';
import '../../../features/categories/models/category_model.dart';

class OrdersListView extends StatefulWidget {
  final ValueChanged<int> onProductsCountChanged;

  const OrdersListView({super.key, required this.onProductsCountChanged});

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final CategoryDatabaseHelper categoryDatabaseHelper =
      CategoryDatabaseHelper.instance; // Use the singleton instance

  List<Order> orders = [];
  List<CategoryModel> categories = [];
  String? selectedCategory;

  final TextEditingController idController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController numberOfItemsController = TextEditingController();
  final TextEditingController entryDateController = TextEditingController();
  final TextEditingController exitDateController = TextEditingController();
  final TextEditingController wholesalePriceController =
      TextEditingController();
  final TextEditingController retailPriceController = TextEditingController();
  final TextEditingController productStatusController = TextEditingController();
  final TextEditingController productDetailsController =
      TextEditingController();
  final TextEditingController productModelController = TextEditingController();

  String? selectedPaymentMethod;
  final List<String> paymentMethods = ['Visa', 'Cash', 'PayPal'];
  final OrderService _orderService = OrderService();

  @override
  void initState() {
    super.initState();
    loadOrders();
    loadCategories();
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
      id: idController.text,
      dateTime: dateTimeController.text,
      type: typeController.text,
      employee: employeeController.text,
      status: statusController.text,
      paymentStatus: selectedPaymentMethod ?? '',
      amount: double.tryParse(amountController.text) ?? 0,
      numberOfItems: int.tryParse(numberOfItemsController.text) ?? 0,
      entryDate: entryDateController.text,
      exitDate: exitDateController.text,
      wholesalePrice: double.tryParse(wholesalePriceController.text) ?? 0,
      retailPrice: double.tryParse(retailPriceController.text) ?? 0,
      productStatus: productStatusController.text,
      productDetails: productDetailsController.text,
      productModel: productModelController.text,
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
      id: idController.text,
      dateTime: dateTimeController.text,
      type: typeController.text,
      employee: employeeController.text,
      status: statusController.text,
      paymentStatus: selectedPaymentMethod ?? '',
      amount: double.tryParse(amountController.text) ?? 0,
      numberOfItems: int.tryParse(numberOfItemsController.text) ?? 0,
      entryDate: entryDateController.text,
      exitDate: exitDateController.text,
      wholesalePrice: double.tryParse(wholesalePriceController.text) ?? 0,
      retailPrice: double.tryParse(retailPriceController.text) ?? 0,
      productStatus: productStatusController.text,
      productDetails: productDetailsController.text,
      productModel: productModelController.text,
      category: selectedCategory ?? '',
    );

    await databaseHelper.updateOrder(updatedOrder);
    clearTextFields();
    loadOrders();
  }

  void clearTextFields() {
    idController.clear();
    dateTimeController.clear();
    typeController.clear();
    employeeController.clear();
    statusController.clear();
    amountController.clear();
    numberOfItemsController.clear();
    entryDateController.clear();
    exitDateController.clear();
    wholesalePriceController.clear();
    retailPriceController.clear();
    productStatusController.clear();
    productDetailsController.clear();
    productModelController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TextField(
            //     controller: idController,
            //     decoration: const InputDecoration(labelText: 'ID')),
            // TextField(
            //     controller: dateTimeController,
            //     decoration: const InputDecoration(labelText: 'Date and Time')),
            // TextField(
            //     controller: typeController,
            //     decoration: const InputDecoration(labelText: 'Type')),
            // TextField(
            //     controller: employeeController,
            //     decoration: const InputDecoration(labelText: 'Employee')),
            // TextField(
            //     controller: statusController,
            //     decoration: const InputDecoration(labelText: 'Status')),
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
              hint: const Text('Select Payment Method'),
            ),
            TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount')),
            TextField(
                controller: numberOfItemsController,
                decoration:
                    const InputDecoration(labelText: 'Number of Items')),
            TextField(
                controller: entryDateController,
                decoration: const InputDecoration(labelText: 'Entry Date')),
            TextField(
                controller: exitDateController,
                decoration: const InputDecoration(labelText: 'Exit Date')),
            TextField(
                controller: wholesalePriceController,
                decoration:
                    const InputDecoration(labelText: 'Wholesale Price')),
            TextField(
                controller: retailPriceController,
                decoration: const InputDecoration(labelText: 'Retail Price')),
            TextField(
                controller: productStatusController,
                decoration: const InputDecoration(labelText: 'Product Status')),
            TextField(
                controller: productDetailsController,
                decoration:
                    const InputDecoration(labelText: 'Product Details')),
            TextField(
                controller: productModelController,
                decoration: const InputDecoration(labelText: 'Product Model')),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category.title,
                  child: Text(category.title),
                );
              }).toList(),
              hint: const Text('Select Category'),
            ),
            ElevatedButton(onPressed: addOrder, child: const Text('Add Order')),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text(order.type),
                    subtitle: Text(order.employee),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => removeOrder(index),
                    ),
                    onTap: () {
                      idController.text = order.id;
                      dateTimeController.text = order.dateTime;
                      typeController.text = order.type;
                      employeeController.text = order.employee;
                      statusController.text = order.status;
                      amountController.text = order.amount.toString();
                      numberOfItemsController.text =
                          order.numberOfItems.toString();
                      entryDateController.text = order.entryDate;
                      exitDateController.text = order.exitDate;
                      wholesalePriceController.text =
                          order.wholesalePrice.toString();
                      retailPriceController.text = order.retailPrice.toString();
                      productStatusController.text = order.productStatus;
                      productDetailsController.text = order.productDetails;
                      productModelController.text = order.productModel;
                      selectedPaymentMethod = order.paymentStatus;
                      selectedCategory = order.category;
                      updateOrder(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
