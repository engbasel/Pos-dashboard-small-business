import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../l10n/app_localizations.dart';
import 'OrderDetailsScreen.dart';

class OrderListScreen extends StatelessWidget {
  final List<Order> orders;

  const OrderListScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('orderList')),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              _generateAllOrdersPdf(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: Text(localizations.translate('orderID'))),
            DataColumn(label: Text(localizations.translate('dateTime'))),
            DataColumn(label: Text(localizations.translate('orderType'))),
            DataColumn(label: Text(localizations.translate('employee'))),
            DataColumn(label: Text(localizations.translate('status'))),
            DataColumn(label: Text(localizations.translate('paymentStatus'))),
            DataColumn(label: Text(localizations.translate('amount'))),
            DataColumn(label: Text(localizations.translate('actions'))),
          ],
          rows: List<DataRow>.generate(orders.length, (index) {
            return DataRow(
              cells: [
                DataCell(
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(
                            order: orders[index],
                          ),
                        ),
                      );
                    },
                    child: Text(orders[index].id),
                  ),
                ),
                DataCell(Text(orders[index].dateTime)),
                DataCell(Text(orders[index].type)),
                DataCell(Text(orders[index].employee)),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: orders[index].status == 'Complete'
                          ? const Color(0xffE6F6E9)
                          : const Color(0xffFFB074).withOpacity(.15),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Text(
                      orders[index].status,
                      style: TextStyle(
                        color: orders[index].status == 'Complete'
                            ? const Color(0xff2CC56F)
                            : const Color(0xffFF9A00),
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    orders[index].paymentStatus,
                    style: const TextStyle(color: Color(0xff2CC56F)),
                  ),
                ),
                DataCell(Text('\$ ${orders[index].amount}')),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete
                      },
                    ),
                  ],
                )),
              ],
            );
          }),
        ),
      ),
    );
  }

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

  Future<void> _generateAllOrdersPdf(BuildContext context) async {
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
