import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import '../../../l10n/app_localizations.dart';

class ProductsItemDetailsView extends StatelessWidget {
  final List<Order> orders;

  const ProductsItemDetailsView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('orderDetails')),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading:
                  const Icon(Icons.shopping_bag, size: 50, color: Colors.blue),
              title: Text(
                '${localizations.translate('id')}: ${order.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${localizations.translate('dateTime')}: ${order.dateTime}'),
                  Text('${localizations.translate('type')}: ${order.type}'),
                  Text(
                      '${localizations.translate('employee')}: ${order.employee}'),
                  Text('${localizations.translate('status')}: ${order.status}'),
                  Text(
                      '${localizations.translate('paymentStatus')}: ${order.paymentStatus}'),
                  Text(
                      '${localizations.translate('amount')}: ${order.amount.toString()}'),
                  Text(
                      '${localizations.translate('numberOfItems')}: ${order.numberOfItems.toString()}'),
                  Text(
                      '${localizations.translate('entryDate')}: ${order.entryDate}'),
                  Text(
                      '${localizations.translate('exitDate')}: ${order.exitDate}'),
                  Text(
                      '${localizations.translate('wholesalePrice')}: ${order.wholesalePrice.toString()}'),
                  Text(
                      '${localizations.translate('retailPrice')}: ${order.retailPrice.toString()}'),
                  Text(
                      '${localizations.translate('productStatus')}: ${order.productStatus}'),
                  Text(
                      '${localizations.translate('productDetails')}: ${order.productDetails}'),
                  Text(
                      '${localizations.translate('productModel')}: ${order.productModel}'),
                  Text(
                      '${localizations.translate('category')}: ${order.category}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Implement your delete functionality here
                },
              ),
              onTap: () {
                // Implement your onTap functionality here if needed
              },
            ),
          );
        },
      ),
    );
  }
}
