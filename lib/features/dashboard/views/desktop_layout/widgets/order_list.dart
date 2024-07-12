import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/models/order_model.dart';
import 'package:pos_dashboard_v1/core/utils/DB/database_helper_prodactsTable.dart';

import '../../../../../l10n/app_localizations.dart';

class OrderList extends StatefulWidget {
  final ValueChanged<int> onProductsCountChanged;

  const OrderList({super.key, required this.onProductsCountChanged});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Order> orders = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController paymentStatusController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

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
      idController.text,
      dateTimeController.text,
      typeController.text,
      employeeController.text,
      statusController.text,
      paymentStatusController.text,
      double.tryParse(amountController.text) ?? 0,
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
      idController.text,
      dateTimeController.text,
      typeController.text,
      employeeController.text,
      statusController.text,
      paymentStatusController.text,
      double.tryParse(amountController.text) ?? 0,
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
    paymentStatusController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text(localizations.translate('orderID'))),
              DataColumn(label: Text(localizations.translate('dateTime'))),
              DataColumn(label: Text(localizations.translate('orderType'))),
              DataColumn(label: Text(localizations.translate('employee'))),
              DataColumn(label: Text(localizations.translate('status'))),
              DataColumn(label: Text(localizations.translate('paymentStatus'))),
              DataColumn(label: Text(localizations.translate('amount'))),
              DataColumn(label: Text(localizations.translate('actions'))),
            ],
            rows: List<DataRow>.generate(orders.length, (index) {
              return DataRow(
                cells: [
                  DataCell(Text(orders[index].id)),
                  DataCell(Text(orders[index].dateTime)),
                  DataCell(Text(orders[index].type)),
                  DataCell(Text(orders[index].employee)),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: orders[index].status == 'Complete'
                            ? const Color(0xffE6F6E9)
                            : const Color(0xffFFB074).withOpacity(.15),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Text(
                        orders[index].status,
                        style: TextStyle(
                          color: orders[index].status == 'Complete'
                              ? const Color(0xff2CC56F)
                              : const Color(0xffFF9A00),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      orders[index].paymentStatus,
                      style: const TextStyle(color: Color(0xff2CC56F)),
                    ),
                  ),
                  DataCell(Text('\$ ${orders[index].amount}')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          idController.text = orders[index].id;
                          dateTimeController.text = orders[index].dateTime;
                          typeController.text = orders[index].type;
                          employeeController.text = orders[index].employee;
                          statusController.text = orders[index].status;
                          paymentStatusController.text =
                              orders[index].paymentStatus;
                          amountController.text =
                              orders[index].amount.toString();
                          updateOrder(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          removeOrder(index);
                        },
                      ),
                    ],
                  )),
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: idController,
                  labelText: localizations.translate('orderID'),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: dateTimeController,
                  labelText: localizations.translate('dateTime'),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: typeController,
                  labelText: localizations.translate('orderType'),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: employeeController,
                  labelText: localizations.translate('employee'),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: statusController,
                  labelText: localizations.translate('status'),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: paymentStatusController,
                  labelText: localizations.translate('paymentStatus'),
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: amountController,
                  labelText: localizations.translate('amount'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          clearTextFields();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: const TextStyle(fontSize: 16.0),
                        ),
                        child: Text(localizations.translate('clearFields')),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          addOrder();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: const TextStyle(fontSize: 16.0),
                        ),
                        child: Text(localizations.translate('addOrder')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget CustomTextField({
  required TextEditingController controller,
  required String labelText,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
    keyboardType: keyboardType,
  );
}
