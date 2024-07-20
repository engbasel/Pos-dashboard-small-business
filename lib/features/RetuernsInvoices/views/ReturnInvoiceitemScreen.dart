import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/models/ReturnInvoice_model.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/database/database_Returnsinvoice.dart';
import 'package:pos_dashboard_v1/core/utils/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/CoustomTextFormFiled.dart';

class ReturnInvoiceItemScreen extends StatefulWidget {
  final ReturnInvoice returnInvoice;
  final VoidCallback onUpdate; // Callback function

  const ReturnInvoiceItemScreen({
    super.key,
    required this.returnInvoice,
    required this.onUpdate,
  });

  @override
  _ReturnInvoiceItemScreenState createState() =>
      _ReturnInvoiceItemScreenState();
}

class _ReturnInvoiceItemScreenState extends State<ReturnInvoiceItemScreen> {
  final database_Returnsinvoice databaseHelper = database_Returnsinvoice();

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
    final updatedReturnInvoice = ReturnInvoice(
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Return Invoice updated successfully')),
      );
      widget.onUpdate(); // Call the callback function
      Navigator.pop(
          context, updatedReturnInvoice); // Return the updated invoice
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating Return Invoice: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Return Invoice'),
      ),
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
                // readOnly: true,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                controller: orderIdController,
                labelText: 'Order ID',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
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
                controller: employeeController,
                labelText: 'Employee',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                controller: reasonController,
                labelText: 'Reason',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CoustomTextFormFiled(
                controller: amountController,
                labelText: 'Amount',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Update Return Invoice',
                bgColor: Colors.blueGrey,
                onTap: updateReturnInvoice,
              ),
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
