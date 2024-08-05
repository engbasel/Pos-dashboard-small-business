import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class NeededProductsDetails extends StatelessWidget {
  final IncomingOrderModel product;

  const NeededProductsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('orderDetails'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('orderId'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.orderId),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('supplierName'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.supplierName),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('orderDate'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.orderDate),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate('expectedDeliveryDate'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.expectedDeliveryDate),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('orderStatus'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.orderStatus),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('totalAmount'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.totalAmount.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
