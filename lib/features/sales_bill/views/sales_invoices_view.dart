import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/invoice_item_detail_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';

import '../../../l10n/app_localizations.dart';
import '../databases/sales_database_helper.dart';

class SalesInvoicesScreen extends StatefulWidget {
  const SalesInvoicesScreen({super.key, required this.invoices});

  final List<SalesInvoice> invoices;

  @override
  _SalesInvoicesScreenState createState() => _SalesInvoicesScreenState();
}

class _SalesInvoicesScreenState extends State<SalesInvoicesScreen> {
  late List<SalesInvoice> invoices;

  @override
  void initState() {
    super.initState();
    invoices = widget.invoices;
  }

  Future<void> deleteInvoice(int index) async {
    final invoice = invoices[index];
    await SalesDatabaseHelper.deleteInvoice(invoice.invoiceNumber);

    setState(() {
      invoices.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('SalesInvoices'),
        ),
      ),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return ListTile(
            title: Text(
                '  ${AppLocalizations.of(context).translate('Invoice')} #${invoice.invoiceNumber}'),
            subtitle: Text(
                '  ${AppLocalizations.of(context).translate('Customer')}: ${invoice.customerName}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                // Show a confirmation dialog before deletion
                final bool? confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)
                        .translate('ConfirmDelete')),
                    content: Text(
                        AppLocalizations.of(context).translate('AreYouSure')),
                    actions: [
                      TextButton(
                        child: Text(
                            AppLocalizations.of(context).translate('Cancel')),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text(
                            AppLocalizations.of(context).translate('Delete')),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  await deleteInvoice(index);
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InvoiceDetailScreen(invoice: invoice),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
