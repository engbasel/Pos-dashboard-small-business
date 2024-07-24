import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/salesBill/model/sales_invoice.dart';

import '../../../l10n/app_localizations.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({super.key, required this.invoice});

  final SalesInvoice invoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${AppLocalizations.of(context).translate('Invoice')}  #${invoice.invoiceNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                ' ${AppLocalizations.of(context).translate('CustomerName')}: ${invoice.customerName}'),
            Text(
                '${AppLocalizations.of(context).translate('Date')}: ${invoice.invoiceDate}'),
            Text('Invoice Number: ${invoice.invoiceNumber}'),
            const SizedBox(height: 12),
            Text('${AppLocalizations.of(context).translate('Items')}:'),
            const SizedBox(height: 12),
            DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  AppLocalizations.of(context).translate('No.'),
                )),
                DataColumn(
                  label: Text(
                    AppLocalizations.of(context).translate('Product'),
                  ),
                ),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('Quantity'))),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('UnitPrice'))),
                DataColumn(
                    label:
                        Text(AppLocalizations.of(context).translate('Total'))),
                DataColumn(
                    label: Text(
                        AppLocalizations.of(context).translate('Discount'))),
              ],
              rows: invoice.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}')),
                    DataCell(Text(item.name)),
                    DataCell(Text('${item.quantity}')),
                    DataCell(Text('\$${item.unitPrice}')),
                    DataCell(Text('\$${item.total}')),
                    DataCell(Text('\$${item.discount}')),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 12),
            Text(
              '${AppLocalizations.of(context).translate('Tax')} \$20',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
