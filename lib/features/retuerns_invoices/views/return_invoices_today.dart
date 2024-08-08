import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';

class ReturnInvoicesToday extends StatelessWidget {
  final Future<List<ReturnInvoiceModel>> returnInvoicesFuture;

  const ReturnInvoicesToday({super.key, required this.returnInvoicesFuture});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<ReturnInvoiceModel>>(
        future: returnInvoicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No return invoices found.'));
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final invoice = snapshot.data![index];
                return Container(
                  color: ColorsManager.backgroundColor,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoice ID : ${invoice.id}\n'
                        'Order ID : ${invoice.orderId}\n'
                        'Return Date : ${invoice.returnDate}\n'
                        'Employee : ${invoice.employee}\n'
                        'Reason : ${invoice.reason}\n'
                        'Amount : ${invoice.amount}\n'
                        'Total Back Money : ${invoice.totalbackmony}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
