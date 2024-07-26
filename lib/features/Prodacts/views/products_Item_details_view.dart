import 'package:flutter/material.dart';
import '../../../core/utils/models/order_model.dart';
import '../../../l10n/app_localizations.dart';

class OrderDetailsScreen extends StatelessWidget {
  final List<Order> orders;

  const OrderDetailsScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('id')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text(localizations.translate('id'))),
              DataColumn(label: Text(localizations.translate('dateTime'))),
              DataColumn(label: Text(localizations.translate('type'))),
              DataColumn(label: Text(localizations.translate('employee'))),
              DataColumn(label: Text(localizations.translate('status'))),
              DataColumn(label: Text(localizations.translate('paymentStatus'))),
              DataColumn(label: Text(localizations.translate('amount'))),
              DataColumn(label: Text(localizations.translate('numberOfItems'))),
              DataColumn(label: Text(localizations.translate('entryDate'))),
              DataColumn(label: Text(localizations.translate('exitDate'))),
              DataColumn(
                  label: Text(localizations.translate('wholesalePrice'))),
              DataColumn(label: Text(localizations.translate('retailPrice'))),
              DataColumn(label: Text(localizations.translate('productStatus'))),
              DataColumn(
                  label: Text(localizations.translate('productDetails'))),
              DataColumn(label: Text(localizations.translate('productModel'))),
              DataColumn(label: Text(localizations.translate('category'))),
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
