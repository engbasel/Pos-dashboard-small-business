// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:intl/intl.dart';
// import 'package:pos_dashboard_v1/core/utils/models/ReturnInvoice_model.dart';
// import 'package:pos_dashboard_v1/features/overview/widgets/custom_form.dart';

// import '../../../core/db/database_Returnsinvoice.dart';
// import '../../../core/utils/widgets/custom_button.dart';

// class ReturnInvoiceScreen extends StatefulWidget {
//   const ReturnInvoiceScreen({super.key});

//   @override
//   _ReturnInvoiceScreenState createState() => _ReturnInvoiceScreenState();
// }

// class _ReturnInvoiceScreenState extends State<ReturnInvoiceScreen> {
//   final database_Returnsinvoice databaseHelper = database_Returnsinvoice();
//   List<ReturnInvoice> returnInvoices = [];

//   final TextEditingController idController = TextEditingController();
//   final TextEditingController orderIdController = TextEditingController();
//   final TextEditingController returnDateController = TextEditingController();
//   final TextEditingController employeeController = TextEditingController();
//   final TextEditingController reasonController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     loadReturnInvoices();
//   }

//   Future<void> loadReturnInvoices() async {
//     final loadedInvoices = await databaseHelper.getReturnInvoices();
//     setState(() {
//       returnInvoices = loadedInvoices;
//     });
//   }

//   Future<void> addReturnInvoice() async {
//     final newReturnInvoice = ReturnInvoice(
//       id: idController.text,
//       orderId: orderIdController.text,
//       returnDate: returnDateController.text,
//       employee: employeeController.text,
//       reason: reasonController.text,
//       amount: double.tryParse(amountController.text) ?? 0,
//     );

//     await databaseHelper.insertReturnInvoice(newReturnInvoice);
//     clearTextFields();
//     loadReturnInvoices();
//   }

//   Future<void> removeReturnInvoice(int index) async {
//     final returnInvoiceToDelete = returnInvoices[index];
//     await databaseHelper.deleteReturnInvoice(returnInvoiceToDelete.id);
//     loadReturnInvoices();
//   }

//   Future<void> updateReturnInvoice(int index) async {
//     final updatedReturnInvoice = ReturnInvoice(
//       id: idController.text,
//       orderId: orderIdController.text,
//       returnDate: returnDateController.text,
//       employee: employeeController.text,
//       reason: reasonController.text,
//       amount: double.tryParse(amountController.text) ?? 0,
//     );

//     await databaseHelper.updateReturnInvoice(updatedReturnInvoice);
//     clearTextFields();
//     loadReturnInvoices();
//   }

//   void clearTextFields() {
//     idController.clear();
//     orderIdController.clear();
//     returnDateController.clear();
//     employeeController.clear();
//     reasonController.clear();
//     amountController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Return Invoices'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomTextField(
//                 controller: idController,
//                 labelText: 'Invoice ID',
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextField(
//                 controller: orderIdController,
//                 labelText: 'Order ID',
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextField(
//                 controller: returnDateController,
//                 labelText: 'Return Date',
//                 keyboardType: TextInputType.datetime,
//                 // onTap: () async {
//                 //   FocusScope.of(context).requestFocus(FocusNode());
//                 //   final DateTime? picked = await showDatePicker(
//                 //     context: context,
//                 //     initialDate: DateTime.now(),
//                 //     firstDate: DateTime(2000),
//                 //     lastDate: DateTime(2101),
//                 //   );
//                 //   if (picked != null) {
//                 //     setState(() {
//                 //       returnDateController.text =
//                 //           DateFormat('yyyy-MM-dd').format(picked);
//                 //     });
//                 //   }
//                 // },
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextField(
//                 controller: employeeController,
//                 labelText: 'Employee',
//                 keyboardType: TextInputType.text,
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextField(
//                 controller: reasonController,
//                 labelText: 'Reason',
//                 keyboardType: TextInputType.text,
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextField(
//                 controller: amountController,
//                 labelText: 'Amount',
//                 keyboardType:
//                     const TextInputType.numberWithOptions(decimal: true),
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: CustomButton(
//                         text: 'Clear Fields',
//                         bgColor: Colors.blueGrey,
//                         onTap: clearTextFields,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: CustomButton(
//                         text: 'Add Return Invoice',
//                         bgColor: Colors.blueGrey,
//                         onTap: addReturnInvoice,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Displaying return invoices
//               ...returnInvoices.map((returnInvoice) {
//                 return ListTile(
//                   title: Text(returnInvoice.orderId),
//                   subtitle: Text(returnInvoice.reason),
//                   trailing:
//                       Text('\$${returnInvoice.amount.toStringAsFixed(2)}'),
//                   onTap: () {
//                     idController.text = returnInvoice.id;
//                     orderIdController.text = returnInvoice.orderId;
//                     returnDateController.text = returnInvoice.returnDate;
//                     employeeController.text = returnInvoice.employee;
//                     reasonController.text = returnInvoice.reason;
//                     amountController.text = returnInvoice.amount.toString();
//                   },
//                   onLongPress: () {
//                     removeReturnInvoice(returnInvoices.indexOf(returnInvoice));
//                   },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/models/ReturnInvoice_model.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/views/ReturnInvoiceListScreen.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/custom_form.dart';

import '../database/database_Returnsinvoice.dart';
import '../../../core/utils/widgets/custom_button.dart';

class ReturnInvoiceScreen extends StatefulWidget {
  const ReturnInvoiceScreen({super.key});

  @override
  _ReturnInvoiceScreenState createState() => _ReturnInvoiceScreenState();
}

class _ReturnInvoiceScreenState extends State<ReturnInvoiceScreen> {
  final database_Returnsinvoice databaseHelper = database_Returnsinvoice();
  List<ReturnInvoice> returnInvoices = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController employeeController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadReturnInvoices();
  }

  Future<void> loadReturnInvoices() async {
    final loadedInvoices = await databaseHelper.getReturnInvoices();
    setState(() {
      returnInvoices = loadedInvoices;
    });
  }

  Future<void> addReturnInvoice() async {
    final newReturnInvoice = ReturnInvoice(
      id: idController.text,
      orderId: orderIdController.text,
      returnDate: returnDateController.text,
      employee: employeeController.text,
      reason: reasonController.text,
      amount: double.tryParse(amountController.text) ?? 0,
    );

    await databaseHelper.insertReturnInvoice(newReturnInvoice);
    clearTextFields();
    loadReturnInvoices();
  }

  Future<void> removeReturnInvoice(int index) async {
    final returnInvoiceToDelete = returnInvoices[index];
    await databaseHelper.deleteReturnInvoice(returnInvoiceToDelete.id);
    loadReturnInvoices();
  }

  Future<void> updateReturnInvoice(int index) async {
    final updatedReturnInvoice = ReturnInvoice(
      id: idController.text,
      orderId: orderIdController.text,
      returnDate: returnDateController.text,
      employee: employeeController.text,
      reason: reasonController.text,
      amount: double.tryParse(amountController.text) ?? 0,
    );

    await databaseHelper.updateReturnInvoice(updatedReturnInvoice);
    clearTextFields();
    loadReturnInvoices();
  }

  void clearTextFields() {
    idController.clear();
    orderIdController.clear();
    returnDateController.clear();
    employeeController.clear();
    reasonController.clear();
    amountController.clear();
  }

  void navigateToReturnInvoiceListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReturnInvoiceListScreen(
          returnInvoices: returnInvoices,
          onReturnInvoiceTap: (returnInvoice) {
            idController.text = returnInvoice.id;
            orderIdController.text = returnInvoice.orderId;
            returnDateController.text = returnInvoice.returnDate;
            employeeController.text = returnInvoice.employee;
            reasonController.text = returnInvoice.reason;
            amountController.text = returnInvoice.amount.toString();
            Navigator.pop(context);
          },
          onReturnInvoiceLongPress: (index) {
            removeReturnInvoice(index);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Invoices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: navigateToReturnInvoiceListScreen,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: idController,
                labelText: 'Invoice ID',
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: orderIdController,
                labelText: 'Order ID',
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: returnDateController,
                labelText: 'Return Date',
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      returnDateController.text =
                          DateFormat('yyyy-MM-dd').format(picked);
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: employeeController,
                labelText: 'Employee',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: reasonController,
                labelText: 'Reason',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: amountController,
                labelText: 'Amount',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CustomButton(
                        text: 'Clear Fields',
                        bgColor: Colors.blueGrey,
                        onTap: clearTextFields,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CustomButton(
                        text: 'Add Return Invoice',
                        bgColor: Colors.blueGrey,
                        onTap: addReturnInvoice,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
