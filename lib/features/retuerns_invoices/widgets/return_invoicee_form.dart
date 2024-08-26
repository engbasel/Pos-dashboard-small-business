import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_text_form_field.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class ReturnInvoiceeForm extends StatefulWidget {
  const ReturnInvoiceeForm({super.key});

  @override
  State<ReturnInvoiceeForm> createState() => _ReturnInvoiceeFormState();
}

class _ReturnInvoiceeFormState extends State<ReturnInvoiceeForm> {
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
      Navigator.of(context).pop(true); // Return true when an invoice is added
      CustomSnackBar.show(context, 'Return Invoice added successfully');
    } catch (e) {
      CustomSnackBar.show(context, 'Error adding Return Invoice: $e');
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            CustomTextFormField(
              controller: idController,
              labelText: 'Invoice ID',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              controller: orderIdController,
              labelText: 'Order ID',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              controller: totalbackmonyController,
              labelText: 'Total Back Money',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
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
            CustomTextFormField(
              controller: employeeController,
              labelText: 'Employee',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              controller: reasonController,
              labelText: 'Reason',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              controller: amountController,
              labelText: 'Amount',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: AppLocalizations.of(context).translate('cancel'),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomButton(
                      text: AppLocalizations.of(context).translate('add'),
                      bgColor: ColorsManager.kPrimaryColor,
                      onTap: addReturnInvoice,
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
// s