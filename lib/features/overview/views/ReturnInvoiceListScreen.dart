import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/ReturnInvoice_model.dart';

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
          return ListTile(
            title: Text(returnInvoice.orderId),
            subtitle: Text(returnInvoice.reason),
            trailing: Text('\$${returnInvoice.amount.toStringAsFixed(2)}'),
            onTap: () => onReturnInvoiceTap(returnInvoice),
            onLongPress: () => onReturnInvoiceLongPress(index),
          );
        },
      ),
    );
  }
}
