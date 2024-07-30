import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_detail_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoicee_form.dart';
import '../../../l10n/app_localizations.dart';

class ReturnInvoiceScreen extends StatefulWidget {
  const ReturnInvoiceScreen({super.key});

  @override
  State<ReturnInvoiceScreen> createState() => _ReturnInvoiceScreenState();
}

class _ReturnInvoiceScreenState extends State<ReturnInvoiceScreen> {
  final DatabaseReturnsInvoice databaseHelper = DatabaseReturnsInvoice();
  List<ReturnInvoiceModel> returnInvoices = [];

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

  void showAddReturnInvoiceForm(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * .5,
            child: const ReturnInvoiceeForm(),
          ),
        );
      },
    );

    if (result == true) {
      loadReturnInvoices();
    }
  }

  void navigateToReturnInvoiceDetailScreen(ReturnInvoiceModel invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ReturnInvoiceDetailScreen(
            returnInvoice: invoice,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).translate('returnInvoices'),
            actions: [
              CustomSmallButton(
                icon: Icons.add,
                text: AppLocalizations.of(context).translate('addReturn'),
                onTap: () => showAddReturnInvoiceForm(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...returnInvoices.map(
            (invoice) => Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(6),
              child: ListTile(
                title: Text(
                    '${AppLocalizations.of(context).translate('invoiceId')}: ${invoice.id}'),
                subtitle: Text(
                    '${AppLocalizations.of(context).translate('orderId')}: ${invoice.orderId}'),
                onTap: () => navigateToReturnInvoiceDetailScreen(invoice),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
