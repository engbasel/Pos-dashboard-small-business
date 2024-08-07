import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter/services.dart' show rootBundle;

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.invoice});

  final Order invoice;

  Future<void> _exportPDF(
    BuildContext context, {
    required String invoiceText,
    required String customerNameText,
    required String dateText,
    required String invoiceNumberText,
    required String itemsText,
    required String noText,
    required String productText,
    required String quantityText,
    required String unitPriceText,
    required String totalText,
    required String discountText,
    required String taxText,
  }) async {
    try {
      final pdf = pw.Document();

      // Load the custom Arabic font
      final arabicFontData =
          await rootBundle.load('assets/fonts/Traditional-Arabic.ttf');
      final arabicFont = pw.Font.ttf(arabicFontData);

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '$invoiceText  #${invoice.invoiceNumber}',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    font: arabicFont,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
                pw.SizedBox(height: 16),
                pw.Text('$customerNameText: ${invoice.customerName}',
                    style: pw.TextStyle(font: arabicFont),
                    textDirection: pw.TextDirection.rtl),
                pw.Text('$dateText: ${invoice.invoiceDate}',
                    style: pw.TextStyle(font: arabicFont),
                    textDirection: pw.TextDirection.rtl),
                pw.Text('$invoiceNumberText: ${invoice.invoiceNumber}',
                    style: pw.TextStyle(font: arabicFont),
                    textDirection: pw.TextDirection.rtl),
                pw.SizedBox(height: 16),
                pw.Text('$itemsText:',
                    style: pw.TextStyle(font: arabicFont),
                    textDirection: pw.TextDirection.rtl),
                pw.SizedBox(height: 12),
                pw.Table.fromTextArray(
                  headers: [
                    noText,
                    productText,
                    quantityText,
                    unitPriceText,
                    totalText,
                    discountText,
                  ],
                  data: invoice.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return [
                      '${index + 1}',
                      item.name,
                      '${item.quantity}',
                      '\$${item.unitPrice}',
                      '\$${item.total}',
                      '\$${item.discount}',
                    ];
                  }).toList(),
                  cellStyle: pw.TextStyle(font: arabicFont),
                  headerStyle: pw.TextStyle(
                      font: arabicFont, fontWeight: pw.FontWeight.bold),
                  cellAlignment: pw.Alignment.centerRight,
                  columnWidths: {
                    0: const pw.FixedColumnWidth(30),
                    1: const pw.FixedColumnWidth(120),
                    2: const pw.FixedColumnWidth(50),
                    3: const pw.FixedColumnWidth(50),
                    4: const pw.FixedColumnWidth(50),
                    5: const pw.FixedColumnWidth(50),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerRight,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                  },
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                  '$taxText \$20',
                  style: pw.TextStyle(fontSize: 16, font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                ),
                pw.SizedBox(height: 16),
              ],
            );
          },
        ),
      );

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Select where to save the PDF',
        fileName: 'invoice_${invoice.invoiceNumber}.pdf',
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsBytes(await pdf.save());

        if (await file.exists()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF saved to ${file.path}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save PDF')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF export canceled')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Text(
            '${localizations.translate('Invoice')}  #${invoice.invoiceNumber}',
          ),
          const Spacer(),
          CustomSmallButton(
            onTap: () => _exportPDF(
              context,
              invoiceText: localizations.translate('Invoice'),
              customerNameText: localizations.translate('CustomerName'),
              dateText: localizations.translate('date'),
              invoiceNumberText: localizations.translate('InvoiceNumber'),
              itemsText: localizations.translate('Items'),
              noText: localizations.translate('No.'),
              productText: localizations.translate('Product'),
              quantityText: localizations.translate('Quantity'),
              unitPriceText: localizations.translate('UnitPrice'),
              totalText: localizations.translate('Total'),
              discountText: localizations.translate('Discount'),
              taxText: localizations.translate('Tax'),
            ),
            icon: Icons.print,
            text: 'pdf',
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${localizations.translate('CustomerName')}: ${invoice.customerName}'),
              Text(
                  '${localizations.translate('date')}: ${invoice.invoiceDate}'),
              Text(
                  '${localizations.translate('InvoiceNumber')}: ${invoice.invoiceNumber}'),
              const SizedBox(height: 12),
              Text('${localizations.translate('Items')}:'),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text(localizations.translate('No.'))),
                    DataColumn(label: Text(localizations.translate('Product'))),
                    DataColumn(
                        label: Text(localizations.translate('Quantity'))),
                    DataColumn(
                        label: Text(localizations.translate('UnitPrice'))),
                    DataColumn(label: Text(localizations.translate('Total'))),
                    DataColumn(
                        label: Text(localizations.translate('Discount'))),
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
              ),
              const SizedBox(height: 12),
              Text(
                '${localizations.translate('Tax')} \$20',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomSmallButton(
                    icon: Icons.close,
                    onTap: () => Navigator.of(context).pop(),
                    text: localizations.translate('Close'),
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
