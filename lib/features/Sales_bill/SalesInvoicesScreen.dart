import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/Sales_bill/InvoiceItemDetailScreen.dart';

import '../../l10n/app_localizations.dart';
import 'SalesInvoice.dart';

class SalesInvoicesScreen extends StatelessWidget {
  const SalesInvoicesScreen({super.key, required this.invoices});

  final List<SalesInvoice> invoices;

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
