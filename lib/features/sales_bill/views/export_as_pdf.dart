import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_item_model.dart';
import 'package:pdf/widgets.dart' as pw;

void exportAsPDF(
  BuildContext context,
  String customerName,
  String dateTime,
  String invoiceNumber,
  List<SalesItem> items,
  double totalAmount,
  double grandTotal,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Invoice', style: const pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 24),
            pw.Text('Customer Name: $customerName'),
            pw.Text('Date and Time: $dateTime'),
            pw.Text('Invoice Number: $invoiceNumber'),
            pw.SizedBox(height: 24),
            pw.Table.fromTextArray(
              headers: ['No.', 'Product', 'Quantity', 'Unit Price', 'Total'],
              data: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return [
                  '${index + 1}',
                  item.name,
                  '${item.quantity}',
                  '\$${item.unitPrice}',
                  '\$${item.total}',
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 24),
            pw.Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}'),
            pw.Text('Tax: \$20.00'),
            pw.Text('Grand Total: \$${grandTotal.toStringAsFixed(2)}'),
          ],
        );
      },
    ),
  );

  final output = await getApplicationDocumentsDirectory();
  final file = File('${output.path}/invoice.pdf');
  await file.writeAsBytes(await pdf.save());

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('PDF exported to ${file.path}')),
  );
}
