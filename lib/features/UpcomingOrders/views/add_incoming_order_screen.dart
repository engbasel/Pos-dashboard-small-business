// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/UpcomingOrders/database/database_incoming_orders_manager..dart';
// import 'package:pos_dashboard_v1/features/UpcomingOrders/views/incoming_orders_list_screen.dart';
// import 'package:uuid/uuid.dart';

// import '../../../l10n/app_localizations.dart';
// import '../model/incoming_order_model.dart';

// class AddIncomingOrderScreen extends StatefulWidget {
//   const AddIncomingOrderScreen({super.key});

//   @override
//   _AddIncomingOrderScreenState createState() => _AddIncomingOrderScreenState();
// }

// class _AddIncomingOrderScreenState extends State<AddIncomingOrderScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _orderIdController = TextEditingController();
//   final _supplierNameController = TextEditingController();
//   final _orderDateController = TextEditingController();
//   final _expectedDeliveryDateController = TextEditingController();
//   final _orderStatusController = TextEditingController();
//   final _totalAmountController = TextEditingController();

//   @override
//   void dispose() {
//     _orderIdController.dispose();
//     _supplierNameController.dispose();
//     _orderDateController.dispose();
//     _expectedDeliveryDateController.dispose();
//     _orderStatusController.dispose();
//     _totalAmountController.dispose();
//     super.dispose();
//   }

//   Future<void> _addIncomingOrder() async {
//     if (_formKey.currentState!.validate()) {
//       final newOrder = IncomingOrderModel(
//         id: const Uuid().v4(),
//         orderId: _orderIdController.text,
//         supplierName: _supplierNameController.text,
//         orderDate: _orderDateController.text,
//         expectedDeliveryDate: _expectedDeliveryDateController.text,
//         orderStatus: _orderStatusController.text,
//         totalAmount: double.parse(_totalAmountController.text),
//       );
//       await DatabaseIncomingOrdersManager().insertIncomingOrder(newOrder);
//       print('Order added: ${newOrder.toMap()}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) {
//                     return const IncomingOrdersListScreen();
//                   },
//                 ));
//               },
//               icon: const Icon(Icons.list))
//         ],
//         title: Text(AppLocalizations.of(context).translate('addOrder')),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 controller: _orderIdController,
//                 decoration: InputDecoration(
//                   labelText: AppLocalizations.of(context).translate('orderId'),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppLocalizations.of(context)
//                         .translate('enterOrderId');
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _supplierNameController,
//                 decoration: InputDecoration(
//                   labelText:
//                       AppLocalizations.of(context).translate('supplierName'),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppLocalizations.of(context)
//                         .translate('enterSupplierName');
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _orderDateController,
//                 decoration: InputDecoration(
//                   labelText:
//                       AppLocalizations.of(context).translate('orderDate'),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppLocalizations.of(context)
//                         .translate('enterOrderDate');
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _expectedDeliveryDateController,
//                 decoration: InputDecoration(
//                   labelText: AppLocalizations.of(context)
//                       .translate('expectedDeliveryDate'),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppLocalizations.of(context)
//                         .translate('enterExpectedDeliveryDate');
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _orderStatusController,
//                 decoration: InputDecoration(
//                   labelText:
//                       AppLocalizations.of(context).translate('orderStatus'),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppLocalizations.of(context)
//                         .translate('enterOrderStatus');
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _totalAmountController,
//                 decoration: InputDecoration(
//                   labelText:
//                       AppLocalizations.of(context).translate('totalAmount'),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return AppLocalizations.of(context)
//                         .translate('enterTotalAmount');
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _addIncomingOrder,
//                 child: Text(AppLocalizations.of(context).translate('addOrder')),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/database/database_incoming_orders_manager..dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/views/incoming_orders_list_screen.dart';
import 'package:uuid/uuid.dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class AddIncomingOrderScreen extends StatefulWidget {
  const AddIncomingOrderScreen({super.key});

  @override
  _AddIncomingOrderScreenState createState() => _AddIncomingOrderScreenState();
}

class _AddIncomingOrderScreenState extends State<AddIncomingOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orderIdController = TextEditingController();
  final _supplierNameController = TextEditingController();
  final _orderDateController = TextEditingController();
  final _expectedDeliveryDateController = TextEditingController();
  final _orderStatusController = TextEditingController();
  final _totalAmountController = TextEditingController();

  @override
  void dispose() {
    _orderIdController.dispose();
    _supplierNameController.dispose();
    _orderDateController.dispose();
    _expectedDeliveryDateController.dispose();
    _orderStatusController.dispose();
    _totalAmountController.dispose();
    super.dispose();
  }

  Future<void> _addIncomingOrder() async {
    if (_formKey.currentState!.validate()) {
      final newOrder = IncomingOrderModel(
        id: const Uuid().v4(),
        orderId: _orderIdController.text,
        supplierName: _supplierNameController.text,
        orderDate: _orderDateController.text,
        expectedDeliveryDate: _expectedDeliveryDateController.text,
        orderStatus: _orderStatusController.text,
        totalAmount: double.parse(_totalAmountController.text),
      );
      await DatabaseIncomingOrdersManager().insertIncomingOrder(newOrder);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context).translate('orderAdded'))),
      );
      _formKey.currentState!.reset();
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isDate = false, bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: isDate
              ? IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, controller),
                )
              : null,
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context).translate('enter$label');
          }
          return null;
        },
        readOnly: isDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('addOrder')),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IncomingOrdersListScreen()),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildInputField('orderId', _orderIdController),
                _buildInputField('supplierName', _supplierNameController),
                _buildInputField('orderDate', _orderDateController,
                    isDate: true),
                _buildInputField(
                    'expectedDeliveryDate', _expectedDeliveryDateController,
                    isDate: true),
                _buildInputField('orderStatus', _orderStatusController),
                _buildInputField('totalAmount', _totalAmountController,
                    isNumber: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addIncomingOrder,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      AppLocalizations.of(context).translate('addOrder'),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
