import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_list_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_detail_view.dart';
import '../../../core/widgets/custom_button.dart';
import '../../dashboard/widgets/custom_text_form_field.dart';

class ReturnInvoiceScreen extends StatefulWidget {
  const ReturnInvoiceScreen({super.key});

  @override
  State<ReturnInvoiceScreen> createState() => _ReturnInvoiceScreenState();
}

class _ReturnInvoiceScreenState extends State<ReturnInvoiceScreen> {
  final DatabaseReturnsInvoice databaseHelper = DatabaseReturnsInvoice();
  List<ReturnInvoiceModel> returnInvoices = [];

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
    final newReturnInvoice = ReturnInvoiceModel(
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
      CustomSnackBar.show(context, 'Return Invoice added successfully');
    } catch (e) {
      CustomSnackBar.show(context, 'Error adding Return Invoice: $e');
    }
  }

  Future<void> deleteReturnInvoice(String id) async {
    try {
      await databaseHelper.deleteReturnInvoice(id);
      await loadReturnInvoices();
      CustomSnackBar.show(context, 'Return Invoice deleted successfully');
    } catch (e) {
      CustomSnackBar.show(context, 'Error deleting Return Invoice: $e');
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

  void showAddReturnInvoiceForm(BuildContext context) {
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
                CoustomTextFormFiled(
                  controller: idController,
                  labelText: 'Invoice ID',
                  keyboardType: TextInputType.text,
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
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
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
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
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
                          bgColor: const Color(0xff4985FF),
                          onTap: clearTextFields,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CustomButton(
                          text: 'Add Return Invoice',
                          bgColor: const Color(0xff4985FF),
                          onTap: addReturnInvoice,
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

  void navigateToReturnInvoiceDetailScreen(ReturnInvoiceModel invoice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReturnInvoiceDetailScreen(
          returnInvoice: invoice,
        ),
      ),
    ).then((_) {
      // Refresh the list after coming back from the detail screen
      loadReturnInvoices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Invoices'),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.list),
        //     onPressed: navigateToReturnInvoiceListScreen,
        //   ),
        // ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...returnInvoices.map((invoice) => ListTile(
                    title: Text('Invoice ID: ${invoice.id}'),
                    subtitle: Text('Order ID: ${invoice.orderId}'),
                    onTap: () => navigateToReturnInvoiceDetailScreen(invoice),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddReturnInvoiceForm(context),
        tooltip: 'Add Return Invoice',
        backgroundColor: const Color(0xff4985FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
