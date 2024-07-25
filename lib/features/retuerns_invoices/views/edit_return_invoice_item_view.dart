import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/custom_text_form_field.dart';

import '../../../core/widgets/custom_snackbar.dart';

class EditReturnInvoiceItemScreen extends StatefulWidget {
  final ReturnInvoiceModel returnInvoice;
  final ValueChanged<ReturnInvoiceModel> onUpdate;

  const EditReturnInvoiceItemScreen({
    super.key,
    required this.returnInvoice,
    required this.onUpdate,
  });

  @override
  State<EditReturnInvoiceItemScreen> createState() =>
      _EditReturnInvoiceItemScreenState();
}

class _EditReturnInvoiceItemScreenState
    extends State<EditReturnInvoiceItemScreen> {
  final DatabaseReturnsInvoice databaseHelper = DatabaseReturnsInvoice();

  late TextEditingController idController;
  late TextEditingController orderIdController;
  late TextEditingController returnDateController;
  late TextEditingController employeeController;
  late TextEditingController reasonController;
  late TextEditingController amountController;
  late TextEditingController totalbackmonyController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(text: widget.returnInvoice.id);
    orderIdController =
        TextEditingController(text: widget.returnInvoice.orderId);
    returnDateController =
        TextEditingController(text: widget.returnInvoice.returnDate);
    employeeController =
        TextEditingController(text: widget.returnInvoice.employee);
    reasonController = TextEditingController(text: widget.returnInvoice.reason);
    amountController =
        TextEditingController(text: widget.returnInvoice.amount.toString());
    totalbackmonyController = TextEditingController(
        text: widget.returnInvoice.totalbackmony.toString());
  }

  Future<void> updateReturnInvoice() async {
    final updatedReturnInvoice = ReturnInvoiceModel(
      id: idController.text,
      orderId: orderIdController.text,
      returnDate: returnDateController.text,
      employee: employeeController.text,
      reason: reasonController.text,
      amount: double.tryParse(amountController.text) ?? 0,
      totalbackmony: double.tryParse(totalbackmonyController.text) ?? 0,
    );

    try {
      await databaseHelper.updateReturnInvoice(updatedReturnInvoice);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Return Invoice updated successfully')),
      // );
      CustomSnackBar.show(context, 'Return Invoice updated successfully');

      // CustomSnackBar();
      widget.onUpdate(
          updatedReturnInvoice); // Call the callback function with updated invoice
      Navigator.pop(context); // Close the screen
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error updating Return Invoice: $e')),
      // );

      CustomSnackBar.show(context, 'Error updating Return Invoice: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit Return Invoice'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomSmallButton(
              icon: Icons.save,
              text: 'Save',
              onTap: updateReturnInvoice,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CoustomTextFormFiled(
                readOnly: true,
                controller: idController,
                labelText: 'Invoice ID',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                readOnly: false,
                controller: orderIdController,
                labelText: 'Order ID',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                readOnly: false,
                controller: totalbackmonyController,
                labelText: 'Total Back Money',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                readOnly: false,
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
              CoustomTextFormFiled(
                readOnly: false,
                controller: employeeController,
                labelText: 'Employee',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                readOnly: false,
                controller: reasonController,
                labelText: 'Reason',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                readOnly: false,
                controller: amountController,
                labelText: 'Amount',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    idController.dispose();
    orderIdController.dispose();
    returnDateController.dispose();
    employeeController.dispose();
    reasonController.dispose();
    amountController.dispose();
    totalbackmonyController.dispose();
    super.dispose();
  }
}
