import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/models/ReturnInvoice_model.dart';

class ReturnInvoiceListScreen extends StatelessWidget {
  final List<ReturnInvoice> returnInvoices;
  final Function(ReturnInvoice) onReturnInvoiceTap;
  final Function(int) onReturnInvoiceLongPress;

  const ReturnInvoiceListScreen({
    super.key,
    required this.returnInvoices,
    required this.onReturnInvoiceTap,
    required this.onReturnInvoiceLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Invoices List'),
      ),
      body: ListView.builder(
        itemCount: returnInvoices.length,
        itemBuilder: (context, index) {
          final returnInvoice = returnInvoices[index];
          return InkWell(
            onTap: () => onReturnInvoiceTap(returnInvoice),
            onLongPress: () => onReturnInvoiceLongPress(index),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${returnInvoice.orderId}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Reason: ${returnInvoice.reason}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Amount: \$${returnInvoice.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    'Amount: \$${returnInvoice.totalbackmony.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
