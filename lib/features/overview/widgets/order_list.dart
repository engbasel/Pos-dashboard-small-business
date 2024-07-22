import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/CustomForm.dart';
import '../../../core/db/NewProdactsInStoreDatabase_helper.dart';
import '../views/OrdersListScreen.dart';
import '../../../l10n/app_localizations.dart';

class OrderList extends StatefulWidget {
  final ValueChanged<int> onProductsCountChanged;

  const OrderList({super.key, required this.onProductsCountChanged});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Order> orders = [];
  String filter = 'All';

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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderListScreen(orders: orders),
                        ),
                      );
                    },
                    child: const Text(
                      'قائمة المنتجات',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text('هذة العناصر موجودة بالمخازة'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'Monthly', 'Weekly', 'Today']
                          .map((filterOption) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                filter = filterOption;
                              });
                            },
                            child: Text(
                              filterOption,
                              style: TextStyle(
                                fontSize: 16,
                                color: filter == filterOption
                                    ? const Color(0xff2CC56F)
                                    : const Color(0xff37474F).withOpacity(.7),
                                fontWeight: filter == filterOption
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomForm(
              idController: idController,
              localizations: localizations,
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
                      text: localizations.translate('clearFields'),
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
                      text: localizations.translate('addOrder'),
                      bgColor: Colors.blueGrey,
                      onTap: () {
                        addOrder();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
