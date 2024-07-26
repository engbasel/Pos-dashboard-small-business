import 'package:flutter/material.dart';

import '../../../core/utils/models/order_model.dart';

class OrdersTablItemseScreen extends StatelessWidget {
  final List<Order> orders;

  const OrdersTablItemseScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Table'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Date and Time')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Employee')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Payment Status')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Number of Items')),
              DataColumn(label: Text('Entry Date')),
              DataColumn(label: Text('Exit Date')),
              DataColumn(label: Text('Wholesale Price')),
              DataColumn(label: Text('Retail Price')),
              DataColumn(label: Text('Product Status')),
              DataColumn(label: Text('Product Details')),
              DataColumn(label: Text('Product Model')),
              DataColumn(label: Text('Category')),
            ],
            rows: orders.map((order) {
              return DataRow(cells: [
                DataCell(Text(order.id)),
                DataCell(Text(order.dateTime)),
                DataCell(Text(order.type)),
                DataCell(Text(order.employee)),
                DataCell(Text(order.status)),
                DataCell(Text(order.paymentStatus)),
                DataCell(Text(order.amount.toString())),
                DataCell(Text(order.numberOfItems.toString())),
                DataCell(Text(order.entryDate)),
                DataCell(Text(order.exitDate)),
                DataCell(Text(order.wholesalePrice.toString())),
                DataCell(Text(order.retailPrice.toString())),
                DataCell(Text(order.productStatus)),
                DataCell(Text(order.productDetails)),
                DataCell(Text(order.productModel)),
                DataCell(Text(order.category)),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
