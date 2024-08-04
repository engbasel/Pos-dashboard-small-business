// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
// import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
// import 'package:pos_dashboard_v1/features/upcoming_orders/model/incoming_order_model.dart';
// import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
// import 'package:uuid/uuid.dart';

// class NeededProductsForm extends StatefulWidget {
//   const NeededProductsForm({super.key});

//   @override
//   State<NeededProductsForm> createState() => _NeededProductsFormState();
// }

// class _NeededProductsFormState extends State<NeededProductsForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _orderIdController = TextEditingController();
//   final _supplierNameController = TextEditingController();
//   final _orderDateController = TextEditingController();
//   final _expectedDeliveryDateController = TextEditingController();
//   final _orderStatusController = TextEditingController();
//   final _totalAmountController = TextEditingController();

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
//       _formKey.currentState!.reset();
//       Navigator.of(context).pop(true);
//     }
//   }

//   Future<void> _selectDate(
//       BuildContext context, TextEditingController controller) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       controller.text = "${picked.toLocal()}".split(' ')[0];
//     }
//   }

//   Widget _buildInputField(String label, TextEditingController controller,
//       {bool isDate = false, bool isNumber = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: AppLocalizations.of(context).translate(label),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//           suffixIcon: isDate
//               ? IconButton(
//                   icon: const Icon(Icons.calendar_month_outlined),
//                   onPressed: () => _selectDate(context, controller),
//                 )
//               : null,
//         ),
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return AppLocalizations.of(context).translate('enter$label');
//           }
//           return null;
//         },
//         readOnly: isDate,
//       ),
//     );
//   }

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

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * .5,
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildInputField('orderId', _orderIdController),
//               _buildInputField('supplierName', _supplierNameController),
//               _buildInputField('orderDate', _orderDateController, isDate: true),
//               _buildInputField(
//                   'expectedDeliveryDate', _expectedDeliveryDateController,
//                   isDate: true),
//               _buildInputField('orderStatus', _orderStatusController),
//               _buildInputField('totalAmount', _totalAmountController,
//                   isNumber: true),
//               const SizedBox(height: 20),
//               CustomButton(
//                 text: AppLocalizations.of(context).translate('addOrder'),
//                 onTap: _addIncomingOrder,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class NeededProductsForm extends StatefulWidget {
  final IncomingOrderModel? order;

  const NeededProductsForm({super.key, this.order});

  @override
  _NeededProductsFormState createState() => _NeededProductsFormState();
}

class _NeededProductsFormState extends State<NeededProductsForm> {
  final _formKey = GlobalKey<FormState>();

  final _orderIdController = TextEditingController();
  final _supplierNameController = TextEditingController();
  final _orderDateController = TextEditingController();
  final _expectedDeliveryDateController = TextEditingController();
  final _orderStatusController = TextEditingController();
  final _totalAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      _orderIdController.text = widget.order!.orderId;
      _supplierNameController.text = widget.order!.supplierName;
      _orderDateController.text = widget.order!.orderDate;
      _expectedDeliveryDateController.text = widget.order!.expectedDeliveryDate;
      _orderStatusController.text = widget.order!.orderStatus;
      _totalAmountController.text = widget.order!.totalAmount.toString();
    }
  }

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

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final order = IncomingOrderModel(
        id: widget.order?.id ?? DateTime.now().toString(),
        orderId: _orderIdController.text,
        supplierName: _supplierNameController.text,
        orderDate: _orderDateController.text,
        expectedDeliveryDate: _expectedDeliveryDateController.text,
        orderStatus: _orderStatusController.text,
        totalAmount: double.parse(_totalAmountController.text),
      );

      if (widget.order == null) {
        await DatabaseIncomingOrdersManager().insertIncomingOrder(order);
      } else {
        await DatabaseIncomingOrdersManager().updateIncomingOrder(order);
      }

      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _orderIdController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate('orderId'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter order ID';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _supplierNameController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('supplierName'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter supplier name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _orderDateController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate('orderDate'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter order date';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _expectedDeliveryDateController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)
                    .translate('expectedDeliveryDate'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter expected delivery date';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _orderStatusController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('orderStatus'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter order status';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _totalAmountController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('totalAmount'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter total amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveForm,
              child: Text(AppLocalizations.of(context).translate('save')),
            ),
          ],
        ),
      ),
    );
  }
}
