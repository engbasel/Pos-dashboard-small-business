import 'package:flutter/material.dart';

import 'SalesInvoice.dart';

class SalesInvoicesScreen extends StatelessWidget {
  const SalesInvoicesScreen({super.key, required this.invoices});

  final List<SalesInvoice> invoices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Invoices'),
      ),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return ListTile(
            title: Text('Invoice #${invoice.invoiceNumber}'),
            subtitle: Text('Customer: ${invoice.customerName}'),
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

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({super.key, required this.invoice});

  final SalesInvoice invoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice #${invoice.invoiceNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer Name: ${invoice.customerName}'),
            Text('Date: ${invoice.invoiceDate}'),
            Text('Invoice Number: ${invoice.invoiceNumber}'),
            const SizedBox(height: 12),
            const Text('Items:'),
            const SizedBox(height: 12),
            DataTable(
              columns: const [
                DataColumn(label: Text('No.')),
                DataColumn(label: Text('Product')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Unit Price')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Discount')),
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
            // Text(
            //   'Total Amount: \$${invoice.items.fold(0, (sum, item) => sum + item.total)}',
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 12),
            const Text(
              'Tax: \$20',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            // Text(
            //   'Grand Total: \$${invoice.items.fold(0, (sum, item) {sum}) + 20}',
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}
