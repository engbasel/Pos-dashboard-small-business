import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import 'package:printing/printing.dart';

class OrderService {
  Future<void> generatePdf(BuildContext context, Order order) async {
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
      bytes: await pdf.save(),
      filename: "${order.employee}.pdf",
    );
  }

  Future<void> generateAllOrdersPdf(BuildContext context, orders) async {
    final pdf = pw.Document();
    // ignore: unused_local_variable
    final localizations = AppLocalizations.of(context);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: orders.map((order) {
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
                  pw.Divider(),
                ],
              );
            }).toList(),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "all_orders.pdf",
    );
  }
}
