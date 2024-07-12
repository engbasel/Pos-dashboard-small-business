// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/models/order_model.dart';

// import '../../../../../core/utils/DB/database_helper_prodactsTable.dart';

// class OrderList extends StatefulWidget {
//   const OrderList({super.key});

//   @override
//   State<OrderList> createState() => _OrderListState();
// }

// class _OrderListState extends State<OrderList> {
//   final DatabaseHelper _databaseHelper = DatabaseHelper();
//   List<Order> orders = [];
//   String filter = 'All';

//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _dateTimeController = TextEditingController();
//   final TextEditingController _typeController = TextEditingController();
//   final TextEditingController _employeeController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//   final TextEditingController _paymentStatusController =
//       TextEditingController();
//   final TextEditingController _amountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadOrders();
//   }

//   Future<void> _loadOrders() async {
//     final loadedOrders = await _databaseHelper.getOrders();
//     setState(() {
//       orders = loadedOrders;
//     });
//   }

//   Future<void> _addOrder() async {
//     final newOrder = Order(
//       _idController.text,
//       _dateTimeController.text,
//       _typeController.text,
//       _employeeController.text,
//       _statusController.text,
//       _paymentStatusController.text,
//       double.tryParse(_amountController.text) ?? 0,
//     );

//     await _databaseHelper.insertOrder(newOrder);
//     _clearTextFields();
//     _loadOrders();
//   }

//   Future<void> _removeOrder(int index) async {
//     final orderToDelete = orders[index];
//     await _databaseHelper.deleteOrder(orderToDelete.id);
//     _loadOrders();
//   }

//   Future<void> _updateOrder(int index) async {
//     final updatedOrder = Order(
//       _idController.text,
//       _dateTimeController.text,
//       _typeController.text,
//       _employeeController.text,
//       _statusController.text,
//       _paymentStatusController.text,
//       double.tryParse(_amountController.text) ?? 0,
//     );

//     await _databaseHelper.updateOrder(updatedOrder);
//     _clearTextFields();
//     _loadOrders();
//   }

//   void _clearTextFields() {
//     _idController.clear();
//     _dateTimeController.clear();
//     _typeController.clear();
//     _employeeController.clear();
//     _statusController.clear();
//     _paymentStatusController.clear();
//     _amountController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           DataTable(
//             columns: const <DataColumn>[
//               DataColumn(label: Text('Order ID')),
//               DataColumn(label: Text('Date/Time')),
//               DataColumn(label: Text('Order Type')),
//               DataColumn(label: Text('Employee')),
//               DataColumn(label: Text('Status')),
//               DataColumn(label: Text('Payment Status')),
//               DataColumn(label: Text('Amount')),
//               DataColumn(label: Text('Actions')),
//             ],
//             rows: List<DataRow>.generate(orders.length, (index) {
//               return DataRow(
//                 cells: [
//                   DataCell(Text(orders[index].id)),
//                   DataCell(Text(orders[index].dateTime)),
//                   DataCell(Text(orders[index].type)),
//                   DataCell(Text(orders[index].employee)),
//                   DataCell(
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: orders[index].status == 'Complete'
//                             ? const Color(0xffE6F6E9)
//                             : const Color(0xffFFB074).withOpacity(.15),
//                         borderRadius: BorderRadius.circular(19),
//                       ),
//                       child: Text(
//                         orders[index].status,
//                         style: TextStyle(
//                           color: orders[index].status == 'Complete'
//                               ? const Color(0xff2CC56F)
//                               : const Color(0xffFF9A00),
//                         ),
//                       ),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       orders[index].paymentStatus,
//                       style: const TextStyle(color: Color(0xff2CC56F)),
//                     ),
//                   ),
//                   DataCell(Text('\$ ${orders[index].amount}')),
//                   DataCell(Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit),
//                         onPressed: () {
//                           _idController.text = orders[index].id;
//                           _dateTimeController.text = orders[index].dateTime;
//                           _typeController.text = orders[index].type;
//                           _employeeController.text = orders[index].employee;
//                           _statusController.text = orders[index].status;
//                           _paymentStatusController.text =
//                               orders[index].paymentStatus;
//                           _amountController.text =
//                               orders[index].amount.toString();
//                           _updateOrder(index);
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () {
//                           _removeOrder(index);
//                         },
//                       ),
//                     ],
//                   )),
//                 ],
//               );
//             }),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: _idController,
//                   decoration: const InputDecoration(labelText: 'Order ID'),
//                 ),
//                 TextField(
//                   controller: _dateTimeController,
//                   decoration: const InputDecoration(labelText: 'Date/Time'),
//                 ),
//                 TextField(
//                   controller: _typeController,
//                   decoration: const InputDecoration(labelText: 'Order Type'),
//                 ),
//                 TextField(
//                   controller: _employeeController,
//                   decoration: const InputDecoration(labelText: 'Employee'),
//                 ),
//                 TextField(
//                   controller: _statusController,
//                   decoration: const InputDecoration(labelText: 'Status'),
//                 ),
//                 TextField(
//                   controller: _paymentStatusController,
//                   decoration:
//                       const InputDecoration(labelText: 'Payment Status'),
//                 ),
//                 TextField(
//                   controller: _amountController,
//                   decoration: const InputDecoration(labelText: 'Amount'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     ElevatedButton(
//                       onPressed: _addOrder,
//                       child: const Text('Add Order'),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       onPressed: _clearTextFields,
//                       child: const Text('Clear Fields'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/models/order_model.dart';
import '../../../../../core/utils/DB/database_helper_prodactsTable.dart';

class OrderList extends StatefulWidget {
  final ValueChanged<int>
      onProductsCountChanged; // Callback to notify product count change

  const OrderList({super.key, required this.onProductsCountChanged});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Order> orders = [];

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _employeeController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _paymentStatusController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final loadedOrders = await _databaseHelper.getOrders();
    setState(() {
      orders = loadedOrders;
      widget.onProductsCountChanged(
          orders.length); // Notify the parent about the count
    });
  }

  Future<void> _addOrder() async {
    final newOrder = Order(
      _idController.text,
      _dateTimeController.text,
      _typeController.text,
      _employeeController.text,
      _statusController.text,
      _paymentStatusController.text,
      double.tryParse(_amountController.text) ?? 0,
    );

    await _databaseHelper.insertOrder(newOrder);
    _clearTextFields();
    _loadOrders();
  }

  Future<void> _removeOrder(int index) async {
    final orderToDelete = orders[index];
    await _databaseHelper.deleteOrder(orderToDelete.id);
    _loadOrders();
  }

  Future<void> _updateOrder(int index) async {
    final updatedOrder = Order(
      _idController.text,
      _dateTimeController.text,
      _typeController.text,
      _employeeController.text,
      _statusController.text,
      _paymentStatusController.text,
      double.tryParse(_amountController.text) ?? 0,
    );

    await _databaseHelper.updateOrder(updatedOrder);
    _clearTextFields();
    _loadOrders();
  }

  void _clearTextFields() {
    _idController.clear();
    _dateTimeController.clear();
    _typeController.clear();
    _employeeController.clear();
    _statusController.clear();
    _paymentStatusController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Order ID')),
              DataColumn(label: Text('Date/Time')),
              DataColumn(label: Text('Order Type')),
              DataColumn(label: Text('Employee')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Payment Status')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Actions')),
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
                          _idController.text = orders[index].id;
                          _dateTimeController.text = orders[index].dateTime;
                          _typeController.text = orders[index].type;
                          _employeeController.text = orders[index].employee;
                          _statusController.text = orders[index].status;
                          _paymentStatusController.text =
                              orders[index].paymentStatus;
                          _amountController.text =
                              orders[index].amount.toString();
                          _updateOrder(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _removeOrder(index);
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
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'Order ID'),
                ),
                TextField(
                  controller: _dateTimeController,
                  decoration: const InputDecoration(labelText: 'Date/Time'),
                ),
                TextField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'Order Type'),
                ),
                TextField(
                  controller: _employeeController,
                  decoration: const InputDecoration(labelText: 'Employee'),
                ),
                TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
                TextField(
                  controller: _paymentStatusController,
                  decoration:
                      const InputDecoration(labelText: 'Payment Status'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _addOrder,
                      child: const Text('Add Order'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _clearTextFields,
                      child: const Text('Clear Fields'),
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
