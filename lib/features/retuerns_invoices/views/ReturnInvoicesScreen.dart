import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';

class ReturnInvoicesScreen extends StatelessWidget {
  final Future<List<ReturnInvoiceModel>> returnInvoicesFuture;

  const ReturnInvoicesScreen({super.key, required this.returnInvoicesFuture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Invoices'),
      ),
      body: FutureBuilder<List<ReturnInvoiceModel>>(
        future: returnInvoicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No return invoices found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final invoice = snapshot.data![index];
                return ListTile(
                  title: Text('Invoice ID: ${invoice.id}'),
                  subtitle: Text(
                    'Order ID: ${invoice.orderId}\n'
                    'Return Date: ${invoice.returnDate}\n'
                    'Employee: ${invoice.employee}\n'
                    'Reason: ${invoice.reason}\n'
                    'Amount: ${invoice.amount}\n'
                    'Total Back Money: ${invoice.totalbackmony}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
