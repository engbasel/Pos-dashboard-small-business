import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos_dashboard_v1/features/overview/models/order_model.dart';
import 'package:printing/printing.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _generatePdf(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}'),
            const SizedBox(height: 8),
            Text('Date Time: ${order.dateTime}'),
            const SizedBox(height: 8),
            Text('Order Type: ${order.type}'),
            const SizedBox(height: 8),
            Text('Employee: ${order.employee}'),
            const SizedBox(height: 8),
            Text('Status: ${order.status}'),
            const SizedBox(height: 8),
            Text('Payment Status: ${order.paymentStatus}'),
            const SizedBox(height: 8),
            Text('Amount: \$${order.amount}'),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Order ID: ${order.id}'),
              pw.SizedBox(height: 8),
              pw.Text('Date Time: ${order.dateTime}'),
              pw.SizedBox(height: 8),
              pw.Text('Order Type: ${order.type}'),
              pw.SizedBox(height: 8),
              pw.Text('Employee: ${order.employee}'),
              pw.SizedBox(height: 8),
              pw.Text('Status: ${order.status}'),
              pw.SizedBox(height: 8),
              pw.Text('Payment Status: ${order.paymentStatus}'),
              pw.SizedBox(height: 8),
              pw.Text('Amount: \$${order.amount}'),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
        bytes: await pdf.save(), filename: "${order.employee}.pdf");
  }
}
