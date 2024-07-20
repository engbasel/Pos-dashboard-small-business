import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/models/ReturnInvoice_model.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/database/database_Returnsinvoice.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/views/ReturnInvoiceListScreen.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/custom_form.dart';
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
  final TextEditingController totalbackmonyController = TextEditingController();

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
      totalbackmony: double.tryParse(totalbackmonyController.text) ?? 0,
    );

    try {
      await databaseHelper.insertReturnInvoice(newReturnInvoice);
      clearTextFields();
      loadReturnInvoices();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Return Invoice added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding Return Invoice: $e')),
      );
    }
  }

  Future<void> deleteReturnInvoice(String id) async {
    try {
      await databaseHelper.deleteReturnInvoice(id);
      await loadReturnInvoices();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Return Invoice deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting Return Invoice: $e')),
      );
    }
  }

  void clearTextFields() {
    idController.clear();
    orderIdController.clear();
    returnDateController.clear();
    employeeController.clear();
    reasonController.clear();
    amountController.clear();
    totalbackmonyController.clear();
  }

  void navigateToReturnInvoiceListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReturnInvoiceListScreen(
          returnInvoices: returnInvoices,
          onUpdateList: loadReturnInvoices,
          onDeleteInvoice: (String id) {
            deleteReturnInvoice(id);
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
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: orderIdController,
                labelText: 'Order ID',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: totalbackmonyController,
                labelText: 'Total Back Money',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
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
