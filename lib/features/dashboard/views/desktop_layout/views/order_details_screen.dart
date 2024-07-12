import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
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
}
