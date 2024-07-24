import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/features/overview/services/order_service.dart';
import 'package:pos_dashboard_v1/features/Prodacts/widgets/custom_form.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/orders_list_body.dart';
import '../../../core/db/new_products_store_database_helper.dart';
import '../../../l10n/app_localizations.dart';

class OrdersListView extends StatefulWidget {
  final ValueChanged<int> onProductsCountChanged;

  const OrdersListView({super.key, required this.onProductsCountChanged});

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Order> orders = [];

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
  }

  Future<void> loadOrders() async {
    final loadedOrders = await databaseHelper.getOrders();
    setState(() {
      orders = loadedOrders;
      widget.onProductsCountChanged(orders.length);
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
    setState(() {
      selectedPaymentMethod = null;
    });
  }

  void showAddOrderForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomForm(
                  idController: idController,
                  localizations: AppLocalizations.of(context),
                  dateTimeController: dateTimeController,
                  typeController: typeController,
                  employeeController: employeeController,
                  statusController: statusController,
                  paymentMethods: paymentMethods,
                  selectedPaymentMethod: selectedPaymentMethod,
                  onPaymentMethodChanged: (newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue;
                    });
                  },
                  amountController: amountController,
                  numberOfItemsController: numberOfItemsController,
                  entryDateController: entryDateController,
                  exitDateController: exitDateController,
                  wholesalePriceController: wholesalePriceController,
                  retailPriceController: retailPriceController,
                  productStatusController: productStatusController,
                  productDetailsController: productDetailsController,
                  productModelController: productModelController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CustomButton(
                          text: AppLocalizations.of(context)
                              .translate('clearFields'),
                          bgColor: Colors.blueGrey,
                          onTap: () {
                            clearTextFields();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CustomButton(
                          text: AppLocalizations.of(context)
                              .translate('addOrder'),
                          bgColor: Colors.blueGrey,
                          onTap: () {
                            addOrder();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('orderList')),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              _orderService.generateAllOrdersPdf(context, orders);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: OrdersListBody(orders: orders),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddOrderForm(context),
        tooltip: 'Add product',
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
