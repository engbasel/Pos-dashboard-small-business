import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/edit_return_invoice_item_view.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReturnInvoiceDetailScreen extends StatefulWidget {
  final ReturnInvoiceModel returnInvoice;

  const ReturnInvoiceDetailScreen({
    super.key,
    required this.returnInvoice,
  });

  @override
  State<ReturnInvoiceDetailScreen> createState() =>
      _ReturnInvoiceDetailScreenState();
}

class _ReturnInvoiceDetailScreenState extends State<ReturnInvoiceDetailScreen> {
  late ReturnInvoiceModel returnInvoice;

  @override
  void initState() {
    super.initState();
    returnInvoice = widget.returnInvoice;
  }

  void updateReturnInvoice(ReturnInvoiceModel updatedInvoice) {
    setState(() {
      returnInvoice = updatedInvoice;
    });
  }

  Future<void> generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice ID: ${returnInvoice.id}'),
              pw.SizedBox(height: 8),
              pw.Text('Order ID: ${returnInvoice.orderId}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  'Total Back Money: \$${returnInvoice.totalbackmony.toStringAsFixed(2)}'),
              pw.SizedBox(height: 8),
              pw.Text('Return Date: ${returnInvoice.returnDate}'),
              pw.SizedBox(height: 8),
              pw.Text('Employee: ${returnInvoice.employee}'),
              pw.SizedBox(height: 8),
              pw.Text('Reason: ${returnInvoice.reason}'),
              pw.SizedBox(height: 8),
              pw.Text('Amount: \$${returnInvoice.amount.toStringAsFixed(2)}'),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "ReturnInvoice_${returnInvoice.id}.pdf",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text('Return Invoice Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                CustomSmallButton(
                  icon: Icons.edit,
                  text: 'Edit',
                  onTap: () async {
                    final updatedInvoice = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditReturnInvoiceItemScreen(
                          returnInvoice: returnInvoice,
                          onUpdate: updateReturnInvoice,
                        ),
                      ),
                    );
                    if (updatedInvoice != null) {
                      updateReturnInvoice(
                          updatedInvoice); // Update the UI with the new data
                    }
                  },
                ),
                const SizedBox(width: 8),
                CustomSmallButton(
                  icon: Icons.print,
                  text: 'Print Order',
                  onTap: () => generatePdf(context),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetailRow('Invoice ID', returnInvoice.id),
            buildDetailRow('Order ID', returnInvoice.orderId),
            buildDetailRow('Total Back Money',
                '\$${returnInvoice.totalbackmony.toStringAsFixed(2)}'),
            buildDetailRow('Return Date', returnInvoice.returnDate),
            buildDetailRow('Employee', returnInvoice.employee),
            buildDetailRow('Reason', returnInvoice.reason),
            buildDetailRow(
                'Amount', '\$${returnInvoice.amount.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}